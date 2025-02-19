Return-Path: <linux-kernel+bounces-522302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 064A5A3C876
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 20:22:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8EDD1897324
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Feb 2025 19:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8652C22DFAD;
	Wed, 19 Feb 2025 19:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="L8/JAtd5"
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013052.outbound.protection.outlook.com [40.107.159.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836DF22CBEA;
	Wed, 19 Feb 2025 19:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739992897; cv=fail; b=BPYdpm0a7d6wFAmd2eeHiQ3ozEoTy1D9pYNhrTl1CqPtG10RSVICoEFLnjf2SbH6SHVOu9UeB1CmznQjiRRmRkJdGBe98sWpeP/Njqkpev3M0Jaxbg6ngx6y5P3putK5ozcLF2pw7xcmT7ChR05RGKCkRZeo/HJz4h2XzjUPw+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739992897; c=relaxed/simple;
	bh=ozCCVuidrIGVSUEu8i9iSj5rjNIfJNa5+BSQGPWeUTw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kxOO59FYfTzDMhlUdzx6iFYIBENrlBpAnGVdeP3Cp50DCqDWWle+3czIBAjjpkeMZcVTifgStPfnaFrOvfSXpMJeTtMD7xGWS+iu3xaox0RrfZ4UtiYO8q1q3kyJvF1EoYfryRA6m9wJTUy8EQcwyENrHuQa/UvUvYrcrYNOI/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=L8/JAtd5; arc=fail smtp.client-ip=40.107.159.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MlC4OxCSGbwDZyxWNtWH+sbouDF4VXpj7xquaAhQL6O0P17LdKb1tu3u4Ad/wZt58CtnvuRh96aAD7SFJy9ReEicNJqWvZwoxNaM/36sIYUd7xT+XTy1lbRMLBAsEB7aKK4Mlizgz48+Fm3w71laintHuJKJSPQCcevU4VAruOSzLpPDjuIJ2mmSiyT8XNeM/sdM5ZbB66ReiJNTRoZya00Qhf/E5rmi+KaqAZATheCXU1VcRhrXh/o5zKzmJodSeNrB/hHnTnZukhBcGntvfnKDTgC09q1cHMx7hSHZ4Mi6IrYs5ww6pu520a7Qb2Wl4N1WbVdAKhBmQK1sBV5LQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wAr7wZfuTsftGSB7iS4RauhA47pR5itdAxOY3kvw+wM=;
 b=yIoroeAqm5nw1Hd9CqbAEJgY05E76OZX3hV29wxhzAo9X7R8nKvJiduod+OAhVaVDSlCpQ0ncV1MsoNXcsRvT7cShDMQzuyGAVAJGwgtQyzqGoCD9zp9QwckTQNCzC75um8tsceBAPx1yvOkakVr0Da5nbrwCndnhvIlfMMO9HZ4Ewo7jZK5nuieUDpJeCzg4ZqPNQyxWuKZETXdIgqzYoToK0qXd4AhLFnHdn66NHHUSrOOWsx17mtoTO73YJpR553SyogyR09ZU0qODfqA67oLSIuBW4kFvUr9wmnG7o11H9SAYY7YPPHfLiiQXvppdHngra31+xG3v4uku7t9qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wAr7wZfuTsftGSB7iS4RauhA47pR5itdAxOY3kvw+wM=;
 b=L8/JAtd50tnoZ3a8qCXrAZWBqWwar0tBKUkWGZCvRDRfxkfnsIPx7UKzDaE8TNAusgaDC6CyGYaZHbITSpsa+TI8HW9EbI6bvKX6LSTxxWqHTQPU3vpZ4xsqqB4qRuwe7c4niELhdkuP+G3IdffyqY60Yd3JfkKhirkz6fqrIFxvmPGw+oDYs2go4FiIpT1prPdW2gtlUVRIbHkabZ4lj/svl87eyXG29zr/LvoCfeUSPZ7Ke1YvzcF7nXFUJl/GvjLiMBBQUqsrg+IkQKj84So5WiGpnj2v1s9DLFKQiiYzayzYUb7rQbhAZ3S8jdTRHxDBvmsdIizm5kuWxRLr8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8247.eurprd04.prod.outlook.com (2603:10a6:20b:3f2::13)
 by VI0PR04MB10951.eurprd04.prod.outlook.com (2603:10a6:800:25c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Wed, 19 Feb
 2025 19:21:28 +0000
Received: from AS8PR04MB8247.eurprd04.prod.outlook.com
 ([fe80::84f7:e2c3:ceed:c0a6]) by AS8PR04MB8247.eurprd04.prod.outlook.com
 ([fe80::84f7:e2c3:ceed:c0a6%5]) with mapi id 15.20.8445.017; Wed, 19 Feb 2025
 19:21:28 +0000
From: Daniel Baluta <daniel.baluta@nxp.com>
To: p.zabel@pengutronix.de,
	robh@kernel.org,
	shawnguo@kernel.org
Cc: krzk+dt@kernel.org,
	conor+dt@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	mathieu.poirier@linaro.org,
	shengjiu.wang@nxp.com,
	Frank.Li@nxp.com,
	peng.fan@nxp.com,
	laurentiu.mihalcea@nxp.com,
	iuliana.prodan@nxp.com,
	Daniel Baluta <daniel.baluta@nxp.com>
Subject: [PATCH v2 5/8] reset: imx8mp-audiomix: Prepare the code for more reset bits
Date: Wed, 19 Feb 2025 21:20:59 +0200
Message-Id: <20250219192102.423850-6-daniel.baluta@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250219192102.423850-1-daniel.baluta@nxp.com>
References: <20250219192102.423850-1-daniel.baluta@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR07CA0267.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::34) To AS8PR04MB8247.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f2::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8247:EE_|VI0PR04MB10951:EE_
X-MS-Office365-Filtering-Correlation-Id: ed318094-e501-44ac-8052-08dd511a9bc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|52116014|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Dbz+JOVJmMLpaF3yPv7bCqYSjFFul66uNWmjMV7CUCVZXMKMBg8r3tNprWNS?=
 =?us-ascii?Q?KyxKb7S9gsSNUZ5ioa8JLAdT18Rll71IL6rgJK1wLaNSD6e36iZMhb1c55qf?=
 =?us-ascii?Q?hA1om7iPSbV4W9091euvSJv0/f9saudxQYF05/bDq3U254Rj9dPhKcCMnBnK?=
 =?us-ascii?Q?tz1VLJFXhEZxRAsYy9W4pC6hYOnSa/k/i/j+QwAdwHAueZA1M7k6i9nBn6ep?=
 =?us-ascii?Q?buwAlo0fG/l7eTydkcUpbCB4HqHgbkzsdAzYEa8MMqX29UmsrVjDCEjAuQ+3?=
 =?us-ascii?Q?Ks1e2Og59F7qATW6kZEQv8lLRcOuAC2Z4E6TjkjlUWbA8fCp2hkbTvspnCT6?=
 =?us-ascii?Q?tiJdDaxLe8goHIsaiUro0hYZLIx/BeHtzfPH+R9FNgDAETFL0R2IzXcZ++Dz?=
 =?us-ascii?Q?qAxSyd7ZUJ9dPnhcYdkkBY5b4zo30QGICHjRdcPNJatOhOQIuQd0B4BMQROz?=
 =?us-ascii?Q?v9zJYzzvY5n9WBMos6MBtzUyfM7N2XcKLUZNLYWcL0RRJpnopdwqoae6XKfp?=
 =?us-ascii?Q?1cPyexL9f1LaLlsx4eHTnXfUMRq3qPRAlPeohC6zLWqGj2TZGsBzE/tFMfBC?=
 =?us-ascii?Q?IZOQfVC1wZXlY5jQnUmEhe4qLKsKOIhintfvpUa6UD4L+uC6oWUN8I8gKNUz?=
 =?us-ascii?Q?n4CwcUX14T0K8KSliRmzdLUfQ5nsdfLl57yeVZhPbmOCoPXwnZ7Onf6XtK/o?=
 =?us-ascii?Q?t0+IbtqTa5V4SqtiiUXBJ5mL8gu+xHFj4AdFGzGQ6aDvCZbdmuCA2UM9HdVy?=
 =?us-ascii?Q?ePDhmjSy0AZD86L72IaxbjKKmhgnJ11WB/movCKtFwYqqJYXbpYztMM7pZFu?=
 =?us-ascii?Q?8StzjU7Rrv9Qq6XO1tDFS6lDluHcw5HjrtrVY90Zwjy5hfKTxPTskUy81BJn?=
 =?us-ascii?Q?HNogG/0p5rpfaiAJn7FZvuzL4NmnhdAqU8e2oe0grfnZnyOdLh2y2Qqc9EQO?=
 =?us-ascii?Q?fOHpvf5ZATlxaV3fnXKbbeB1Ufe+aif5xeN06XVLQZ9PqWaGgEKzcaXq2o0g?=
 =?us-ascii?Q?fDx0tPykjCiHS3/oLSMWyhNwhukCOaScM6qMuFhkSSllSbAE84/S3Q0Op8JM?=
 =?us-ascii?Q?+5MD2y06Tnjn/4NaKaUVh/SrJGIurE5luFSuwqMLqHFv7qXxIgaRj5ey3SeT?=
 =?us-ascii?Q?sL9y7StMfwfBVA7oTZ+6VGs+fZzX90AoLNdzNbohV3xU72jFK8/bLqto3DM1?=
 =?us-ascii?Q?R9yTzt8FyJOi3vQ6EkNXUJeO6blVDDbVornTzrRitEAz045MN+n3BkehoxUl?=
 =?us-ascii?Q?0UMM0CSPaSd32Zxvf6MTJY9efhy0FnltS1HR6pIr7X39prubE8fQrfz1BHGZ?=
 =?us-ascii?Q?dL3GDIwqps3hZ0Svn7MXD2RzVYO6Cng0dX4ySdwHdvEYbeev1nQOLb3Hth6r?=
 =?us-ascii?Q?L8uBI4OMyoQw1o7IAnaD0kKvX0py?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8247.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(52116014)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rq8cWZYj2sGEJug8xnqTRZ9XHubi4ve6Pp0wkDV6DioZvG2c3hFQNiOtQajK?=
 =?us-ascii?Q?bp5eoUJXDEXFWw1ScLZeIg+QlorXpYCEKf/NWTqs0nDFpCACyQQJjX94/yO4?=
 =?us-ascii?Q?5Y7oAzZNzFa83hDY+p+qmL8AwcD7TBMHdpT5OB5BbEi5jOb7OcptqccOB/c/?=
 =?us-ascii?Q?g4Q57dNFqJPTD/mTVWMD3+cskObcD78H+k2jy88Q33ZLeczm29BWZb0cIj/Z?=
 =?us-ascii?Q?6RYq7E6Dw9ZkZt2t/j3qBNQxrIj7KTSH4MnLVgctaqxjZUhgj7h1l5IuLg7D?=
 =?us-ascii?Q?3qiCYi3Tz9cMe6N+DkbPvfzoXLhS+iH9TzR4g7xvU6iPNg7OaCnadvprpjCg?=
 =?us-ascii?Q?y7zofCtevJfOqmi+L5J1/bLlmEYs7101OO43FS9xC1CjZWvNjkTzK7LfMmus?=
 =?us-ascii?Q?Kja1W6SPZtNSUF7GFovLtpfAnhFTMszj4hUe0rRXn5iysmBbKj6yHsy31pi8?=
 =?us-ascii?Q?RrgoPL3n+x/qd4gpOfCR7X106QZ+7KPoek2uxTuZOTvpAj1FNki3gVE9H39W?=
 =?us-ascii?Q?WiL+y1zt2/F6v015tsr/+l/7y5Fvz92AzMkDmAavtxLNiz2z3znVRZ/XW6gG?=
 =?us-ascii?Q?D1WalG2fZZWuhBHB+V5rrUV4wgtUWa3JIkzir3iycbuVJ4aWA0tZJjKCA2/H?=
 =?us-ascii?Q?5MdF0suMr4Wi5K+NMrBtNGFMlDwx8iUgyxHNTzLsd0adM96jpwiHooLQecUP?=
 =?us-ascii?Q?gUKw2Ybqh51/EcI25HQvNxxUEDvLRfX7EVVE0yWKzex2wLIgXlKPUq7oSZcy?=
 =?us-ascii?Q?gUxeARXxALuF1g7U27TyOCNTc8OkVs8ettCC6ZRRGCRvAG8lMvMH0vmRabUN?=
 =?us-ascii?Q?yl7pgJr4V6uLkqPM7pJisXU6d1JFjK5hqFumAY4b552vCIc9q7t9upBOBFOt?=
 =?us-ascii?Q?TV01kgXp8cSuLDzg8xuhZflRugV5xcdh6bVw1z+XyOiI1o0Tu89XPdsXiJak?=
 =?us-ascii?Q?CDkoM+Cnph4ROGgl5WguXw8BIxVjGkM8dbMQFwZDE8eYq0LJMt+sEH6dTOL8?=
 =?us-ascii?Q?VJJ41mg71zXhpS3f0rWgJbUoXzBO3NDCfMTAHbZvN5+Sm4P3Bqh0xCWNcpes?=
 =?us-ascii?Q?hk7ke65n6RsJH/fIADhoC60vflTV8+bxqjW7gnf7ba+IhsdgK6EZZLci5dz7?=
 =?us-ascii?Q?WTlwx0HHUUwz23Una/QgOzAITYOtXYDe7JZMr2or+kmTBgH99HU1b/xhzleO?=
 =?us-ascii?Q?6VEzAhFtrT1vXbWmLTDezd6mxvM9M3Nsd4ZiIj3Zt+pvyLS1kgcdfF1A0mzS?=
 =?us-ascii?Q?jIS/fzvSyAM+G87qn9ar42nuah72BezevA5L9C8f0txirv5mcQLsuxRRtdeU?=
 =?us-ascii?Q?2MezXm7qcDu5SvMHqPNt5HtMcBCKdvK/YnQcXxRGs6M1pAKm73toXfw8RjEs?=
 =?us-ascii?Q?UqXPukpP7ZBv3iWDt8lOwv5YrhxyZBL9qpL270gYZNx/hjYSpAaEwa2p87Kr?=
 =?us-ascii?Q?RlxaSGvdsNOjxCd29qc/Nyh+knWMgDszi/W/SXLy+wIt9nsjXPD2l32Y+uOg?=
 =?us-ascii?Q?PHJMYV5IJmx25E0xnVig0vFtJnGqcwCFPx/83XLcv3LP0wBG0YjsUrldE66a?=
 =?us-ascii?Q?LvUh4ePqsTxTy1jDoLM0/nd88CdQ0v2b+arhQFe+bffkJfat1+dY7n9LpfDz?=
 =?us-ascii?Q?aHRyEvVujSQt8hO4Tm8VZ9RCdRYlpafvdThsHI95VpYSb+dOPnEfoIEYhR8/?=
 =?us-ascii?Q?CfIMZw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed318094-e501-44ac-8052-08dd511a9bc4
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8247.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 19:21:28.2794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nt4ddsQyr0KH9WMByyVNCS47fLE0l69WnhKeqX2wti8pk6IZWKuFdoN+bhUhLDnthSb/ssjfnAD6Cz2+B6isGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10951

Current code supports EARC PHY Software Reset and EARC 	Software
Reset but it is not easily extensible to more reset bits.

So, refactor the code in order to easily allow more reset bits
in the future.

Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 drivers/reset/reset-imx8mp-audiomix.c | 42 ++++++++++++++++++++-------
 1 file changed, 32 insertions(+), 10 deletions(-)

diff --git a/drivers/reset/reset-imx8mp-audiomix.c b/drivers/reset/reset-imx8mp-audiomix.c
index 1fe21980a66c..17f78ccc7820 100644
--- a/drivers/reset/reset-imx8mp-audiomix.c
+++ b/drivers/reset/reset-imx8mp-audiomix.c
@@ -3,6 +3,7 @@
  * Copyright 2024 NXP
  */
 
+#include <dt-bindings/reset/imx8mp-reset-audiomix.h>
 #include <linux/auxiliary_bus.h>
 #include <linux/device.h>
 #include <linux/io.h>
@@ -12,7 +13,24 @@
 #include <linux/reset-controller.h>
 
 #define IMX8MP_AUDIOMIX_EARC_OFFSET		0x200
-#define IMX8MP_AUDIOMIX_EARC_RESET_MASK		0x3
+#define IMX8MP_AUDIOMIX_EARC_RESET_MASK		BIT(1)
+#define IMX8MP_AUDIOMIX_EARC_PHY_RESET_MASK	BIT(2)
+
+struct imx8mp_reset_map {
+	unsigned int offset;
+	unsigned int mask;
+};
+
+static const struct imx8mp_reset_map reset_map[] = {
+	[IMX8MP_AUDIOMIX_EARC] = {
+		.offset	= IMX8MP_AUDIOMIX_EARC_OFFSET,
+		.mask	= IMX8MP_AUDIOMIX_EARC_RESET_MASK,
+	},
+	[IMX8MP_AUDIOMIX_EARC_PHY] = {
+		.offset	= IMX8MP_AUDIOMIX_EARC_OFFSET,
+		.mask	= IMX8MP_AUDIOMIX_EARC_PHY_RESET_MASK,
+	},
+};
 
 struct imx8mp_audiomix_reset {
 	struct reset_controller_dev rcdev;
@@ -30,13 +48,15 @@ static int imx8mp_audiomix_reset_assert(struct reset_controller_dev *rcdev,
 {
 	struct imx8mp_audiomix_reset *priv = to_imx8mp_audiomix_reset(rcdev);
 	void __iomem *reg_addr = priv->base;
-	unsigned int mask, reg;
+	unsigned int mask, offset, reg;
 	unsigned long flags;
 
-	mask = BIT(id);
+	mask = reset_map[id].mask;
+	offset = reset_map[id].offset;
+
 	spin_lock_irqsave(&priv->lock, flags);
-	reg = readl(reg_addr + IMX8MP_AUDIOMIX_EARC_OFFSET);
-	writel(reg & ~mask, reg_addr + IMX8MP_AUDIOMIX_EARC_OFFSET);
+	reg = readl(reg_addr + offset);
+	writel(reg & ~mask, reg_addr + offset);
 	spin_unlock_irqrestore(&priv->lock, flags);
 
 	return 0;
@@ -47,13 +67,15 @@ static int imx8mp_audiomix_reset_deassert(struct reset_controller_dev *rcdev,
 {
 	struct imx8mp_audiomix_reset *priv = to_imx8mp_audiomix_reset(rcdev);
 	void __iomem *reg_addr = priv->base;
-	unsigned int mask, reg;
+	unsigned int mask, offset, reg;
 	unsigned long flags;
 
-	mask = BIT(id);
+	mask = reset_map[id].mask;
+	offset = reset_map[id].offset;
+
 	spin_lock_irqsave(&priv->lock, flags);
-	reg = readl(reg_addr + IMX8MP_AUDIOMIX_EARC_OFFSET);
-	writel(reg | mask, reg_addr + IMX8MP_AUDIOMIX_EARC_OFFSET);
+	reg = readl(reg_addr + offset);
+	writel(reg | mask, reg_addr + offset);
 	spin_unlock_irqrestore(&priv->lock, flags);
 
 	return 0;
@@ -78,7 +100,7 @@ static int imx8mp_audiomix_reset_probe(struct auxiliary_device *adev,
 	spin_lock_init(&priv->lock);
 
 	priv->rcdev.owner     = THIS_MODULE;
-	priv->rcdev.nr_resets = fls(IMX8MP_AUDIOMIX_EARC_RESET_MASK);
+	priv->rcdev.nr_resets = ARRAY_SIZE(reset_map);
 	priv->rcdev.ops       = &imx8mp_audiomix_reset_ops;
 	priv->rcdev.of_node   = dev->parent->of_node;
 	priv->rcdev.dev	      = dev;
-- 
2.25.1


