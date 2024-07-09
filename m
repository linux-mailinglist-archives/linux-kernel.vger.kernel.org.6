Return-Path: <linux-kernel+bounces-245347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD61192B18D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 09:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D755282D8B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 07:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0B215219E;
	Tue,  9 Jul 2024 07:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="AVxMw89T"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013025.outbound.protection.outlook.com [52.101.67.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F8814AD03;
	Tue,  9 Jul 2024 07:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720511415; cv=fail; b=nFr/jJnvnHqhVU+KctuGckDeEboNK+vHUQPzZEAmcLCih/64GhgM3WjVXNPkM0iMERrIVRFtAVmW3dvAm9J4F67/eVsT/UIcz8ti3W0Pepg0sctGy3DSExlMkyoUrexbEtoRbEyRiBU2wKO8U/xzm1h1bMO0O5K2EoFcelvSzl0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720511415; c=relaxed/simple;
	bh=SHFcGVdRxRJcbxFj6cZXGTgL2KqdtbEc2MQ/nb3c6AE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I2Lp81r+Zt8pd5gZEjuTXd13cuW8qxQGEeB8JaHU5FVWJWlrOa+6vSG8rrS5jJAgHhuLzOe0f0pbdSLhOAgskKQwROAqzwkbPGtcEbo0qQJBLQUyVyhfOuoDhihuyDEzkUpxHSurp19h5WycBPVHT254pGxd1nBmxP66L9bX1eI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=AVxMw89T; arc=fail smtp.client-ip=52.101.67.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=li3DjFKwS5kLMYgLjYsm5oafZHIevV36lKI80HcTCZu0x00enWVAKql7zKOsqqTqDopAfYUCYhr0e2dkvPS1ZVoWqVSoVPLtM2PMfdatSVB9E4JQFqM7qlTd4cpxYzscsDBmaiqNraOk6JXaRY+p47QHxEaSsXXXA6EPAbtIO/cf2owm7UYGwf+VK33H4BHkbfhnJt3hA6Bp262kVne0wi2vAAEUjwuPS5ZaFukTfSM/cFfeX8CFWT1S8fFh6ekwL6ryRyU4ngjM6zw1H/hF6hJSVsZdCeJ0N8CmCogH+fJPZEJGukh9tEbIM6s+l5NIREZZO1gg8e9lAYrxQQgzVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gXZXtRUQTjctotirEziun7u5GvVZJZNr+14S2ME4ing=;
 b=EVxI+BA8cuPxOI7IjO4VNaT72059SsSzR0c54QTc95f5oFHtVD+VTr/pCliK6aQqiFKwHnjGctvDOFQ9YnDAllj7saBZEo4dawZkn5sg2W8pvY9jB5cbKup1E3svOCVetSOzBnvvYYw3elcJN5UnEylD3jO7PlATenierHJ6SbQv6USs8BgBinJB5WexJzTaeThOx7t/StDewYlTUVSVuNA2XV1Edx30TmeJCh0SQwX7IBpgCSsrBqO32TDForAsbL+wE4WFbL7btQ+t0WYv2nHhxHubQiZyIFqgNEviZ8VXT4llSfj+Br3ApxNoXJgA0vQw5/R6EIMWtnd7ij2oDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gXZXtRUQTjctotirEziun7u5GvVZJZNr+14S2ME4ing=;
 b=AVxMw89T9rRWYWUH1MMSOGhdaHb6P7ULOz0XkubYsQ7BtSZIRXvr/ahjFXpIXGn1ckbbcV4U3FnPA/u05rm3H2txbzN03Io3yP2dWDHDqqjnch0bJ0Bazq5SiCBLeRDUjSt2BlHxJl5S2QJ1YliAN/UL1GLhgR8M+GnSDLk0vrI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8505.eurprd04.prod.outlook.com (2603:10a6:20b:40a::14)
 by AM9PR04MB8652.eurprd04.prod.outlook.com (2603:10a6:20b:43f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Tue, 9 Jul
 2024 07:50:10 +0000
Received: from AM9PR04MB8505.eurprd04.prod.outlook.com
 ([fe80::bb21:d7c8:f7f7:7868]) by AM9PR04MB8505.eurprd04.prod.outlook.com
 ([fe80::bb21:d7c8:f7f7:7868%6]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 07:50:10 +0000
From: Wei Fang <wei.fang@nxp.com>
To: mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	festevam@gmail.com,
	abelvesa@kernel.org,
	peng.fan@nxp.com
Cc: linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: clock: add i.MX95 NETCMIX block control
Date: Tue,  9 Jul 2024 15:36:02 +0800
Message-Id: <20240709073603.1967609-2-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240709073603.1967609-1-wei.fang@nxp.com>
References: <20240709073603.1967609-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::13) To AM9PR04MB8505.eurprd04.prod.outlook.com
 (2603:10a6:20b:40a::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8505:EE_|AM9PR04MB8652:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a8d9446-ce31-4385-8a93-08dc9febc22b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|376014|7416014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aKOe7ZmBhR+1kBkg0g/Aj6VS/tMg2zZqY0J9l/q233qf5imE1IeHX7zmOIMz?=
 =?us-ascii?Q?Khj1THVDAaQwwAfEaLyVaf1G1cjka+pKOVvG7lraDtFiih6y+CszPYrY4I64?=
 =?us-ascii?Q?msCxumISNfuzI6eX4n6ItpcD4nt0BgVYx83K/Ki8fDggTaW/od9pYoQoVhC+?=
 =?us-ascii?Q?ubqKipct1GgXs2+eX8rwhHQBvZvbH7ObIwREasqNebvNttRa2ZUuogAvQb24?=
 =?us-ascii?Q?mpOys0CG1z49uFPN/utaM/TTrWTtQuXogrwm8ZEQCXCFkQrPDOpZL2Z3TXyU?=
 =?us-ascii?Q?an4h32ljbNEqM/rRLXUCzYuTWbb9DqveEC7yPjf3PPp63f/BV6Dut/cKWZoR?=
 =?us-ascii?Q?8jX1QnZrGUM7myCqG7qiXIXv/KK6h+SwgF5jpCx5bOqlmxrW0spWiPAxCJCA?=
 =?us-ascii?Q?LNIlvm3TG5ZqTbZ8iMYN6uS24WxDF4U+1Oup9E6FFm+9syFlhyKkTgzIMNF+?=
 =?us-ascii?Q?SQhwXGv+MJDBTf5h1PlwuOPlwzlphwkbAY5n4j+rrQwhtqYhiH1hpaV5HxOE?=
 =?us-ascii?Q?0iAojc08iEbJQNz1eh0UPMDHQqEdKusaYCdPMg25YPUzrCaRD6vwW+Fxm22P?=
 =?us-ascii?Q?W14WjhqQReKaWbTxUJoTtug//aNlzDiKtan4I1Btzr+xGRhWCSO6N4ycDZQy?=
 =?us-ascii?Q?8Q8+GfCdASzA71lcOl7wcfrXw18pkEo/P/k6GZ5UVf2lMW9Eg5UMs9/h7m5f?=
 =?us-ascii?Q?qiy8ja3flhadYHH3keEcWhPxExatR4qeN7kMsRpj/JpW6RX/NicHqcnqHaXb?=
 =?us-ascii?Q?tnW9dw3cvELdwKaYbw5Kaqk12AP5tBfcDXrTA8lE88uQxAIm7ScNVhV8xNDR?=
 =?us-ascii?Q?2a8mV1l9I/vTlNbFMtE5wnaQSsoVXsKI9KnOnIj5Dae97M6nqPRjFlBKiE6U?=
 =?us-ascii?Q?zpVSfoALWO/r4hW61QbQo3IPwPWyRbEd0iw03bxi5k9bqxwhFnFkO/hgfZgL?=
 =?us-ascii?Q?rmubl6f0oFAKec2dxxnwIGxAqrn9a/IZXNh1P6XJi+2dUo3m4jVlygfhYRy+?=
 =?us-ascii?Q?6PpPxjz2NfZwLTkmoWwM3vVg0Ox0McVHrXh1AWJ9kfNRUyC/3oYvZRbxnaXL?=
 =?us-ascii?Q?9k16fbFRQrpjbYxFzcrE3TfB0Tnb1nVGS6ze/XlxGTFduTNc05LzZWoXBV/j?=
 =?us-ascii?Q?byQ+8eAqBsC4qvwAoF8gaiY4PODBFsF6a/B8LNzhCCCGqwj5CrVPft6IcxI0?=
 =?us-ascii?Q?ikJeTslwNd1BrkXBFmQfhwYP0ZE8jLdjFkvuA1MpfmiM4OOsdJgIkjZ90iF4?=
 =?us-ascii?Q?1pYYY1TJds8Y02PnMfJZpJLjwkAphL3kknPrJ9yZPwahqDSL6AIeCZXsGqi1?=
 =?us-ascii?Q?jib2lcSvKtrSl/Sc2etWmMh6mfYZT6kM2TkccdTj+oNd10pNu1uBZ27HKp7N?=
 =?us-ascii?Q?lfAovqPyBWaUzWeAvTb9Em5gw/McleDE4WuzAfY8wHr/noSm8g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8505.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(7416014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ngkmNQEprVU3nmZDBjJyKejCax7PHCDYpr81xrngvKMR5U3BRzwSBXaJTTm3?=
 =?us-ascii?Q?qPl6O0KWLCaq/t1AAvrvoLijqE7oVXlCQwOwWgZUbSVaXyDUi/p6Fei5ckOw?=
 =?us-ascii?Q?6EJY3KeBH1ktXLQdeJL6SpdiiWTOVSLHcOEfca5YE6htP+eBRnD+rSCkxRcE?=
 =?us-ascii?Q?dBnqIM3AWRWLwDUQXugr7sJx44uG0KlRrhUdWqzr6Sx1ZuZTGzb0vrGz4Zy/?=
 =?us-ascii?Q?XaMAC1WZvN0tVzjYIUtQW0+Du2z71vlFhqVBd2pqk1bWY6JdDtl0BfMWtYFQ?=
 =?us-ascii?Q?1Z23GjqkUQJB1EzyO5U31l8b3RtpCDSv0U6h2SQvI78fVhI3e57elt/8qGuY?=
 =?us-ascii?Q?axWg69+7UITwQD8mL/fOIRicW7E99mnZ8Mjwz+Ywk6l8zRbMVCK2mzTJmyQT?=
 =?us-ascii?Q?OwMVXjFaAz1PcNkBgVo3+Zf28jiBsumMSjgtYqCiypE9FvpfoAgZ1Kg9IKNY?=
 =?us-ascii?Q?pvWJOGtacgJvThU3LURcSHVI1ct3r0EGjZ8zfiDGgep5uZCyBsLf5a+W8fP1?=
 =?us-ascii?Q?L/np0yYFfZkdKa6OFXkfuzhdhCiKam6fGHLoCsjzojshQfL71jKx2zxvx31H?=
 =?us-ascii?Q?Q0xZpPVzwU8eKAOmReUDgg6JuU6os6DVzy7tuvhX7O5kdb7eXoaY//YQe8xq?=
 =?us-ascii?Q?hCzDtbU3+SmldIcACMNm/k64YmI5wg+4FzEOqPcd6wnlL+R1F9XkOnFsxHJn?=
 =?us-ascii?Q?YMUwVjgFurpPqekgua26LOhi7v+uijn7VeHbWiw7qQMU161yTVMTPGQvj/Rc?=
 =?us-ascii?Q?ujWFQg26nrKCgGxhxhYMydsswzbzwQtBA/Ygi/YlUMhDeqG3sVRBZ+PNWtcT?=
 =?us-ascii?Q?Tn5R4h+jgUlYjbmviGNJ5cdvYOVox0yNt10VB4piv8NW7vNaE2JuX1KwLcXz?=
 =?us-ascii?Q?Szrcp86vANXDlHbuapgAP78xB4e+xMrn7d8Jn72ZCYz5+SLl3IBnfMG/c4JN?=
 =?us-ascii?Q?RSWi5CuJEg38yjWSJjbTC8O0Haa9/VBmEqVEsdkig5Rw/tWe1KKMQZe3n1G+?=
 =?us-ascii?Q?sqICd5HbyK8ZmQDMuz7cBxal3cKbdYVvs3b4B3sbs7mfoNGw3wb4NsyywNiK?=
 =?us-ascii?Q?lirO/KsReBCtOYwj/+dEoA+gdgIMWlGqaifEJAYJYG1ZDnHknh+FXCdWPMRW?=
 =?us-ascii?Q?ZcCxGwS8WuMdmqUeib56A8LdM8aeJ2aCjAf6wNFFQbZJbNTpFSHMwUnfDVKb?=
 =?us-ascii?Q?xBXUe4Gbp9aodgQZxTvDCfzqCTB4zhzQTrAcBMxVAQlaLnjvtK5AwhT1ZKPn?=
 =?us-ascii?Q?RBVS8aUNWXD4RM4JNFG/fDxwZBWOLfJeYVhZp0g2dhojls8eFAzHZdUo3z1A?=
 =?us-ascii?Q?amfvbLWtaS/snJ4jhBOPCL0tuxa/j3xEV5bb3y0NDhXjLHEIDH+bgRK2rzz/?=
 =?us-ascii?Q?mCHvsC8WKD58beRtghMxi8lVo2e1cOvfwIdV/GOpbJmHRBV8DkLG3E6N4G0g?=
 =?us-ascii?Q?kWkTEzmAs7Te09kJ+kBYbp837p8My6qgZKJx//UYPUa6cqfF6Be11n/tk/mp?=
 =?us-ascii?Q?EeIMKhTuU90KBCfKTbiyGjh2cioKzyN+qZoiDAriZCpG9mSPla7TzvSFjwSw?=
 =?us-ascii?Q?im3rUNzsYX9FHWvfdne10EfHRPWdfXoeOSRkNqUV?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a8d9446-ce31-4385-8a93-08dc9febc22b
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8505.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 07:50:10.6822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AMnK1464xvZKDO7vQlwaSRp+P3WM+jxynAbHW6y+fO4ZHm4AICG6wNXSdcR0MCP08C4DkiOkVYaZPg+XEKfr9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8652

Add 'nxp,imx95-netcmix-blk-ctrl' compatible string for i.MX95 platform.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml b/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml
index 2dffc02dcd8b..b0072bae12d9 100644
--- a/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml
+++ b/Documentation/devicetree/bindings/clock/nxp,imx95-blk-ctl.yaml
@@ -17,6 +17,7 @@ properties:
           - nxp,imx95-display-csr
           - nxp,imx95-camera-csr
           - nxp,imx95-vpu-csr
+          - nxp,imx95-netcmix-blk-ctrl
       - const: syscon
 
   reg:
-- 
2.34.1


