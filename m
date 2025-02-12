Return-Path: <linux-kernel+bounces-511211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4921A327C9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 14:57:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63D9A7A327F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Feb 2025 13:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17AC20FA86;
	Wed, 12 Feb 2025 13:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="d64QPhtv"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2059.outbound.protection.outlook.com [40.107.22.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F02120E315;
	Wed, 12 Feb 2025 13:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739368621; cv=fail; b=LaJkX2TCT4SWq3VwLsKKrJhKb6BslnaF2rSQbLKRrHmPTO0sxdhfs3HWM7rep2xRZD3BQfqh22q/sQBC3UcKYI8KcrrJ3XILvUyG5t+/O9wEnM+OPNSSHwZwx5Lpx2QRKmJpJPvcaDqyoY7u9AiT2l/S92UQMtmTOfYk5cAMz2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739368621; c=relaxed/simple;
	bh=0AQMoqNHFp9WdTroJISseGzuSGYBoKP0Rt97WKkOPRY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VqVqEZFUnkRPIgfPH/8vptuTVx0htwI5HzCrWeGRrPXp5Q2Gnze/iKiwJ7ialh5yQq+clfqKLp1RoLirGBCyQZKbBR8g9iAasc0bJV6kuvZ4KQGXRImfro2ON/lOlLVihTVgkBIMMApXwJ8PnVNXoz83WXdDh9TABcLnpSM2zi0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com; spf=fail smtp.mailfrom=leica-geosystems.com; dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b=d64QPhtv; arc=fail smtp.client-ip=40.107.22.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I2x0r+t/LOKQZYzuIEFahDyo6HRdBeUdQPCBhmBvjARMJreUz5KJT2jSKru2oLt7lIQiqUr2SrH9h0lWHe94b7PYV6jO2+k9G3gHVybY1UjvCP0Any4bmoHRoY35Z2cXNYnQyIdL0NPflPcAdTc7Vhp1EG6ie+Di1rBzTakQNNloF0Q8EQ7hKmNTndDzmC02UI1S5dgUtsvxA+bzCWcuKt40Qde2nHSuvqX75g23oH9ha3wv4f3+ciGM0wCgNG4He4VhYZjQGJJNmxP09gMurv8LH+rQUXtVKaidukZhQvVJM1l6csJU5PZZxzO92tWOmOPLkzLArUkBdTD1If6cFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mdqIpcY9/SHBmDC8qnjvOMXo2Plmpu8FJeggNj/ojq4=;
 b=KMMkQLN9DHt7/Vy7SQcXAA/ihSCPE/2G/JwnKn9g6NXkEL9w8MOfnlAUc2j6D6JWiEOFRnDFWC4Q7X9oVmEyxI8SDf/Bbokfqpkr+0CaX1zNU5zYigetCeigPmX+x9cO74y4UBk+78enHRxk1gUfrX8INzPb1Tx7RqQ2vf3+7wWdFw9MhTO5RG4wp0ZFbQcw7GmqDXjjbhGubxWoByEwca16IrXNvYiYuA+n1lUJz/7P2JhhWQFCHDYqMUXAdeF9t/Bqt/qmVNIKSGYW6WZ8LGQ2QLf/lol/hfUQwRU7Lz9aQGzAvUhqOen7ZXPCnkmt/O6f1ZrDrsS1vxIrvrq2TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=leica-geosystems.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=leica-geosystems.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mdqIpcY9/SHBmDC8qnjvOMXo2Plmpu8FJeggNj/ojq4=;
 b=d64QPhtvmYA8j82DgC4xvWt+YHiLibLpvu5WWGni/ZIWaQ0OqalskobRjFc3tML2Tg8HI84h6Ax6yyKp1tpNQK45dJ6xmq/vSFeFk25In4v9mprDBDg9Cx4/Au6oRVR30Kvm9xQJElyxFxl2CqFgETJqG2TvSY3ZxlznlPRw2fQ=
Received: from PAZP264CA0253.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:239::13)
 by DU2PR06MB8309.eurprd06.prod.outlook.com (2603:10a6:10:2d4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Wed, 12 Feb
 2025 13:56:55 +0000
Received: from AM4PEPF00025F99.EURPRD83.prod.outlook.com
 (2603:10a6:102:239:cafe::d7) by PAZP264CA0253.outlook.office365.com
 (2603:10a6:102:239::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.11 via Frontend Transport; Wed,
 12 Feb 2025 13:56:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=hexagon.com; pr=C
Received: from hexagon.com (193.8.40.94) by
 AM4PEPF00025F99.mail.protection.outlook.com (10.167.16.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.0 via Frontend Transport; Wed, 12 Feb 2025 13:56:54 +0000
Received: from aherlnxbspsrv01.lgs-net.com ([10.60.34.116]) by hexagon.com with Microsoft SMTPSVC(10.0.17763.1697);
	 Wed, 12 Feb 2025 14:56:53 +0100
From: Catalin Popescu <catalin.popescu@leica-geosystems.com>
To: gregkh@linuxfoundation.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	festevam@gmail.com
Cc: linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	m.felsch@pengutronix.de,
	bsp-development.geo@leica-geosystems.com,
	Catalin Popescu <catalin.popescu@leica-geosystems.com>
Subject: [PATCH next v2 2/3] dt-bindings: usb: microchip,usb2514: add support for USB2512/USB2513
Date: Wed, 12 Feb 2025 14:56:48 +0100
Message-Id: <20250212135649.3431570-2-catalin.popescu@leica-geosystems.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250212135649.3431570-1-catalin.popescu@leica-geosystems.com>
References: <20250212135649.3431570-1-catalin.popescu@leica-geosystems.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 12 Feb 2025 13:56:53.0458 (UTC) FILETIME=[F8A16320:01DB7D55]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00025F99:EE_|DU2PR06MB8309:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 910da2c2-d95c-41ca-a688-08dd4b6d1c10
X-SET-LOWER-SCL-SCANNER: YES
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ldqD0PKyEuJEKdpUsZn+Jv+aNbXJbmrNGazvtLaOfsDSmnhYkXMrI54bVJP1?=
 =?us-ascii?Q?Fyh7t2re8GAC5QBjt5r+7I0r7jcMqZmMcoSYmE0ai/YZrQVuCkZl1heQQ+46?=
 =?us-ascii?Q?FATGv35D5WmML+hW35/phXWZImM9Jan4FVcxkVKA7VjVn92g7tUtHNKbSFUq?=
 =?us-ascii?Q?8xfRLbT6wiDXeJgR68DfFIgrbjBCc0ldAIjIZP9dVS23hZxJeediS9k1Pr22?=
 =?us-ascii?Q?9UpkFAm6iKg5aAumKtOgStIou/aiI+xTM0chBNdhpuPCeTw3EZNYwBX/4HqY?=
 =?us-ascii?Q?Ae66IoEwoy35N8wPEkFlngRO5zvOrYKgh87fihESybZJ4M8PdLTlyiwW50dD?=
 =?us-ascii?Q?OZ4nos0wZNBk1QUPJHaLeSFlL6sQyhmmS9yspbNu7PGpvgaIikfRdYexlQfd?=
 =?us-ascii?Q?Qx6IesKAK7NVlz3blYPctIf4LMm7WnxC6SHFlY3vDAyfzUDZAgB9MyamIJW1?=
 =?us-ascii?Q?qwhLbzU9FIO95+81b7rr6OcrCsyfSG22otJ1RRfhOOgjY0/WWepkMmUwYXp8?=
 =?us-ascii?Q?+IfpL7T7cPnHQsb1NWR1ykBlcMxrMmWfpKfjL61vMjHhf1wmhT3YFj0bciXm?=
 =?us-ascii?Q?gKnfGSjtIgaUi6AoLoaHQnI2DUiDD/yVn7+ktwLrXdnmSVx1b8J4nRaYOW+9?=
 =?us-ascii?Q?g1cQVTdifZCXYGGq32QXidafiILpOJYzZvrXAKTBybP4BaTOnnjsALnAdOhI?=
 =?us-ascii?Q?Aj9S1haWLSyIN4UUkwsDv+TekDuMopHOK7/s7uLxrbgpuZ8rgbMjr9qfxEmO?=
 =?us-ascii?Q?foiGXE7EjcgjlQVU4HApAk4s+XpyNN5+R5/5ghIKGkQYXOPK30g6k+nhLyZZ?=
 =?us-ascii?Q?WQvWWjxm8C7pTznhgRvrgaWUvI+vVlli1DHVqsvMqf/9yRt6t2GZUQx+7BgH?=
 =?us-ascii?Q?KjENsS2ea9GVl2ZJp9koW2hyzSaxY2kfFBpXpr2S0yvkjwnl/EivtwXU6ulb?=
 =?us-ascii?Q?O889eeWkNBnqN1FEThDGbhWjCqU3OuiSaMR3yu0TEIVfjE5NPC2NJzCkzDoD?=
 =?us-ascii?Q?k1SOfLRkpDv3iClawGK6XcIMmM4CYOOZVzOS1HmnHpckKVHdctsxTjePe6TD?=
 =?us-ascii?Q?n1XRnIRvhBvwLhfzhYtgKp7zdj+NwHEcTXkKH4eb+y8XlGnVbDoCSNzcodxg?=
 =?us-ascii?Q?pRD5ZZzoJeOrcWuaUasvaLt/72LIYFeVJ1KfMD2R5ahXjYu02p344+AZO8RZ?=
 =?us-ascii?Q?RcHMH5R09RStrwzoQ5Ak6w2+LDlT8ZJqZ8WcbEIgQSqvSpK0i7KNX8dXvz+P?=
 =?us-ascii?Q?4OKNc7bX8Ps7qE5Nkqr4PubWC+moQE+LPfcryglOmmAUcx4dAmmRrht3tJIZ?=
 =?us-ascii?Q?o7qqanFzIoJZxigxIH5LMzNnizbj54xNWF+hDfZqi1S98JujPMyP1tHxoXvy?=
 =?us-ascii?Q?hhZsPujVzZKBqBSSPKpX6QqBQcDdxhwKOkh4XCV39rjGf62kxcfLMBKWfiJm?=
 =?us-ascii?Q?LpbJLpUwox9Tk9CkZ1FnrHCZfEkDT1vIJF3TR+4bYPwLUjC1RpoHVJBQg523?=
 =?us-ascii?Q?XH/xsVaJ7FyfyD0=3D?=
X-Forefront-Antispam-Report:
	CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:hexagon.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 13:56:54.9912
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 910da2c2-d95c-41ca-a688-08dd4b6d1c10
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[hexagon.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00025F99.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR06MB8309

Extend support to Microchip hubs USB2512 & USB2513 which are identical
to USB2514 but offer less downstream ports (i.e. respectively 2 and 3
ports).

Signed-off-by: Catalin Popescu <catalin.popescu@leica-geosystems.com>
---
v2:
- remove needless "items" keyword from "oneOf"
---
 .../bindings/usb/microchip,usb2514.yaml          | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/usb/microchip,usb2514.yaml b/Documentation/devicetree/bindings/usb/microchip,usb2514.yaml
index aeffdf0362c2..dcbd4bd116b0 100644
--- a/Documentation/devicetree/bindings/usb/microchip,usb2514.yaml
+++ b/Documentation/devicetree/bindings/usb/microchip,usb2514.yaml
@@ -11,11 +11,17 @@ maintainers:
 
 properties:
   compatible:
-    enum:
-      - usb424,2412
-      - usb424,2417
-      - usb424,2514
-      - usb424,2517
+    oneOf:
+      - enum:
+          - usb424,2412
+          - usb424,2417
+          - usb424,2514
+          - usb424,2517
+      - items:
+          - enum:
+              - usb424,2512
+              - usb424,2513
+          - const: usb424,2514
 
   reg: true
 
-- 
2.34.1


