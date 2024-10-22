Return-Path: <linux-kernel+bounces-376926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DEF79AB792
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 22:24:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27CA5284064
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 20:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C267C1CC148;
	Tue, 22 Oct 2024 20:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iuFeAIg/"
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2076.outbound.protection.outlook.com [40.107.103.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0761413E41A;
	Tue, 22 Oct 2024 20:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729628653; cv=fail; b=qyvYz4czYCqXlot/QIiDBXO/HAak7eaXu3sgxB/fAYPbAOvB8enyswj7HWsLf3f57sDiiQNrUYTIrJnDlschtbynk2oC9BIF7lQVuWegDPKs0v6iSja7YOt0qiJVklUWmc6Q4l5AZrQTZGxPQiJN7bkVl4S6s/ASEIyjPnXRtEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729628653; c=relaxed/simple;
	bh=lwTZdjpKh1u6ZEelloCd4cVsv1/WZr4DMz+xYETUaxM=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=AkOtG0NRUUEPB4SpPIA/piM4bUCcbq8u1mhHsHPlUcqKIOGl4Ov4KFFZ+5oszqv877318Fnio5es9CbkTmPDGBRSszPKVXt8YrDlAH8vFCOcgefsLLxs3eJ0zTQZV+cN/+0bm5dHu14pW5UUI+M7EFc7rS5jwwS0uZoINNQuoow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iuFeAIg/; arc=fail smtp.client-ip=40.107.103.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U/pP0yqZmZw6otF5wonhTiUIWs1FOYZ3QWX3halct4KnAuJfaC5jAd5JoHUSdt5UH557/DbFcrZP1wpjzwnW5Qgepnirr++H5Mv2/Ek4FEXPZcd7OwLqDlAWAAvQqsqeXAgS4pWPmXLKrsAkA12VavNYEcVDkdbyTCqtkNl/bOTWYCPTozEdclCqC7MItEbsv99pyTNuirlHb1hnQGztHnzRuSqP+I4KlPb5P9E6vkrUWGmHTv4BfUbOI+2Nwyq04v1zE1FQSKW4Z2xD+KA18UZmfPZuPV2PXdG6FzP+LPpDndVwqU6mIjXIdUSDNL4Fcgm1VFQf4q5pIWvY9FXAHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=abgjQxhoXCTtMuOcz+E+nsz4LGeT2RFwZXAQPzDHl3c=;
 b=EjUBNRf85nMdU9sVr48DoI7L6D+szFFNzBB/DZx3w3kDO71hnuB3GHGyRcxI/2LC6g7lbHFX+TEPBMrHGNggobbTQ4u2m920wnSDRPSAG/gpMaEbRbnO1AhJvAK59oAbRZxHTfifkFLYC3xq4lqeROaRmJIXLo25hl22t/cCLH98Kc5woNjNl/GqqvRnblfyNhIJQ148yBtGXCLdT/LuUZjSL5UWBX8r6TiOuc+0OuDmLJ5rFCJSxSIrAjnP+LuEZ7UT3lRhhEaeOE79Ye0RvfuoIb5kksHcEMHjsTLeOLxnOxSSImz6EvH8nhSC21tz32D51Kgdnbn+z5TqkqkHRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=abgjQxhoXCTtMuOcz+E+nsz4LGeT2RFwZXAQPzDHl3c=;
 b=iuFeAIg/XXA5+0b6LYOEP+nx7EYXXy+ueVZQN/XBHkxBKMHsLyfOyh6ltXDIuAwLuzpN7CCJQ5WL9kavnYNQQtP8erdxx3BEEWCvYUIAAkTqK0RpCCZpa8VkcZ0bQwss1HSgWPdNFf++7adlFPyRnOfQGVaTNJGyknA72nrqs9/qVlIl1s20ZsnUx3ELUGx6GZctvkviQkY3NDFm7RR++E/Soi/sYjBhp1phIxsrZevyr1vEVmFgBl0mjB95XnOMo9yLoQLBRQeabk5w7IfRwIzqwK3AEnGIqbNk6xWSNRUmKW7oD4f24/ljMwVxCU/bCzvxYe87VHQXnMRsSmx8BQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB7901.eurprd04.prod.outlook.com (2603:10a6:102:ca::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Tue, 22 Oct
 2024 20:24:07 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.024; Tue, 22 Oct 2024
 20:24:07 +0000
From: Frank Li <Frank.Li@nxp.com>
To: alexander.stein@ew.tq-group.com,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux@ew.tq-group.com (open list:TQ SYSTEMS BOARD & DRIVER SUPPORT),
	imx@lists.linux.dev (open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/1] arm64: dts: freescale: mba8mx: remove undocument 'data-lanes' at panel
Date: Tue, 22 Oct 2024 16:23:41 -0400
Message-Id: <20241022202342.1263766-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR04CA0012.namprd04.prod.outlook.com
 (2603:10b6:a03:40::25) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB7901:EE_
X-MS-Office365-Filtering-Correlation-Id: f9c55f5c-044d-446f-a81f-08dcf2d77abc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VZIv+DPi50JTIpzNV40qZ6MibdaIv+WgYGQvjUrkz5LYEbzNukFBKu3cXvNW?=
 =?us-ascii?Q?qQzfY07ym14NyQ905Oui1Vf2DAt408+vl/Kjr5bjTZ+iH5jX3AjNhn7pAvk3?=
 =?us-ascii?Q?C2/FPZXGIodnHQ99OdzoYNJToiOzC+hSguvzk5hytom6BtokNb6UlPir40/W?=
 =?us-ascii?Q?M4MrYfyJeOr0lSMfQchyAGyI11NdhXG5zJZ1HXUpMkb2nZt8i80gPvTT057g?=
 =?us-ascii?Q?nApMnG6VIV72lzatbzuSaRFT6M+RWABS0bX/feS1rWr2JbhkIxCv+kK3ezPf?=
 =?us-ascii?Q?PVQEebeyhqb7bj12e3bO2FfFZs4apLY0oHQrZbeNlyGCXr3rgq6xLJMARJIB?=
 =?us-ascii?Q?uVtiyqNscmoTStH/H+LCutdud1//RGTJbIzYKLQu1aCfUvw8J2cq/9jshDEz?=
 =?us-ascii?Q?CWmxobZYUkMJwHcnpkIHqRYGKEEFdsd9CqvaWxq1hJqVrIVP+qSnznMPBULa?=
 =?us-ascii?Q?yk8btiL9gm+bCIFvwxFacDwg1dT3x/glIKB+vIMBIzxx9P282RdfmpV4ubQy?=
 =?us-ascii?Q?VRa5EK5edc+cwGP4RgZTd4qFghX++ShzMX53NOoVFpRA/85agnEqMK2oFUyn?=
 =?us-ascii?Q?ifz0JC83OejVu3igJEj/Q4jnBuZH2VojIQC+QA/p6JOuBZ0Phbd9bss8lfuD?=
 =?us-ascii?Q?JFV4krGvVYlN5YjX5BBy41XEJ4yvQEgu02tHFedyZnsIc8+F2cpUOaBNmrSs?=
 =?us-ascii?Q?QZSauaAS2UWuSzVse3Zomsfkcd9oCaGyVl0OM5a4NMKBKdeNVbg1kQx1qIhg?=
 =?us-ascii?Q?ZNZdZtkQ1K/PO0h2ghZ8byr/SK3lwhT/325YjGqIcga25DzKEv4pkZ3Ch1lj?=
 =?us-ascii?Q?Yrl7yoMAeBIyOHJRh7M+Ve2o9k6mULstRqdpgE5rEXkNjQNSQU5L0L1s35nR?=
 =?us-ascii?Q?BUmJAndyRWCwlU2Ms/G6VYE0cccCjwAFbyY13sYeDP3jbemL+EikOTT+0pJo?=
 =?us-ascii?Q?Hvvv8UIgtPlPO3+JfKtOYpmbd3Ihiri9hlcP+iYK6pIqxe302fsTKL2r5oMP?=
 =?us-ascii?Q?7+2DoyBhUgT/4T8F7Mj9VKyAz3FPV7T0MMWfGTQgv7vkaYeLLP8LI0NUfC/E?=
 =?us-ascii?Q?wdpot4D9IxBTSD3ojI1Ik0ZW4G8KFID4klfTAx0kb+rVaGRm0sdq3yiASo5l?=
 =?us-ascii?Q?CG8YbSAZyZss1LqUha1y6njuFEMSBZ8Iyn1s1E7g6CKDnzdeXdhjcASDeUWp?=
 =?us-ascii?Q?L+trLWrNhTVSCiB2jqJvegNr9xOw6+8yO+Lj1Qn4jUywSvQGA4TuhPOmKmou?=
 =?us-ascii?Q?IgIEtMGJ8X5a3aGqQ9xSQzyAhMs8KSeZ2wWJQP0iRtSSOnopvwU1iBlEoa1f?=
 =?us-ascii?Q?PnNFzSRwzWUKBc5YIjJjAfqAF3bP0NLPTpwXJpUvBReopg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8CM+2Be5LxiabQ4VIZ1NUp/0XjAg7MVlOSXJ2XpKQmasMVuvgt0x99OYvOr7?=
 =?us-ascii?Q?6IIwkgt5Sj+h93LsFykzAjTDKHMsDq0DPxH50cAentG2J7lTmaUVoN7IuZAo?=
 =?us-ascii?Q?zH/EIwUnYRx3gRMl6AsI5uc/Vv7PyzkHl+jTj/evCvaequhKChAgL3BbsF8j?=
 =?us-ascii?Q?QBDoqYi19qgh7nn0WzHedNSorBvJzuj4CebG8vjSL9ojEwSrQHiXBcaJEvdk?=
 =?us-ascii?Q?e4xEngwb/Mr+RoAZGHnVVaSZFHoJ6VgjK1j/JqEiH/CgEkqrHeNUJnU6hf6W?=
 =?us-ascii?Q?bMHHeaD+ybAkJC1hJobOEDFqUx7eAJMDW8UaJVaXkLREzIfYT3KKxBE6tVDi?=
 =?us-ascii?Q?39DWNizVgukLxjzHSfwnPIxZbfAB+MrKkPq0166tzC0stwmDrGInwX7799G+?=
 =?us-ascii?Q?W6wnF2ab1tnaFX5/gzjMugTUdHDbW7uZtHTSw9oFWNaeVGEHrvDv2tOBI58T?=
 =?us-ascii?Q?ml8dI5edGPI9LhAhPR/OWMSubsY0bEdffXxDs/FwPGq74cp6V7OqGUV/Ajnc?=
 =?us-ascii?Q?oQENHFFb9dGSw6NNah1QbZ7FjFheRwDX5zOHCSsyb420Y29Di2y3K8JFKjOx?=
 =?us-ascii?Q?SilqeF+TvqkcTyqpTtM4kgv0dotkO7P5oOqdLBcyvhiUsM8ilWjliC1I/h1j?=
 =?us-ascii?Q?KTukm9XRcW4kt1WfCgwuYYvdcg0khHtau4j6hft/q9yOnT6j02nepi43VCtv?=
 =?us-ascii?Q?Y0jlF9Eb0dMDka50b1zMZXIQNRJd51TBWNlvqIcsg54Vf/IL8vi+Y9FN2TYb?=
 =?us-ascii?Q?/4CbhCz8132x7EnyTIZ/ZzaqVfGfoqy8DTbOTqKCgxvSp7F1o11LrdQlbYcH?=
 =?us-ascii?Q?tBsgjbpOZArkHBtBSw1hDdFA8LfAmg4OwDVPDvdYOhzXygLRHqYe/dBQ4aB7?=
 =?us-ascii?Q?3PG16Q36kGE0Yfk+yK0QAy6q80d1Sr2KZHjE22/bg23S/4i1HbLXBgB5s1OI?=
 =?us-ascii?Q?Afy3obisCLOMJvoAbHNufww1dPfAJ+PL1BEeGuF2ZaH7TuzBcD0IeYwQpfaY?=
 =?us-ascii?Q?/Wi5WuKPTr1/0xNfghIlThjIGBLvwlhdYgQFb+Rbd3GjYz9mgZx5YEXZ7AYp?=
 =?us-ascii?Q?Sf/ii9Nn/cY29XUlVvaC1K5KD0mRVy9DaVvLjIBczsbULVY82hOOe4jL8c4u?=
 =?us-ascii?Q?uqnLT2KBiabpwb5ZSL2hDECCfNwZKYJZQWKm9Tisgx3TgurWxXcUoE+Cj4eH?=
 =?us-ascii?Q?kMis+x/XWfC9MdBPz+FzHxP9zZyiY/jYcCGx/TYfeXFmc1EPYoGfFkmVUYNZ?=
 =?us-ascii?Q?sM3CmfPRAI8eABYKGVyqsIprZZiGaE9AyBL1ymYCGfLHuuqlO7Yt8jf77RKm?=
 =?us-ascii?Q?R3lBsb17HT2gtMu7iIkILUTQjcssViN03PBqIigpF1DKevOAGKRJZraK5PZL?=
 =?us-ascii?Q?1H0EEENU9aYrb2ZuCMwjzXXdwU1f/zSacZ0eYYq9GRh56c1VAtoP1RYeyTCM?=
 =?us-ascii?Q?VVcu0ksjf6wfhBQa1nnps8lZvAwVF70W/6lOHx17xyobwC5yXGQnYIZ420Tz?=
 =?us-ascii?Q?fsZibMMWaG3Kf85hwRhm2ec5pqTFI3N90Q/HnMq1YKOFRZgWb6OVyOyEXDVh?=
 =?us-ascii?Q?roE5jFlZpkGWCXZgXrJeFyTsHwK5lAshZqtE70s8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9c55f5c-044d-446f-a81f-08dcf2d77abc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 20:24:07.3815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z84yXApz3XufRpvJWhEB3fLNdwbYLHOTjoDjHErk4UJ5IA0pCrffm4BN+19rgQ7JGCgsOR3LN8t6iEnsBX6RRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7901

'data-lanes' is port0 of lvds bridge. Needn't set it for simple panel. Fix
below CHECK_DTBS warning:

arm64/boot/dts/freescale/imx8mm-tqma8mqml-mba8mx-lvds-tm070jvhg33.dtb:
   panel-lvds: port:endpoint: Unevaluated properties are not allowed ('data-lanes' was unexpected)
       from schema $id: http://devicetree.org/schemas/display/panel/panel-simple.yaml#

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
I have not such hardware to test.
Alexander Stein:
	Can you help check it?
---
 arch/arm64/boot/dts/freescale/mba8mx.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/mba8mx.dtsi b/arch/arm64/boot/dts/freescale/mba8mx.dtsi
index c60c7a9e54aff..3d26b6981c06f 100644
--- a/arch/arm64/boot/dts/freescale/mba8mx.dtsi
+++ b/arch/arm64/boot/dts/freescale/mba8mx.dtsi
@@ -100,7 +100,6 @@ panel: panel-lvds {
 
 		port {
 			panel_in_lvds: endpoint {
-				data-lanes = <1 2 3 4>;
 				remote-endpoint = <&lvds_bridge_out>;
 			};
 		};
-- 
2.34.1


