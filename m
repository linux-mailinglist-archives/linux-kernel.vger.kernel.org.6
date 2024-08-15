Return-Path: <linux-kernel+bounces-288082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D602195338E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 16:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EF4B1F242C0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Aug 2024 14:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88A71A4F22;
	Thu, 15 Aug 2024 14:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="i28GErxe"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2072.outbound.protection.outlook.com [40.107.20.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8491D18D64F
	for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2024 14:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723731392; cv=fail; b=NVO8X6ykgbJOJizwZrVCqWhcgXKjVpbDG1uFYP/42ok1UhjV6MFCndAbzMTrCmPsafICJEWnI0HR1Wb2OANjTnA5PSL7yCgrtHIUGkLsPrwCUa9zhbpRi56nLGHDwzDZ3doYkDSdnglSiVnqymkQsbiBcXOWsbFoIAp4GPFH0qw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723731392; c=relaxed/simple;
	bh=0ZnMhUGun82DLzKKIcY9J9Jx1tXUyRU+ffaQHSOezIc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=s/oIE2rcQKVmyuYGWSD23Ut3EkOu5UiDQdvI1E8tEtN+dPLSc/tqMRVWg2P1lvy9NGvcn/nAam86IDBSHJWllfc2WMI0O95//DoRkLpOxCbebCGUmwt+NtK3RC5vMSjz3/APaosGUIsGf3StNeiCMCQhGDZz2e/1QFgQrueeEnE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=i28GErxe; arc=fail smtp.client-ip=40.107.20.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fLrnAlvVFq7ZkfgNgQGu/f51pnuOWLf/hI4HSi8o4Ygp0vM+e9OVZbkcZE12EpUOUQLUi3GKPJrZoAEozkSV7dSIyqtlm2ywRwLY1yTUtdlZhFCOKh9sUxyXvtyPZsOcEbnAkL07uReNrEjsXVyAEUmGyKgMN9lUSNqyhXXkp7IBuW0mBXULv7qA9kesy8OI7xzzfJRJGasI9REnRfQECaHvzKZE7XvgN+qwWsZlOKR4pZFSTJDnCqV0wcmzUiD6fIRXGACpY75DzR27QxAJiqt7FMtF99xdG2ZQsVMKYQ3txn/7Kp+MDg96TFhEjtzHhsQojrPPKoe3x5VEftKGmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MRegxn+lTlIZMNuD8wzZsDjmYD2Hudd9AP2cHvyhDKk=;
 b=DjALlWO3NjHHZhbtPC82y77Mjr3zG9nndJXo9vG7wvfMdttg0s8OCCMevM1R/LGB2oeHieKQW7R2UA98GoTaW73E8hxWQv1QMOwrNkCCzIqk/9i8MWHLD1YaxU4aaQn4JgBqiYBelPaWfQPxps9Ze9tiR6fzs4zS57pq+Tvd8X5qor2RQgMnKmFPvuLjnwwJLJxermBB8usSQyl19jcZxAg5yw6grBrDiCPCgjuoQVisLkaD+aR4hC4TOhy5XDz6PaLfrNGA3h5g/tpX/EsEIOlNx50SVoQMc0lXIDaN3VKUeS26G1GJrpJ/Dijm49RspJSZh4RU2v1vWdY33vsaRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MRegxn+lTlIZMNuD8wzZsDjmYD2Hudd9AP2cHvyhDKk=;
 b=i28GErxe0zK97VtP7H1YdUPF5D4+dR80r4DxaeRvpBYLq5WVzab5yL5uebHbhTs74QPI+Rwr8V0h3iElmoyeo3n1sFA69m3VFV8SVA+UU4qYNWZKntNFtWHG9ICOYBvNHLotkyOIglak4jtuP+JwcL0ANxvY0MFrloVMx1nsMzxk6syw3D5vTBAdcvcFOMKAhYscsNhZjgC+na8p2Zx0PsL5g1TgXL3UoiCWHxCiX7KxLvkCul301HUln/naE+F+PTdbRhu38C+fjVWkL5Y8mhifilVqdbk+RN2aeFBuQlp0id9ANaMJif+89Q1N7xph57p5SWHjdqAlTKDlcdtfOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.17; Thu, 15 Aug
 2024 14:16:26 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7875.016; Thu, 15 Aug 2024
 14:16:26 +0000
From: Frank Li <Frank.Li@nxp.com>
To: alexandre.belloni@bootlin.com
Cc: Frank.Li@nxp.com,
	arnd@arndb.de,
	bbrezillon@kernel.org,
	boris.brezillon@collabora.com,
	conor.culhane@silvaco.com,
	gregkh@linuxfoundation.org,
	imx@lists.linux.dev,
	linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	miquel.raynal@bootlin.com,
	pthombar@cadence.com
Subject: [PATCH v2 1/1] MAINTAINERS: I3C: Add Frank Li as nxp I3C controller driver maintainer
Date: Thu, 15 Aug 2024 10:16:09 -0400
Message-Id: <20240815141609.4089406-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR17CA0007.namprd17.prod.outlook.com
 (2603:10b6:a03:1b8::20) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB9644:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ecede5c-8a4a-40fb-3883-08dcbd34d93f
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?us-ascii?Q?WRd4jHE1wNNB/jx8XXxj2XiAYmSNoH5zjsnGnZyNzfhf1erZ2wQ+fXYDdM34?=
 =?us-ascii?Q?/OUIfeYjbMRcnkrYB0LzmgqNG+KxZFqN2LoHoQuxpqpxP4dceLRoiiRk0sqM?=
 =?us-ascii?Q?BD/iPjGSgZxTMTBJACNhXEKn+4OIcSlCXs8an9LgnA1wW8ZlSaMtKVcJmcOk?=
 =?us-ascii?Q?LqkH8V5ZlyjNqgWBPIgNIEUsPBTDi0ltEkLNJdbDrwLsE1BSgBsKeKA13rTC?=
 =?us-ascii?Q?m2XRWj7KU6rGzXThPcqYxvtcw01htMMQZdbFqpgdYyCNokkdO+fvtgloQ//j?=
 =?us-ascii?Q?V+687agzt6KLNc+dni+18k9pmzLeRJylAYXjHG9eV9i2YTKmNSlDwcmJeMGv?=
 =?us-ascii?Q?gMFmV3p4mRRzS0XDry0yAq2CKbGQ3ms17h3c0c02lMcDB2oxBZKbl1rp2boN?=
 =?us-ascii?Q?jxLwU9INrwaWe7Ygx8LBua5J+lH4KpBVoOR8B3RmtlGeVtkYbHZepx1In2/P?=
 =?us-ascii?Q?YjubygMX6bT0nOdryTEJf7SKC5hhFLqgP52NP54QaqlqYvZJxpRWQj6nUAc2?=
 =?us-ascii?Q?mH7A8GN85nMGT2hCa7CFcEA+y8K+rsQoMEJvU4KslqY/GksR44pvYS118b03?=
 =?us-ascii?Q?5vJZjD760SNBfkkkK/1SMaG7ZNnY7bKwu2J93miyKnNKyoeC7BqCyMeqFEoP?=
 =?us-ascii?Q?OG3jQuVtdcSNhE5fMl9reThAjPuvrlkK+gK7UXE6ipPaFYnppbgkJSYnAWce?=
 =?us-ascii?Q?yPdhkqoriUipfL0scDeR5Fgvugt6q/BGp/cVnW+H126n364XOJnpiBklXvZz?=
 =?us-ascii?Q?T3Ir8O9kdBF72d+47UWgV50awNEiCuN5eqGe/u31E2jYXS/d7H1IDHN+MGZG?=
 =?us-ascii?Q?I/uy/xy4VJO/JfyzHEXXHG5e44+g/8gK/l0xq2HUjpJwdOJkgT8QPOtt0kGL?=
 =?us-ascii?Q?zF0MWz6ju4sNw7y6FklaJRsydJteFCJ0Wi9DM7J2A9Eu9LwH9Oqx7CfPoSL0?=
 =?us-ascii?Q?X+7kKgDDoYtYtCR41xnnDJ+3e18IUtmwsXIMkh0ROLzQJv6QzzSfbKD+HNGF?=
 =?us-ascii?Q?Pf7UDsA862CCSFXqsRC9wmxJQodI3NapFcQ30/97vaAcrC1kCmpZUh5HVkai?=
 =?us-ascii?Q?koGkIkiaGzR5Ry4gGvP3Ddb+kvYcu/S1bNx65OStMMQtpKQ7W5huRfZHSO8U?=
 =?us-ascii?Q?uGHtHYTRne6sIQPPriGYU2iVi3rEhD1rxPtsE5HPzbt7CQNvsMnrkRFBGdc3?=
 =?us-ascii?Q?i1bmm0MzS/v/8HQKv5k92VLgCIZG3AJQkJ5NqRKJxMLYzCANZ9rGLauDuDH8?=
 =?us-ascii?Q?HCpy3r464+e2LDyvleR4nOj7GwX5QVN64VeVBZsHJCp3FJKAt9TDLPxmZ4cf?=
 =?us-ascii?Q?mQL640p+MtU1dWyiBZR3XEv8nYlOr61gsglKZixyqNsKb93DwTd+0AhyHAsl?=
 =?us-ascii?Q?QGTsRwc4HSYN7RSVkoccogcVSdHiqRgXQQTvh64th58ED+NLkQ=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?JxdsVFDHnAkanxO327cQ6FIMlAbAgliiVPPaes8pMZMF/1vqBGr1ZPlmrnur?=
 =?us-ascii?Q?JGiphxrBzD2ilbUSWXkJYS6TmOdwMGb8+iXTR/V4p7VX/p+FvuaAqgKTVwLc?=
 =?us-ascii?Q?oqIsubHynMh4A09nYr08JYHeRtqUW4cf16hNvIIYQCFhbUYiOYmG/npEHg7z?=
 =?us-ascii?Q?sWabScd3GUnpq+hEjlze+KqXmMtDpAQDxCJlgU/e2WkM3Jbj/6odWHoDZf26?=
 =?us-ascii?Q?V4uVjyU+BX3VGqrnrsrczM7UNXSUjFqEY9rQrzmEVot3K0kMucn0avGK9qH5?=
 =?us-ascii?Q?IOMnIdrGusZSgWh/LgQAlRJxJADCNaTAakguKs2VEmFtF7A1+5otfqQLuHUi?=
 =?us-ascii?Q?96An3QrtTrxCyD3yQcBA8DkEgJd2A0W6mhGsZfclk/qANw+cgFHUGbfbpgDq?=
 =?us-ascii?Q?qdzRFJH7SWI4cqmssxbFiMHZjBs9jktfbphWSW+1E2vZDUIzBza2H34mxOmU?=
 =?us-ascii?Q?OTBFSjYXyJieTUZprKfeMathGpbcCh2h5/DfTYs34qP4yRxGJbwwBPS4SuOk?=
 =?us-ascii?Q?dqIO3D/NBFSrLJFjPLAulcw4ypA1DVL7UqFaNlkp9LTSJ7S1wyeJ9oPogvK9?=
 =?us-ascii?Q?jVWagMuURwB03nyQ56Nn7P6WIz6WOjDQB6bFzQu9LDM5BV675op5SS5vvIES?=
 =?us-ascii?Q?7s71HECfj72u2zhhSpRwG3MSP3fQOFfWW9eG+NJ7tzMDj9FqHY7PCiWRDir9?=
 =?us-ascii?Q?8oppROe/1crhQqyk+OwLr3kLDBmuHqR7DWLGG8+iOuKmHg87zGiyMHpD9dmL?=
 =?us-ascii?Q?0AfxFCV03yXMJcgs6h9LSEKPcOMdYUK++8MUZtB/EFbM7UQ2GFrt3zO7YJfH?=
 =?us-ascii?Q?GEJdWSde0BmWXtIGdEtgMdB+QkYhG4+Jdeuqw4tnybh2uk8aCWSJ5xIGNfkh?=
 =?us-ascii?Q?VzvsGd4xgGCbpt2egql0OWNfimIbuZIZGEfQtADY6SxgXqowFuevHPZRxogt?=
 =?us-ascii?Q?RkfTrHoMRx8KulgXTCpknRz+viqZXEhn7YaVslDNnKL74nInhkB9ZDdVABb6?=
 =?us-ascii?Q?Qo+bGmwKx8HJDe5fCKuwQM855DQO9FvEHomS3xvz4VjzSzqVlNzX2zWi9Oxf?=
 =?us-ascii?Q?/YwyZlNn+zPf+oQL7kFYx/p4cThOEyi2FJ8+vnhlZLlW/zogUK9AJCSasHt7?=
 =?us-ascii?Q?ggW64XS/PzC7bcWdcmp3xqo8c5QIpMJtc/MgXWolvyjsvIAphJXD2Blfze/l?=
 =?us-ascii?Q?RQ+F70Z7MmI3Q6TZSgnmtgVIAF42hoqYTkTmhRC+esVPPVbYr80lTOvLiyvy?=
 =?us-ascii?Q?ZSyfr50BoKcbxOvJgPkuKT+G/RLl09o6gH67Bwudgux8Iv50MILD39i2mb84?=
 =?us-ascii?Q?lGGEcbOti+i9WTNvntfHOZCI5CAOKabDXjqMmIsfhq9q62SfQxZlFez6XnOJ?=
 =?us-ascii?Q?LpxD71ufgcJsfAbSZY1m6VFcdIrPmDrDixvCeK/uws75jBCPwFaeHSkM61t/?=
 =?us-ascii?Q?t18Vvwtd40l8mdVGMEGpYwXgdMGL8wJWrYQ/QRZx8mfad6dnai9t3/RCSqi4?=
 =?us-ascii?Q?Pmiup95z/Hq/1ZNOSriETb23SjRJT4NGlK9UD6vH5qilMFXsnj79A4LPwj4/?=
 =?us-ascii?Q?GAAVjcGAiSXaGxIW6IV9p6LjH/ocM+ICOFOXv1ge?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ecede5c-8a4a-40fb-3883-08dcbd34d93f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 14:16:26.3540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WjJ5lB7EBbtVVu4PV7LgMi5KCtlnj5HuKlv2wV3uUGdMgUSjWUqZ4gq8KtjWIIP3aj9vJvilxTHhYZ2f8u28Uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9644

Add Frank Li as NXP i3c controller driver as maintainer and add mail list
imx@lists.linux.dev for it.

Add Frank Li as I3C subsystem reviewer.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v1 to v2
- Added to exist item

Recently, I submit many i3c related patches and become familiar with i3c
protocol. So add me as svc-i3c-master.c maintainer.

I reviewed other i3c patches. So add me as i3c subsystem reviewer.
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2b96899a78890..077e37eb018ce 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10708,6 +10708,7 @@ F:	drivers/i3c/master/dw*
 
 I3C SUBSYSTEM
 M:	Alexandre Belloni <alexandre.belloni@bootlin.com>
+R:	Frank Li <Frank.Li@nxp.com>
 L:	linux-i3c@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 C:	irc://chat.freenode.net/linux-i3c
@@ -20961,8 +20962,10 @@ F:	drivers/video/fbdev/sm712*
 
 SILVACO I3C DUAL-ROLE MASTER
 M:	Miquel Raynal <miquel.raynal@bootlin.com>
+M:	Frank Li <Frank.Li@nxp.com>
 M:	Conor Culhane <conor.culhane@silvaco.com>
 L:	linux-i3c@lists.infradead.org (moderated for non-subscribers)
+L:	imx@lists.linux.dev
 S:	Maintained
 F:	Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml
 F:	drivers/i3c/master/svc-i3c-master.c
-- 
2.34.1


