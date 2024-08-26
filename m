Return-Path: <linux-kernel+bounces-301022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1ED95EBA5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 10:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D639B23BC2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 08:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE5B13D291;
	Mon, 26 Aug 2024 08:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="hW2Iw662"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2049.outbound.protection.outlook.com [40.107.215.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F8413CAA5;
	Mon, 26 Aug 2024 08:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724660363; cv=fail; b=gAuSIHGT9rxC/SBDwCif9BzYHPNgRVFWqxa7itfiR39nen038xE3GWJARZeaYiLk2HA8v4hyXiH2FGY0p3fa2sDK9t+3FVFFL4Vzx3Ko3MjpD6FnjnC+XO5cGoFvQaafzEF2t+VDwivjLVuKsv9UCcdKlfIksrY8xwo8u/uyOPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724660363; c=relaxed/simple;
	bh=U0mY6AIcbBZlCk/4UgDv5JWgZIyjrJ15y3oEaSw55PM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=BZArmZe/TcHjDLQxId6f0Y3AnwEzg7cyoNDD7LPdpet8a1IijtkrYouXjTZcRtmwq9QndOrXh3W9IrK9/GDXwIRRepzfj8yOgR1qcf8j177st2wSLs/BN1Iyw7oIcyHf7fIWsQP2wN/oF8RIBPpRazvhvcblmuV8tWxb3xRxcTc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=hW2Iw662; arc=fail smtp.client-ip=40.107.215.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E0Cj5DVp/Jfgd90qeyD7BWw4MVaH1K68Kc1M04ExGA4srQ7/WWPDLwTUEIFI0ErMfwVKvZzGpVkLgOPZSpvJ7TUA6poULfJOJJNG/ITr4oLjvZCp6mumtUEpl8GYQ66ltF6Dzxi7AzKDCAe2xUIsngCnvC4gYk6Cn5w5tzkEKxUVQHHzA4thP/0hL5unygs9hDND/J+z/Ou3VdIfoa2xsZrs4zC7jQoGqo0EL6OcqtyHNlAvMRfuBwCTus1+VR6CxJeCwxF+YGnD/x27nKgbOzsm41YiMsa0iXKTZRgs70bcydj0wBHAdLtJsKuTKrmr+LZpeiFCP7aGWyTYAoPJDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IMvNq01cZxIQRzSvW44AMhazzDa0aH9XVcQg22UIxA4=;
 b=ihTr9Qwd1JFKpouFXA2TFijUgbWMdHLpsskXwx0SkyNOJhfTl4ayo2F8wzHuBRYb/8nKCEmTGldO/NVcHX/dCKM4+wp9Ck6NghI252XOv7TJNhGsEgR/ohASrJpe/3Z7GG/fQg74Eslwd4Zh4ODdvClnRdtlkUZEZEJNz6fefLPPpz65sw46NJJftM7kxdXs3Vi1rfZr6ypztcSKkQV7yZPS4Rv3n7cxPeJjLuoSd0nUNhZ44+3zuJO9EQ97nEmUBZd1SlYH1fXFExJEYzglVsHZ6fCUpbpGlG8/zucl6tflkPnDte3FxItfsB2QwmSqGFVDx01vzqvGtjV+riB9lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IMvNq01cZxIQRzSvW44AMhazzDa0aH9XVcQg22UIxA4=;
 b=hW2Iw662+7ZYv6wKn2JqW09vYEbZ8Z/SsD4EEg35cDcJrS2OVkrCbI3OLEb2gosPdYMd9wHAg8JY+CEsHCF9DWb6IRndMNBPTu7NBMLWAil4cYiR1mv7O79KtoNPYUga+C6zBPwFbwZsnPpN3iLyxAFCQSF6NHObFI3R9FM4Rb7eCnHIrQrH3kgTee4UfezkNrB6XFAlpchsJkWe55voCM703aSRIymbiGycXRlM1hM7YI07dERnZioUqKrrZDpeRoEwbYMnjJABcyOY4X2ArYlkWC2FO1V7/ygGtkUoGrbtDMQ2KaV6J92Ww+X64Cr+RguZ3/o2cDnBUsCD7kr2gw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5624.apcprd06.prod.outlook.com (2603:1096:101:c8::14)
 by SEZPR06MB6230.apcprd06.prod.outlook.com (2603:1096:101:f1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Mon, 26 Aug
 2024 08:19:13 +0000
Received: from SEZPR06MB5624.apcprd06.prod.outlook.com
 ([fe80::e837:10e3:818e:bdfd]) by SEZPR06MB5624.apcprd06.prod.outlook.com
 ([fe80::e837:10e3:818e:bdfd%5]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 08:19:13 +0000
From: Lei Liu <liulei.rjpt@vivo.com>
To: Neal Liu <neal_liu@aspeedtech.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Bin Liu <b-liu@ti.com>,
	Lei Liu <liulei.rjpt@vivo.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-aspeed@lists.ozlabs.org,
	linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: opensource.kernel@vivo.com
Subject: [PATCH v3 0/5] usb drivers use devm_clk_get_enabled() helpers
Date: Mon, 26 Aug 2024 16:18:56 +0800
Message-Id: <20240826081900.2284-1-liulei.rjpt@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0052.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::20) To SEZPR06MB5624.apcprd06.prod.outlook.com
 (2603:1096:101:c8::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5624:EE_|SEZPR06MB6230:EE_
X-MS-Office365-Filtering-Correlation-Id: 01437f23-c55b-4820-82d8-08dcc5a7c482
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|52116014|366016|921020|38350700014|41080700001;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ihl1pFr6xIhLUtU+6VNwpFyBF7aq/SF/Tro3+nz7Z2z4551O0WU/Mqw3JVaE?=
 =?us-ascii?Q?xMJCCOGwDwI3g9q58CijQ7s/O/I6Iuzv7rJEeA+hMAthte1c+6+pnrwOXJ+/?=
 =?us-ascii?Q?k2ARDTr+J/IiP+PxpbXQVtm1Hyq/7/WWQuzJAIR0s0vWwumYVAXzDGmAyVes?=
 =?us-ascii?Q?WArlAt/xkkzDC2CVsCe3adwRm6DZbNSwhr1nlZxvvaafLolGl4p4kUOd7tN5?=
 =?us-ascii?Q?9iOxgf2ASPAICtt/QE7qCPeV3LamS3075mag9qo8wcEeBRnjEEcYdr5iVO5q?=
 =?us-ascii?Q?PkrPlstyIVvcg2jxHTfF8MpHxOkvNmXKieErg/sJQmS6Oq7zPFiDaXfXdyfv?=
 =?us-ascii?Q?REy+rwMM3FQ3jUFaaZ1U4yKoCnB8thQOofLzlvBwV8Qm264CMImRfDfdt7+L?=
 =?us-ascii?Q?RkowquNzwaeunNzgslHkxX8za1uneQ7uT81UxCDcwapTO9LV8c/Ta0SJkRwb?=
 =?us-ascii?Q?ql8ssf5XDN3fzzkYUwybiyZ5nitQKMsF/fvGAfHYsWLDDRzCP6mCcDifRO+S?=
 =?us-ascii?Q?dNjNituOfJ7ED9PE4ZMUqoEWdjaUrDbfo8PMVwKzkBDYkUEhrWNBca4nPVXr?=
 =?us-ascii?Q?ssx8g2uptB5a6Q0MYx4u2I19zBYLVwr5oFnIgzQ9rCMO0zfS0FB5nIH0YDxK?=
 =?us-ascii?Q?IS54uDD6LdjICA+Jx9RT0KCDbDsAw6unQ6KBLaZv4Xz4Gq0t44Bj+vyqEeBA?=
 =?us-ascii?Q?EPv3PbGCcUIRjxK7maZPp80n8F6x+Lft8R2j5fvc3D8UdiL5pJ+7Cvci9+hP?=
 =?us-ascii?Q?iER/1QIgsU2y8V14Elf/94tyBF2xOMj7JBWddg2jyfSlfEJa09O4g46e0++o?=
 =?us-ascii?Q?kaRbzC3wRiG8bhxHQp5oIFtoNlXm8tNrKUiGncjvVECHzBlYM6zDNuAMJIWJ?=
 =?us-ascii?Q?PB6aSl0TDQSt9u6kLzcwhiGLVCb1PYXVkczRyKEeVvq8XSSZtTluI67MgPFl?=
 =?us-ascii?Q?f4VuzQFrVAYY0cx5BF1aS/8HQcTc90wQTO5nsZHVyyi0tINySnsYpGNKx9N+?=
 =?us-ascii?Q?Ge2X9ia5GDAdg3CO4C+Uze6mjSpKfbEWjMlzhHM8diQ8JPXe10uZtpsBYrvM?=
 =?us-ascii?Q?EGHshNQHU0RfoClxDeRFjfT+6F+xAMQjkDktd9zZVwnM55UjZ28ddgA/d6Ty?=
 =?us-ascii?Q?MOd3d6C7nEkxLVnhQwDyLY+Wt1tZ3WJ4LdgpOtcPh/he5qdLRI1Sb3yyaELN?=
 =?us-ascii?Q?7gTI74nW990LaY3vq1q9fIW0Wq4xJpeWM2cwMyAj86xygeQlyV6kRgU/Evr8?=
 =?us-ascii?Q?rwKQYEYMmPIJZWoMMiJT5SaucyiPHHYJh61uVZsrfQfGFEBD058kzGUf72kX?=
 =?us-ascii?Q?zJUe3qI9t5Qbc42QmGqA/XarwVarp9V0O4WATQkb33NKCSy6e2nZKthUPi/O?=
 =?us-ascii?Q?eXRRx3ghmtpFsrJ2KRs9lBH/iXEa8wA2TyByOjEYQbNisq1SUe2OXD7xNIS2?=
 =?us-ascii?Q?WariSS+E9lZEGLDRO98v5TnOKBKbsdJU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5624.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(52116014)(366016)(921020)(38350700014)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+h22mhtgV2U85YSWDExyPtR0yM5nSep2f6NT8saYkkeZhRGBjXqM0AuFES3K?=
 =?us-ascii?Q?gUoOktNJXP8AJVDSz3jVaaDSJPvAUeCLQGh4EZqGuq0sFeAFTuQsQv8Z+y/D?=
 =?us-ascii?Q?vpczqLYDRNZrUyj+KdQOllPc69WOr5fm5RxQu06thvreyU9FxXyjxhvPx5LX?=
 =?us-ascii?Q?1iSeTa6chKFSc5mNPOWAu9muaXCIao1yPKP3IDLktVLa3uNo6sNzvp/4BhRJ?=
 =?us-ascii?Q?mcQddg81/taPsePylxsq/j+RBucbSuCHdmQbJFml/hPZKPCH/ExZFP9c3FOT?=
 =?us-ascii?Q?SYr5PlcWxsARbAL8rg8hufKtbke8ODBrO1mdOtfXSx669QrCl9ESftqE7mOk?=
 =?us-ascii?Q?eA4eLAyW8tu8gAt/dhw6HbM5V2x/sznst8PVtqvfAv32EAzkeK6qDWu6UoJC?=
 =?us-ascii?Q?EXS6S/5480z5c98ZBcjd+qrugOln4FYE/hRoInpms9u9p4OTO+rb+GEB7vW+?=
 =?us-ascii?Q?mtjgpBqD3xRQo5sXrtyowbVULs+ui+FqUvT6MDuv9N52cxklTbi8arfipg5s?=
 =?us-ascii?Q?zavUzhbN7xxwm7nzZr5MJUqLgtMeSPcCSK1lWN1/LDKMeYn305nRYwLjodZ/?=
 =?us-ascii?Q?5uSR8fps+9DoSOMKYsaQCV70xohxtrbojfUtXouFDqCSrCJzgzyym+p8C8V2?=
 =?us-ascii?Q?EmQuNuDv6Us8uJ9wnBdz6gI+jkiC8UM/kerkxH1D6VryYA4jc4h2NJHvqdno?=
 =?us-ascii?Q?qABl5ELcpbCv4lxLPOW5HHsTdXRjBwzz+kKmxVUWUzYbdK9U65jygiSnDXzH?=
 =?us-ascii?Q?mzCJZ1wutzLjXD2PMjLdCLhYKjaHrZ3WANK/Jg7QuB6NBzvmlODhbOdreWfV?=
 =?us-ascii?Q?cEHTbnpPdRu7mTwSg7aYJE1WXYw26+Cz625oK5Xlnqb/r3q+6g5TNid4CdXQ?=
 =?us-ascii?Q?7WrefU41AbNTunFTl+I00V/LGldpvUfRH++mfAuTB1q//TXc3S8FkC1Nitts?=
 =?us-ascii?Q?59sFcGBZDwyGEvDvZ3I9BhKCq+KdtowIMPGdQL6gfTUb6tu4FLpzhNxJhbE5?=
 =?us-ascii?Q?1Hgl/eTkN0gcxUeLlcsSQJmegNG1jaESobWM/yYDPA0Ya5ZizlpCQNsJw9Au?=
 =?us-ascii?Q?jqAO4Jcw6tTuTvVMbsbH/sWq96oZ2QIuMLIkAFkXrqtOYaskVV1fAOvM3T33?=
 =?us-ascii?Q?HudQqF6aUYFrVZlztgwdTLqqn5rgsKnWJ6QVH5bkCQvjqgFPykiCN1S2TANj?=
 =?us-ascii?Q?3/sWtWaSDBbMMbMg3EmmhOgAZq3D1DV+Uag+PKc/rH7eg8LtoR77Rufmodfb?=
 =?us-ascii?Q?qk5Hx6iQnVZGoHe9piGYg4uE0oz3dR9zn4iXWoLofOZltpLL0jVT1VY2K7Q6?=
 =?us-ascii?Q?SA7CbQ/2GCZb/uSqt5i3YORJf3SgE5uM4/xf5Yvt/mKFJd5lxoHqryAtFaa8?=
 =?us-ascii?Q?OVbZbVMtQwzbVnDx3FKLdF3mDc8RgwHYc5lczCN/zeWqgPlhIN5lM2x6FtT8?=
 =?us-ascii?Q?sJeqBFFTd0V6MOsq+pPaJky+IYXC5mfoquGL0f+KMfZUMplJ/OqOlhS6oh2D?=
 =?us-ascii?Q?4s06SmoXnfNk0+Gp4bcOBvDIwEJ21snIICcP+jRxe0cXK68mLS5KXSbpKEDM?=
 =?us-ascii?Q?nmoUvxl9kXIVNaAcZO97fAQcVe4JL6C8EeWG3XpQ?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01437f23-c55b-4820-82d8-08dcc5a7c482
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5624.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 08:19:12.9184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rIhUdHxQIG7Ckm000y7dLiE3ApajsXetHk/JLAnBtBaZN9BxlnoBq3OtpgNJUxVeWIifO6YOgYqQ514CdIBltw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6230

The devm_clk_get_enabled() helpers:
    - call devm_clk_get()
    - call clk_prepare_enable() and register what is needed in order to
     call clk_disable_unprepare() when needed, as a managed resource.

This simplifies the code and avoids calls to clk_disable_unprepare().

---
version 3 changes
Fix the email thread.

---
version 2 changes

The files ux500.c, mpfs.c, and pxa27x_udc.c have incorrect usage of 
certain interfaces due to the lack of synchronization during the 
commit updates. These issues have been corrected in the v1 version.

1.ux500: Incorrect usage of clk_prepare_enable() should be corrected to
  devm_clk_get_enabled().
2.mpfs: Incorrect usage of devm_clk_get_enable() should be corrected to
  devm_clk_get_enabled().
3.pxa27x_udc: Incorrect usage of clk_prepare_enable() should be
  corrected to devm_clk_get_enabled().

Lei Liu (5):
  usb: aspeed_udc: Use devm_clk_get_enabled() helpers
  usb: pxa27x_udc: Use devm_clk_get_enabled() helpers
  usb: r8a66597-udc: Use devm_clk_get_enabled() helpers
  usb: mpfs: Use devm_clk_get_enabled() helpers
  sb: ux500: Use devm_clk_get_enabled() helpers

 drivers/usb/gadget/udc/aspeed_udc.c   |  9 +--------
 drivers/usb/gadget/udc/pxa27x_udc.c   |  6 +-----
 drivers/usb/gadget/udc/r8a66597-udc.c | 16 ++++------------
 drivers/usb/musb/mpfs.c               | 22 ++++++----------------
 drivers/usb/musb/ux500.c              | 18 ++++--------------
 5 files changed, 16 insertions(+), 55 deletions(-)

-- 
2.34.1


