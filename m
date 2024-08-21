Return-Path: <linux-kernel+bounces-295467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C83FA959B55
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 14:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EF281F22B42
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 12:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F07E166F35;
	Wed, 21 Aug 2024 12:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="pWKcRnPS"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2050.outbound.protection.outlook.com [40.107.255.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95AF32595;
	Wed, 21 Aug 2024 12:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724242273; cv=fail; b=FMsoOjw93txlBUUqq+pGfso3foogA5XvvQCwhbKGUJe708wKIJlcqbOemaXNjN5YfFzg7238uVDFIUdfoHcmxRJYOloZOXbAlitBFfewghjjz5tstAgEnskNfjSWCHFJ7mnQty+GwTVabbw+0sOQUB2UsCvfYyUWSXjSAcDYFpY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724242273; c=relaxed/simple;
	bh=hYmmk9vo/WEA+Dhhav6QgpSqo2FGOIdjC8P9qZo7Zbs=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=uCWbKjUHmEQYGE9uS4hl14ybDVdCCRFAPCGUy9WRuFG7juHake/4U/zVUlklHoig+swbKYMk9OrPiJgoizm9OMP/cqT4LgoMIW+6H3oLkjRKpesJMr6SMzy/TGI/jjXyW7zlRtMTFiO/GjdgVEWocccJk7OhDHwjqDnOiMcmrB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=pWKcRnPS; arc=fail smtp.client-ip=40.107.255.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V+10a1hFml8nd0/0Mrv1JiT+gCyTEY3tY3iREkc49jofzvgkkcodJ6cyUGGgH+P45DdRWq1zVrOlIxviZP/eFOcdfT12Oz2Q44tsKC65SFxbRoHMgdpvJ1yssw6ShUgWi8HNIlF/X+lspWWHNtodmqGwwMMT2iC8NfG9lTs/zeC0HS0nIxT39uJXHfFfQ1ZinBPIjVemMWwq0KC9roeKG018N6WK3jH7kMSNYyJ5HtuLEC8xTHVaT+g78wa1A3eXao35r78nM7XInMmtpjscPiUu5ndHg3/h8eEetVIxpjRL39+xVX/unX0KjCXhwfePnmlzUrg19aiZfDHQlQdcyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3f8HS+mvtUMnxTmPYwwLk1Sfi9r2R8FY91CdfdmEm/g=;
 b=R+yWzeEABG89bH1J7mk0o0LUhb0SiiyVjhNPU+Q6DdKcFNAzVqCcRWKriMiVQLU3CSXnW+d5MapG1Z28yaM96RZ5A8X7Am3imIAFvOcVoflLrTGp2PETKhWXKfQRsXP/stbnomchQ4KRiNmr7j9wonDywhptwi0B+zO0bJZMsg2otPDSi5sVGuHsU3sdPYNwTUoXg+iTEwriR+XYjE4DRd9H5wJueU22ELneT+ri+yisGNmL1GgwIB1cSWvkD2hmftMqFe0qHgUE4npENjsltkz+mUIKoUtSZVbWcdswzU4kmP44jbFPrA5T7zG/A0Q3YEyT5dJj1tFfs7a9LeeCYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3f8HS+mvtUMnxTmPYwwLk1Sfi9r2R8FY91CdfdmEm/g=;
 b=pWKcRnPSxkWM1upj5nZaI64ZRxeFEYqHnI0kR73iFCSUkqDIxib7XGSk15KBVkCHfdyHX0a1vyFAdeAt5UTG6k4YYty/cmApSH1rpJJEUAngZYqsKRR5hV9LWrFxvsMSnzr5VGqDhrUloTJ2jgLt8veLdWd4pxQfXuEQNn+46g3x/2LfD9wiykl0QbAFqzQpou5T6gOEiaoVqJdtBZ6UhPI8ufWwkwiS6/n5BOVtJrUq3rSYfPhLiImcuOqROzNEl5AdDK6tS34Ovct5QkYH3nYXc/yrCGXqL7Y0Jqhu7H+HRrSMtOvOjMAziG8flgE3Ajf2kywDmbyuUADHxCXgLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5624.apcprd06.prod.outlook.com (2603:1096:101:c8::14)
 by JH0PR06MB7128.apcprd06.prod.outlook.com (2603:1096:990:8e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Wed, 21 Aug
 2024 12:11:03 +0000
Received: from SEZPR06MB5624.apcprd06.prod.outlook.com
 ([fe80::e837:10e3:818e:bdfd]) by SEZPR06MB5624.apcprd06.prod.outlook.com
 ([fe80::e837:10e3:818e:bdfd%4]) with mapi id 15.20.7875.023; Wed, 21 Aug 2024
 12:11:03 +0000
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
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Lei Liu <liulei.rjpt@vivo.com>,
	linux-aspeed@lists.ozlabs.org,
	linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: opensource.kernel@vivo.com
Subject: [PATCH 0/5] usb drivers use devm_clk_get_enabled() helpers
Date: Wed, 21 Aug 2024 20:10:38 +0800
Message-Id: <20240821121048.31566-1-liulei.rjpt@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0069.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:31a::17) To SEZPR06MB5624.apcprd06.prod.outlook.com
 (2603:1096:101:c8::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5624:EE_|JH0PR06MB7128:EE_
X-MS-Office365-Filtering-Correlation-Id: 15a280f8-8c58-48a8-fd8a-08dcc1da534b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|52116014|376014|921020|38350700014|41080700001;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4FkJamL3+5OJCJu5xm/gn93MWuhd3WD5BbnHNiVTcVECFaEdkOOlDb+prUrH?=
 =?us-ascii?Q?H+TvSNAo7Eyndq/E/kh2M50shy/0oFxMq4muHiGrI1WHBA3dZhneNWfqLCN7?=
 =?us-ascii?Q?NNdv67Q9Y36x5gPrpU0QObk2zyp9uw0iX4DCdUtHHPEZam+hbY7UlXWGTb5V?=
 =?us-ascii?Q?HR+2rTIb16CmC0uEY8eSYaNHJ1Wcx1nUSnuTNaAP6PeAr9i9V2q/JvRnzChY?=
 =?us-ascii?Q?S+5kTYAvLTn9AvOKALk0O9RcIvKjSO/+f7TqMLXOtowEGLXY3kg0i7XXHmA/?=
 =?us-ascii?Q?1aB1uxXvAYDOpYxb8iRgbuJCqciCvb7NoFEXX45bT3V+ZNKpKr/MidYxURIf?=
 =?us-ascii?Q?vmp9MVxcyR3hhPxPUV5bkVOezADaFaLO5MghDmUxh41yVLZ36ulzsJbWwaez?=
 =?us-ascii?Q?sFvXcdYAfUVwlziYrNfJCpWaEd1pvxpJjC0z7Sti+/h+l0/Xbb+QeTcaErLM?=
 =?us-ascii?Q?2a1yxAgxBK9a5Ghu15wi0ICNf5mbYLfQl0d3Afdk1q8tITOq8gG3wpT0tr+M?=
 =?us-ascii?Q?ehLBa5h4rGpST1++uh55IYZG/Ywcoy73xID4uFFpM7JWPp8vf9EXNzM5Dkvn?=
 =?us-ascii?Q?YXJm5gDAB5kVzVPqP2Gg+Mi7o/P9TW+NCbXri9KgLcSvEEVYCKWXfrbcJeVy?=
 =?us-ascii?Q?z1NZt7jcY0uGMdnKSVaq5SS3xl3GIt9qh6fhpW/k3ILvibesETuG6eIQZaKp?=
 =?us-ascii?Q?REE5fR4zLE8IXUAvBbc2BUFPa8iK9+9BS2rhenWUegPalpcw14Ko1+6a/pfX?=
 =?us-ascii?Q?x7toU94C8T+E8wY85pyOrfej+9mgIDrHLQcYCPD3V1lWHJ1FxdZX9RoJMITR?=
 =?us-ascii?Q?zr9acPm5eHNWlR+T85W6hV1XwlCua5CrZnEOaVNtkLmSI/OvlS6JHC9OKNS6?=
 =?us-ascii?Q?1OL5N+thveNpKwjz+rcO0/SKW8EmL0HH2T5IqidIa9ZbMEfumJF6jFTDuBb0?=
 =?us-ascii?Q?u42okymCz0UmqFF8rGlNqNjMY4lJSgi+nrjWQxWm2TlUrMjjMBZMZY+czRNf?=
 =?us-ascii?Q?wRvM5kRstB9CzO0Ru+WF81eJv1RUn+b7+LCoXkY91a+YXbNz0RGCxHzLDmgJ?=
 =?us-ascii?Q?BLtkekkvQGVqSGq2sGZO/biA52PsPDSb02LyY0QUc408CUR/xDHXEyZXs0qM?=
 =?us-ascii?Q?NVGiMQA4iO+s6IoHB8u3Tl56H/N2is0RFkSLF1kaX0LoeYQaBpf62w6HDSl3?=
 =?us-ascii?Q?NIRyF/gkiN0UAne5p9euguYDU1cA9lGVkTko40ZpDVjUN/OXtugyrkaasWMo?=
 =?us-ascii?Q?LPEhvVKUCjctSjtQdRTzZgNMT5p3E3BDgeF/Bzuff9jlvqEKwZIeam+94gjW?=
 =?us-ascii?Q?hMbOJz6mVx/cpziga1jeZYnw4kV+bxqocMp50TR/7MaRWR30wktgZ59BTj1v?=
 =?us-ascii?Q?e330nZ1+JGRx7Dec2EqPQcRYHTgeSBQZ/Y4Os32BepOXjynRj+fbb6yQ/Urj?=
 =?us-ascii?Q?v9jW+a2H97H4V7rDc416yElkpqPOmkn2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5624.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(52116014)(376014)(921020)(38350700014)(41080700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2kHilz8LyKbRT+2fxMwbCm0AtYqQZOJLUxZ4QgWVSJ31FS/XmGB0yGEAfvJx?=
 =?us-ascii?Q?4rs4OaYzb3Sbfkw4/uGjX4Q/rBSTzrm5RmBrss9aGXDM6/zsqZG1Y9Cz6pFI?=
 =?us-ascii?Q?BIl4jdBMuwyGydJv+jOB4QqDD7rGclYsGyHxhGPsRkX320DYl/K8qT5IyzQQ?=
 =?us-ascii?Q?HW1nYQF030lgHOQ2GWTSJMK7TTI9l1KZhzgN5G4Owm8udoS1jhnId4OL48Hv?=
 =?us-ascii?Q?H666WFFYWlsSfZLgVxMdkskXJ3V9fQ0spi3VHSRgkH+R4/57u2t1d9KHSG6X?=
 =?us-ascii?Q?virK6GDe/jpxofifx8H6gabhBbsboS53m9HVo47ssw0fOhg2oRNkKfcDKrIZ?=
 =?us-ascii?Q?z3+Cr9SzkHtjRuEDUMLJ9ogo1wmQz8Xv2OovNXHIGcaTMnqvqFFWXVeKjMu2?=
 =?us-ascii?Q?e6I84kD/AbTL37uKVUwb5uDKZWuB9o5sHHwWa69wBwCm6WqF6gXlrx0WrxLr?=
 =?us-ascii?Q?Gi3ial7Zf5pC3k+iqMZ9Qc3Ry5uQFyf9LLgRkuaGd0hkJc2bNo3UJkoQcMqU?=
 =?us-ascii?Q?/9lXIDbH+gwXKECUnUYw9+2kfdnam7fobNuMwp15pZQ70VDedlIjXsXfm3Ga?=
 =?us-ascii?Q?GkD/8XdFH4+r4ndu6jvJJO/5fOnteL4Ot1VB0HglSqXGCbbag6UuVE0fG/hm?=
 =?us-ascii?Q?kVHHZCM8CFWT8q9+fd8GJ8gKp8vU37tQZFBdr8DWge3K3lxULRrfFnRbsWx/?=
 =?us-ascii?Q?HXUvXCGoFQOAOBWKUwBdtkt0rIQ3Nq2KX0XSs30zUXIAagH6h0BjDBhDns0P?=
 =?us-ascii?Q?CTuvQifG0brJeVaXg9qoKwYMTAoBqP54C4mSDlcOSRgWG/iy8aJ7L6/hiKLY?=
 =?us-ascii?Q?FLCEiTTvAWA1P+a48ghRvHgLHAcmrm09h8K0zLOFOgK+9qoEJiLYyKRbBYnR?=
 =?us-ascii?Q?XGW4fmkWl54C+1mmeyBV1nG5WwyMAcM3gZbrBs0NCPsPli9caRJKhFnXZcfj?=
 =?us-ascii?Q?YI46IAe1KSUKe0FCI92BEf8WgRDzIBES9IIM0ZEnDhbVDiUgvd0PkMV9eOtB?=
 =?us-ascii?Q?fj02wJUvG+W6/foQepXUaEgYdStKnLDRqAg2AOnv6wkcFv/mpbUxVmjljoQw?=
 =?us-ascii?Q?dFYD5NFBv1uYji4HmR9oX5A++GAfiy/MIouNuJb+V+xAmI6YZNDfQIKwPdX9?=
 =?us-ascii?Q?+/IXnHy7YPaZfFZLR5netQtDYkWtfzrfRfOtqAqNhMCNrjW0Ca8oEZWKTUn8?=
 =?us-ascii?Q?lsYl3gzPCbz22dMQHpSpICXnrLyiMuJIQbVBuWkQ+MtryrUSYtGLTftnDd6B?=
 =?us-ascii?Q?6YPPRcP3ICOrIbJNjJ+CxKJVbhVN85olml7kHbo9b0x6aXhNVJ03IbYNh2Lh?=
 =?us-ascii?Q?xAqSVoRGf+aQ0EHusBnw2iJ9WqbjhnkUac0uATRUBBGMD0LbISYMX2dsJiUJ?=
 =?us-ascii?Q?pssDbunflyJmx7et9MEZvqH/Yc7nz7ljrujlfuKCRRsAFjiu4ml2ga7XsbQc?=
 =?us-ascii?Q?2uLz2HGknbCNOk88io0UbwgkJknTU/XaZhTgNIkjwOmIFm+hbFW+/W2bUC1E?=
 =?us-ascii?Q?hweVGukuPrPyqs8EkL7coLk4lnDKF2pbLsXnkSjlXV2NZNf8yhVbkInqBl8p?=
 =?us-ascii?Q?gagSiJzW8d67DrZ/T+gIdlKKTOhAXF3ZKWe4qbGp?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15a280f8-8c58-48a8-fd8a-08dcc1da534b
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5624.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 12:11:03.1692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IuOf5akIYo70LbSq1V116yL7QGIXTa25tk30d3yvtGBsIp/YGnDXD+NErQ8cHbj3NK9uWgD0FHSTkhlCyCqCYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB7128

The devm_clk_get_enabled() helpers:
    - call devm_clk_get()
    - call clk_prepare_enable() and register what is needed in order to
     call clk_disable_unprepare() when needed, as a managed resource.

This simplifies the code and avoids calls to clk_disable_unprepare().

Lei Liu (5):
  usb: aspeed_udc: Use devm_clk_get_enabled() helpers
  usb: pxa27x_udc: Use devm_clk_get_enabled() helpers
  usb: r8a66597-udc: Use devm_clk_get_enabled() helpers
  usb: mpfs: Use devm_clk_get_enabled() helpers
  usb: ux500: Use devm_clk_get_enabled() helpers

 drivers/usb/gadget/udc/aspeed_udc.c   |  9 +--------
 drivers/usb/gadget/udc/pxa27x_udc.c   |  6 +-----
 drivers/usb/gadget/udc/r8a66597-udc.c | 16 ++++------------
 drivers/usb/musb/mpfs.c               | 22 ++++++----------------
 drivers/usb/musb/ux500.c              | 18 ++++--------------
 5 files changed, 16 insertions(+), 55 deletions(-)

-- 
2.34.1


