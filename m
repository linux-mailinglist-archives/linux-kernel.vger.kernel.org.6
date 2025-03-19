Return-Path: <linux-kernel+bounces-568018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50108A68CF4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 13:33:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79B7717FBDF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 12:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A54F256C98;
	Wed, 19 Mar 2025 12:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b="hjgKVuEB"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011070.outbound.protection.outlook.com [52.101.70.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339A225744B;
	Wed, 19 Mar 2025 12:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742387489; cv=fail; b=tabVWmZXUA1sA1cdRL4OSnnb8RlieXd0xiD8hB/6fj9GFSwzime3H4X4o/Lyi19tbj5Cozti8GsqZ3QXmBgjUDOmLj2JWOOh6NXSPG5Apj2b5uYliVSVBH/Tu02XQlNUneCBRTNqVUzywkGwINsMl/pDIEwdF+Zj2cOIJRNNxNM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742387489; c=relaxed/simple;
	bh=kJqtGuW7ZAvstDHYDti4Wrl4VJ57AC8EUWoR7yT6lf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gIhH6e4/2fhgqllveQiHyLw4jNzlmBoV8pslYDEePYqE+hf63ceG/ymd+IURTX0e8yWCE2kOyti4IUMliqdEXB9RkqfqT16CRW5AFwXDRVb8BdJfckMhk5dyRaNmedAdN62WrbgfxgkjsaPXgIaDOCDVaRwH/Lxet/PgKyJxkyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk; spf=pass smtp.mailfrom=prevas.dk; dkim=pass (1024-bit key) header.d=prevas.dk header.i=@prevas.dk header.b=hjgKVuEB; arc=fail smtp.client-ip=52.101.70.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ea5fbR9/X2WHpRr4vm4tiQt2LfODo7y8Nu00EVtm27Pg0sUui9XsrXQ4lyx/uYpJWLf6g8bQcQccppaI82fH+GScSdQSfjCF8PrONnLZJss1aYZdZP25wpu2ijDtS/WY2L7zGpMF541qJX2LEYdVh5okoc7UJWb6fR6dAtlvndIsDOsadrro+bPApmkX+58GpU5dHd+ZLyU6vRAyNlSCP2wrPBch+aJzAhWLmulIQi431dDpNkrwMJXal+LjPGku5jMr2jkWMDBu8DuhpTVd7+IG+GIVs+ML/Cb5MCw2UP1rEi1hNlsVGzjE5F8p3rxUWNLJ+MZrY2iQru0HHGY7+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SoQ2mmcCqjOG9k/GuV/8j0xB497IgQ0pvFakQtTeooQ=;
 b=aj64SzS9WGSJIgdxg8YaVLZv4Vt5v0z9g/H3wwHmZwDtmEYljSFWVlHQMAQxKzPptnQs9mk6QUImt5iooAnOSoaBQxjJsTBKL+dCENFYtDjFs1NYOIoA8kr/kyFp83xES3KW9ncyj7zZ1V/DYYlThA3ZRfQ89Y5eKIlI3txwjUxYJRnCok4Hg5snj5hZcqyveK8hseU1vbZcRu09lLQ2u+uehGEZUWdXacRUjVUP+SC6zMMEb7ecesU58fjbHWLtCc9+ev0aOJX2c3iwIMmbSLxNoDI6U4zBQoOo3AlvhF6zXO/gGdSJfo5Y0uTUG0BpGFJJ7Cu09JLfzCfVQ+ZfwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SoQ2mmcCqjOG9k/GuV/8j0xB497IgQ0pvFakQtTeooQ=;
 b=hjgKVuEB3f4dlC0SRqmv+HFPbaU9Q6cN0n39jBJRi5+1UrnHxJh48/pawrwqZPK2DsNARQyNmLZqaNMuFEytHPNMPex7Qo9/VEa6YgwpXhbWzKuefW7brQjU801QC60rfyxvkrhuoZQPtc2N3HRmWsfIZHcqeMGsSHqJEsEXbpA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:41::17)
 by PAWPR10MB6856.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:33c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Wed, 19 Mar
 2025 12:31:18 +0000
Received: from DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7e2c:5309:f792:ded4]) by DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7e2c:5309:f792:ded4%5]) with mapi id 15.20.8534.031; Wed, 19 Mar 2025
 12:31:18 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Colin Foster <colin.foster@in-advantage.com>,
	Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Felix Blix Everberg <felix.blix@prevas.dk>,
	Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH 7/8] mfd: ocelot: enable support for mdio management
Date: Wed, 19 Mar 2025 13:30:57 +0100
Message-ID: <20250319123058.452202-8-ravi@prevas.dk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250319123058.452202-1-ravi@prevas.dk>
References: <20250319123058.452202-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0099.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::12) To DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:41::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR10MB2475:EE_|PAWPR10MB6856:EE_
X-MS-Office365-Filtering-Correlation-Id: cfae93fe-26f9-4527-8f22-08dd66e1f2ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?E95oD0Avs3hfVAscoQ2N419qMaab2oHuQSSidzoOqriFjebAOpZF0gMPyBbV?=
 =?us-ascii?Q?RkU7d9NxVGVzTB/gOL+yynYeSXFfGCmyAhxb+rueJjWK4N9hFTTS1L3BvMWZ?=
 =?us-ascii?Q?gpmcd+BDCjquPqi1BO7z6xr4SnmJd8zqHN+0xKcc7LqtmWNk8nhbVSEihynE?=
 =?us-ascii?Q?FJ78qlnA/s5QhYEqD3TWVeEAm1LDDJBmauWQy0O/7vxCOjvgcoDHkmaDW6pf?=
 =?us-ascii?Q?XgITLfdUxVrsP6lPE0PwySnh8mOojj42Cjouc60Xw7hr8iapVHDz6DS+i85N?=
 =?us-ascii?Q?cO4x958kdmXi7D1rKfanE3H1OZpzk2WNNrY7nupDVMx4ddSsgFYUPph92nNl?=
 =?us-ascii?Q?JpBp3V+VjpI9rZWiFMDxCkiMNXEzDEGTEvNSBsg1ftskkYifT/oAUwFmoc8R?=
 =?us-ascii?Q?rbGnJxdhJVn0l7iw9hzHRS647NP95LudzuvV0vfyYvEdD52KK+71pNE9AGlL?=
 =?us-ascii?Q?HJxLhZAh1Y9SCPIvRzzQhFXuvVEDADo/U/Aa+OUjbUUJn3XrfQTkQqyFd4W7?=
 =?us-ascii?Q?ltVkgo/rBdMrsxSBOaBrPdX3Xmks/A8tuT0q+aTNaid3yZkKyvnwbhfr9nEd?=
 =?us-ascii?Q?C4bVxKgnL2SMyqYL2sm8OBK/8OMyWAv+JHERE65DmwmBagACX2Hccjxm62UZ?=
 =?us-ascii?Q?zyDLyohjUseDPVHKYkmc7WonXndJgdhzVYIjpaARH2Pxkk80/CMYCi6tGQ+l?=
 =?us-ascii?Q?9MNLPgeN4YWZD+WZ6Zs4bC47mqw8LAUcAnpUJmukRaqO5IboYYyUZf/ZRWk3?=
 =?us-ascii?Q?qGv2I0q5hYkhlcZ4g0m63vLuXmI0VjJ3cqxmTolwDK8YzzphHaPNWKH1REij?=
 =?us-ascii?Q?3IdWCakvXCX/3IMDXZdj9EMZABAEu9GbL812TOxCauoQvadBWwhZ+5Sfnc8r?=
 =?us-ascii?Q?m89eNknVQmEQOe0H79GjTIq2Xl77HVtCyAzuIg4koYzPyhzXcalBej5o7Th8?=
 =?us-ascii?Q?kd3Oqxmbu8JgL51Yvx+gWZNfswQz9ll8jbovG7ulQbZPNqTCMDL/KAuigymM?=
 =?us-ascii?Q?vIG053MMLN9Nf/RHuEcwA8cDpOjGzp6oQovtuGkkv/qDIpsIwdIBBTIVuJyX?=
 =?us-ascii?Q?7AOEg4od0wFnu2MeT+MPLqR40C2aSwUWsEO6ETMesqQUdvXIqQCFo8Kzmhe2?=
 =?us-ascii?Q?JEEstdr6d3i3qRaL1vHA4J4w+1qYX1U129cuP1nSinr13YB0fWKXArUFYwhX?=
 =?us-ascii?Q?JI61k55nZx1QCub4M2CgnSV0SMct8aBn/e5gZ6/cK2G3yEmZRKhf0fU9WD7y?=
 =?us-ascii?Q?dCS4WPcjLDLHUBaftrRMNSydt80e97dNV8BrR8pj8s/M5mDUKZJJxd3DtsYP?=
 =?us-ascii?Q?CGXEchbRRnGizsyZ6g/5Rm9mW40/G/+yh7AaRf8mKC6Zoyqxu1tSf9LFuaxH?=
 =?us-ascii?Q?iRICfXZ7FZ25BZNIhw7j5NSF1ZfK0rZ2vGDGpvMJyaG5kQRNxmBfq7PcM0Kk?=
 =?us-ascii?Q?E74dLcYWhk0t/BwKWzOhtdRaFXKf2bk3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lmvg3DWnvdsfHgLi6V9UeLRVYgSXyI3oZ5bRBo9jdZtiUtDpnQDcd1M/+VPm?=
 =?us-ascii?Q?xPLMKwO4qtQo5SfQoxVlf2XaEpE99OYzQI6lGpSjo9Qc937ZLWa58SZ63Ra5?=
 =?us-ascii?Q?DPeq2EcWnEyFopGVNyGq1aMdBYMqyhTVbsJXs3vUbjh3R7IocmFxESMn68Ug?=
 =?us-ascii?Q?x1EgtYYq3xX53MPz30l7DlL2aWV+7oU2i/TqJupXr/2QUzN678uTcIwXv6wB?=
 =?us-ascii?Q?UiE4igpakIUR6l3U+xgfKhoWda/V2FHkXoqhEh0VKpxKqkUbf4lKeDwaxbHm?=
 =?us-ascii?Q?OcN9NyMGNlMqN7Ve5OfzCdCPxa+lFUi+7pcNnRF3NOvyjvD4VztnE3TPwtA/?=
 =?us-ascii?Q?tXnifi5x0Fgh+mtbP1OpCc4zPyU6e7/aqANOf79K5rh816CKH6Ii1Wn81689?=
 =?us-ascii?Q?V4x31k2Dzc4YXSoPpf5G/Q9IewO0nDUExGTvVObmsvuCIPCI4ZsU5WUkPqTy?=
 =?us-ascii?Q?Lx16gzyY6+K5o0jF9cgvhJj+B6hsP9FQLHKq/q4v1LwCfccD5H11jzb8rIYh?=
 =?us-ascii?Q?o3Fjz+Ep4OjtDC8W0oFNO7Y+5NnlpLNQxwDdW7nkiWx95pOc75F+7F3Q5ZJy?=
 =?us-ascii?Q?s8HFYLBjsiF59P1zNUvojFTgG42Sk8UAew1CmSOm6F6wbgIm982G7fIOlUyy?=
 =?us-ascii?Q?DkVxml2eg87XzmsMNEZMxagoUBTQZQliQjFgJMV9DubE4Yl41ANVjA/utKkz?=
 =?us-ascii?Q?MRcjfYx9NgpSbjrJ7v2LyqnShUrUlj3VbOQvBT/e/p0h7LZkbv9Uyc0wnqyh?=
 =?us-ascii?Q?sEmUanXgjLg+kRr27U82hjxgtk0dHzPQdEkN7vH3jYU44EDmjTKywlFAYMLF?=
 =?us-ascii?Q?JUmU6CAGRWbe0NehaUuu7y6InCzIaAgaKi7gammCYYl7bfdpZQKUgls4N3Bd?=
 =?us-ascii?Q?CUM3MNpPPWwhqG5+9pcYaF2JoGfzjfwP2txhtkj1+2c99zQzneO2Tn8kSkec?=
 =?us-ascii?Q?KpurPmvGxOrk7rm4owY1D2MdAfcpeGjCh8QJY6znJ2/DCM0qk0UYBntogKWu?=
 =?us-ascii?Q?eg6X+xujnkLUJoFwW6HcPZmRBz6PRSDSOo6iThpo7wC5aTsDOzgEV/hdP9MS?=
 =?us-ascii?Q?0FcWoKrrg1p5RgjZpMdtyM1jO0glKiq8wFAHz8f6HJRZcmq2E8UpOMivFu60?=
 =?us-ascii?Q?OQ4ZqDd4sW+lrlvfPtE+4junyxY7DXIoJ0yDcVtfrJwVD4O5bUQIGOD1Es+/?=
 =?us-ascii?Q?Sv1Y15WeMRYX/qjUcDkeQnxa0Pb5lDHqn76j6PmylXWYLL99fM7Ti7/qv6+E?=
 =?us-ascii?Q?nU5lJp5GC3UtQorbaB1VflkstdUXmBTj5wZQgkmamN2usqnjDRnjQsAlBIi0?=
 =?us-ascii?Q?+DiJW+MaTZY5Mv6HMDyqLXZWlgE5x2X8LVG7wrPjJJj6tI69EKRaG4mEunCo?=
 =?us-ascii?Q?6SaFqv3ELRQkxM8kvIqV83m7y6semRONag3d8qn5GNvibvVQvj8rh4Ml9BtM?=
 =?us-ascii?Q?/QaR3gKIdNsm8ajc8OczTf8I8hAyyDibjiN8S4KF+x0liFo76YdS7L28rp7b?=
 =?us-ascii?Q?Y7aYCFIRMFrh/TpbTz9YPwgPxU1yw5wbSAr8c1SHBrXWUB5VKaB3ggxTIqFJ?=
 =?us-ascii?Q?Gxf0gLWVmA7RxeC7di6gVDAazRL9J8aJfWQqm4pUvLR/lHqJlZXsi1Ii0/uZ?=
 =?us-ascii?Q?qg=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: cfae93fe-26f9-4527-8f22-08dd66e1f2ab
X-MS-Exchange-CrossTenant-AuthSource: DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 12:31:18.3818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BgzhPzIzDRNsV2U3FWwbqfArLHRPJYUTzgmRlDwZroD9BA78eHwJMN7KaDB3C/NTB1rO8gk0bOrCxZPBq64AUyFJPyqac6uVOptMeGNmrY4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB6856

The implementation is rather straight-forward, following section
3.5.3 (MIIM interface in slave mode) in the data sheet for the
vsc7514.

Since each register access requires multiple MDIO accesses, keep the
parent mii_bus locked for the whole read/write in order that accesses
by different sub-devices do not end up corrupting each other. Since
the MFD among other things exposes an mdio bus to the switch's
internal PHYs, use MDIO_MUTEX_NESTED.

Looking through the data sheets of all of VSC7511, VSC7512, VSC7513,
VSC7514, I haven't seen any indication that they can be controlled
over I2C, so drop that mention from the Kconfig help text and add MDIO
in its place.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 drivers/mfd/Kconfig       |   3 +-
 drivers/mfd/Makefile      |   2 +-
 drivers/mfd/ocelot-mdio.c | 161 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 164 insertions(+), 2 deletions(-)
 create mode 100644 drivers/mfd/ocelot-mdio.c

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 4dc894061b62e..c062563794d9e 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1048,6 +1048,7 @@ config MFD_MENF21BMC
 config MFD_OCELOT
 	tristate "Microsemi Ocelot External Control Support"
 	depends on SPI_MASTER
+	select PHYLIB
 	select MFD_CORE
 	select REGMAP
 	help
@@ -1056,7 +1057,7 @@ config MFD_OCELOT
 	  other functions, including pinctrl, MDIO, and communication with
 	  external chips. While some chips have an internal processor capable of
 	  running an OS, others don't. All chips can be controlled externally
-	  through different interfaces, including SPI, I2C, and PCIe.
+	  through different interfaces, including SPI, MDIO, and PCIe.
 
 	  Say yes here to add support for Ocelot chips (VSC7511, VSC7512,
 	  VSC7513, VSC7514) controlled externally.
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 9220eaf7cf125..fc675ddd59f17 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -123,7 +123,7 @@ obj-$(CONFIG_MFD_MC13XXX_I2C)	+= mc13xxx-i2c.o
 
 obj-$(CONFIG_MFD_CORE)		+= mfd-core.o
 
-ocelot-soc-objs			:= ocelot-core.o ocelot-spi.o
+ocelot-soc-objs			:= ocelot-core.o ocelot-spi.o ocelot-mdio.o
 obj-$(CONFIG_MFD_OCELOT)	+= ocelot-soc.o
 
 obj-$(CONFIG_EZX_PCAP)		+= ezx-pcap.o
diff --git a/drivers/mfd/ocelot-mdio.c b/drivers/mfd/ocelot-mdio.c
new file mode 100644
index 0000000000000..7ac232a1ad6ad
--- /dev/null
+++ b/drivers/mfd/ocelot-mdio.c
@@ -0,0 +1,161 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * MIIM core driver for the Ocelot chip family.
+ */
+
+/*
+ * Each register access requires multiple MDIO accesses.
+ */
+
+#include <linux/device.h>
+#include <linux/mdio.h>
+#include <linux/phy.h>
+#include <linux/regmap.h>
+
+#include "ocelot.h"
+
+#define ADDR_REG0 0
+#define ADDR_REG1 1
+#define DATA_REG0 2
+#define DATA_REG1 3
+
+static int
+ocelot_mdio_write_addr(struct mdio_device *mdiodev, unsigned int addr)
+{
+	int ret;
+
+	addr &= 0x00ffffff;
+	addr >>= 2;
+
+	ret = __mdiodev_write(mdiodev, ADDR_REG0, addr & 0xffff);
+	if (ret)
+		return ret;
+
+	return __mdiodev_write(mdiodev, ADDR_REG1, addr >> 16);
+}
+
+static int
+__ocelot_mdio_write(void *context, unsigned int reg, unsigned int val)
+{
+	struct mdio_device *mdiodev = context;
+	int ret;
+
+	ret = ocelot_mdio_write_addr(mdiodev, reg);
+	if (ret)
+		return ret;
+
+	ret = __mdiodev_write(mdiodev, DATA_REG0, val & 0xffff);
+	if (ret)
+		return ret;
+
+	return __mdiodev_write(mdiodev, DATA_REG1, val >> 16);
+}
+
+static int
+__ocelot_mdio_read(struct mdio_device *mdiodev, unsigned int reg, unsigned int *val)
+{
+	int ret, lo, hi, i;
+
+	ret = ocelot_mdio_write_addr(mdiodev, reg);
+	if (ret)
+		return ret;
+
+	/*
+	 * The data registers must be read twice. Only after the first
+	 * read is the value of the register whose address was written
+	 * into the address registers latched into the data registers.
+	 */
+	for (i = 0; i < 2; ++i) {
+		lo = __mdiodev_read(mdiodev, DATA_REG0);
+		if (lo < 0)
+			return lo;
+		hi = __mdiodev_read(mdiodev, DATA_REG1);
+		if (hi < 0)
+			return hi;
+	}
+
+	*val = (hi << 16) | (lo & 0xffff);
+
+	return 0;
+}
+
+static int
+ocelot_mdio_write(void *context, unsigned int reg, unsigned int val)
+{
+	struct mdio_device *mdiodev = context;
+	int ret;
+
+	mutex_lock_nested(&mdiodev->bus->mdio_lock, MDIO_MUTEX_NESTED);
+	ret = __ocelot_mdio_write(mdiodev, reg, val);
+	mutex_unlock(&mdiodev->bus->mdio_lock);
+
+	return ret;
+}
+
+static int
+ocelot_mdio_read(void *context, unsigned int reg, unsigned int *val)
+{
+	struct mdio_device *mdiodev = context;
+	int ret;
+
+	mutex_lock_nested(&mdiodev->bus->mdio_lock, MDIO_MUTEX_NESTED);
+	ret = __ocelot_mdio_read(mdiodev, reg, val);
+	mutex_unlock(&mdiodev->bus->mdio_lock);
+
+	return ret;
+}
+
+static const struct regmap_bus ocelot_mdio_regmap_bus = {
+	.reg_write = ocelot_mdio_write,
+	.reg_read = ocelot_mdio_read,
+};
+
+static struct regmap *ocelot_mdio_init_regmap(struct device *dev, const struct resource *res)
+{
+	struct mdio_device *mdiodev = to_mdio_device(dev);
+	struct regmap_config regmap_config = {};
+
+	regmap_config.reg_bits = 32;
+	regmap_config.reg_stride = 4;
+	regmap_config.val_bits = 32;
+	regmap_config.name = res->name;
+	regmap_config.max_register = resource_size(res) - 1;
+	regmap_config.reg_base = res->start;
+
+	return devm_regmap_init(dev, &ocelot_mdio_regmap_bus, mdiodev, &regmap_config);
+}
+
+static int ocelot_mdio_probe(struct mdio_device *mdiodev)
+{
+	struct device *dev = &mdiodev->dev;
+	struct ocelot_ddata *ddata;
+
+	ddata = devm_kzalloc(dev, sizeof(*ddata), GFP_KERNEL);
+	if (!ddata)
+		return -ENOMEM;
+
+	dev_set_drvdata(dev, ddata);
+	ddata->init_regmap = ocelot_mdio_init_regmap;
+
+	return ocelot_core_init(dev);
+}
+
+static const struct of_device_id ocelot_mdio_of_match[] = {
+	{ .compatible = "mscc,vsc7512" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ocelot_mdio_of_match);
+
+static struct mdio_driver ocelot_mdio_driver = {
+	.probe = ocelot_mdio_probe,
+	.mdiodrv.driver = {
+		.name = "ocelot-soc",
+		.of_match_table = ocelot_mdio_of_match,
+	},
+};
+mdio_module_driver(ocelot_mdio_driver);
+
+MODULE_DESCRIPTION("MDIO Controlled Ocelot Chip Driver");
+MODULE_AUTHOR("Rasmus Villemoes <ravi@prevas.dk>");
+MODULE_LICENSE("Dual MIT/GPL");
+MODULE_IMPORT_NS("MFD_OCELOT");
-- 
2.49.0


