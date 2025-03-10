Return-Path: <linux-kernel+bounces-555223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F3C7A5A720
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 23:26:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D030D175127
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 22:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58FEB1F09B0;
	Mon, 10 Mar 2025 22:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=LIVE.CO.UK header.i=@LIVE.CO.UK header.b="amHA69b/"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05olkn2058.outbound.protection.outlook.com [40.92.90.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A4D1E9904
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 22:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.90.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741645520; cv=fail; b=fHW2i/4VLCmyI7Hq8uNTJfmYiPoqABeVzfbJhkXiDm4mxFN+p5CmXlGeFLJj23RPGueHERwUpDYzd/IeneVJsaQNQ9mIA+tgjVe/hszIopJvEVuRQYrZyULsULv1d6juGaLW/ENZFIIOZEoKGh8vuW7I+EC6dwvbUdEAF5uVKIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741645520; c=relaxed/simple;
	bh=zrb0bAjjKc9Q0UTd4ucL/UUAOf/TKjixtYKz6RdDHlA=;
	h=Date:From:To:Subject:Message-ID:Content-Type:Content-Disposition:
	 MIME-Version; b=JrkhtJsYWW3EtILJY8iD12/pg3QlsbQp8IE5FH4kR35sO3KZInNlQYYLC1/R9nJetU+XHnSo3EeLIi4J7Z3D4S8ac7C+1QtM3tuHVesw/1G82r16zLTiWmAJ/+jZbOvqv6KCkXGiZHduw9hhvKpgC0nNX3QxUrX6yKcQ+YlCQpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.co.uk; spf=pass smtp.mailfrom=live.co.uk; dkim=pass (2048-bit key) header.d=LIVE.CO.UK header.i=@LIVE.CO.UK header.b=amHA69b/; arc=fail smtp.client-ip=40.92.90.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.co.uk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OagNFcjXdTqtUmlYrLWJCXRnEs+iqy/IsaHNE3QH1J78QLvNMp5qDWrOT9CO4yKb6kalk6ul81HdM1Aig/0f280bfGCYXo5aJ5Ar5DJjpfPFrO3E5jy0YdVvZiGnfyHq+vLfFn0VKAgDXUH38hin8B/h1Ufu8ElGED9yDB26jQ9M5rz5unutWGiCnaA6IfjXmrcQOqYUq3TgbM+wkjCnViq/qUjz6EQddu/qCs8djOI1/Y16+HXioDuQ24rSzKklN+5z/XGJ0NYHxmc4mD/b+QncZFPASishIGgGP7UqNyqQ65Ixv3lMqhXszm4QbumKKDDejCLxelKur0Li/2vlFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s3BUa3zO30AS7g/lTncWHMjoxJnkxNYo3X9JU+3FNM4=;
 b=nZfNPoNY4nWqtSXZsJeX8lziI3/HWJ56I8kkdtstDAZOrwAzPYq6u0vE5Pk+F6mTj3pM3OicxcTrRgHKB1gvQWCTK7Gkv5TVEXoYBbMrRqrJz6X4wglB5vg8xgKYZvcvxk0VkXF4v207MF+UKSaM2yerL6pYjr+yD7RQqR4PvbornNxRulcMugq2kqKHeBlvukV2bOgVCn5DdIzT5bSOj8p/WJt94z9cjYvoJnPIeo6ib48Px9VAnzezdENqHh9fYzZIzMPkm2Y/Wj0PWn6cs65ZcokVq5wwUqMgejeVTsBC/dWMOdhu87YDfTNqKG9wKsjsYHSxA0sWHeWx9ukINQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=LIVE.CO.UK;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s3BUa3zO30AS7g/lTncWHMjoxJnkxNYo3X9JU+3FNM4=;
 b=amHA69b/b6LFr0FNq0Wx/DwN0YcU9VXnOWrFEvKaKQh/n9IcWBer/Uzll1kkcbdPDrc2tGG39RFShsN0nYyb//YEEx/EMFpLcDI/P5/TGheM/aT6e4FYBIY79oex2rqEUU7nURSku3D8nGRgvMn+/bnDk79rY0zyK3yAflTOEx6Gd11CeLN19GTfY06vwuOrVkBPHDX3X1urm1/8SQoUVxOf23RpDPlkbdh6Tk/yFRSLL8qBzhS1ySQwpek0TL1LG6QTjlFvuuO2buzV7xt1J3KoBajUCvvnUH1+MWCVFChk0+ZPaholkA3LmxPGc6ckdqWm2eGFyAN4W0HC+9whVQ==
Received: from DB7PR02MB3802.eurprd02.prod.outlook.com (2603:10a6:5:3::15) by
 AS8PR02MB9091.eurprd02.prod.outlook.com (2603:10a6:20b:5b7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 22:25:16 +0000
Received: from DB7PR02MB3802.eurprd02.prod.outlook.com
 ([fe80::879f:859:ac4c:9963]) by DB7PR02MB3802.eurprd02.prod.outlook.com
 ([fe80::879f:859:ac4c:9963%5]) with mapi id 15.20.8511.025; Mon, 10 Mar 2025
 22:25:16 +0000
Date: Mon, 10 Mar 2025 22:25:08 +0000
From: Cameron Williams <cang1@live.co.uk>
To: sudipm.mukherjee@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH] parport: Add Brainboxes XC cards.
Message-ID:
 <DB7PR02MB38021759513B50CAED9A939BC4D62@DB7PR02MB3802.eurprd02.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: LO4P123CA0211.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a5::18) To DB7PR02MB3802.eurprd02.prod.outlook.com
 (2603:10a6:5:3::15)
X-Microsoft-Original-Message-ID: <Z89mxGhVi68vzAUT@CHIHIRO>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR02MB3802:EE_|AS8PR02MB9091:EE_
X-MS-Office365-Filtering-Correlation-Id: 22a25839-37e3-4280-b4d9-08dd60226b7a
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799003|6090799003|15080799006|461199028|5062599005|7092599003|5072599009|8060799006|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OmV0IadO4Thw+XKcBWxqon1jPf07mk0og5WHnzjjawTrtljWUfc76FfRzJiF?=
 =?us-ascii?Q?kADlQjm9Y2mjps3F4fKRrOt/t1Nn3YyGuZWnBkj5IxUA2IxARIt30/yOyJ5L?=
 =?us-ascii?Q?6JY1YUPHDE+4l+e4msQcvwEs0cvR4VpCtxdGZ8/CDJowHWLj4hwueTz8/abP?=
 =?us-ascii?Q?vXTM53ykZMGCXto6sbO9PSukCztRujBO+MpKWzQ4jZtgClGPA3Iwkz80M7ol?=
 =?us-ascii?Q?NW04OlM3yKB+Gha8e5rvFPoI6ptABe4d2W4Gnc6YRVhouxHBIHEe0dXy1tKb?=
 =?us-ascii?Q?TXoUmeBnJvjTM+iqYQ4qlCoYiW4YauFyr6VYb8M9OvNIcnbOhhmIy5TWneFu?=
 =?us-ascii?Q?39Yy0jjKSM9miEYfrbzgLMESJUVaHOW0iBM3wd53EyUjvyE2Ex5MFJP8rg7q?=
 =?us-ascii?Q?IkNM1EBYml9OUjcW+TOHsMBdrRHwvTvsHKFBGtQR/zQ9GTFZ4IAy/OaMSFKX?=
 =?us-ascii?Q?K4K/o6F8Eqmge6ajgpeLXFAGPQ4RXzBWEVx/gdiqtYHCLnPUSfkFsrdvnzlZ?=
 =?us-ascii?Q?aNbUf9FBmPIsm5a59DSLuwbcS0KQMX48MvaK8omwucprHr8C1F2/sgv93uyt?=
 =?us-ascii?Q?TDeQw8MTBND0ttAcEgDm5/g9ScGD5AIJCUL8txyC6jo90W2y0OLgVjeD+fUY?=
 =?us-ascii?Q?+ZhW4R3hZXCez12qlUBkZ/O9nKwMF8eyRwy0gEdkwF0uABU9VmfrbaD6KvNg?=
 =?us-ascii?Q?VPfXY3/jaUtA5ouelSfwUQWeCdvnXgwIO+kzHfrlOIRmv5YNTb0+I1eKK4Mu?=
 =?us-ascii?Q?sAnJF0hlgCZ3waFPPh/Kod6wdP53+IjPibNtFInRV2co7Nz3e/wnza7ZBF/w?=
 =?us-ascii?Q?O0u8L90derJ1A9aLrlWuvo6l/F4AbZYzH0Bi+2FzM/YLvmOwgnYq1Wh3Ylqr?=
 =?us-ascii?Q?zbgcW345GBEJqLIGvpaXK8VZtyCrqX/mX9XSulWo7GhPJPZNxSwG+gaqCxmA?=
 =?us-ascii?Q?TuY18h+27++tWCstBVdki6oaaYbJRrSbkpZ9foJuzEedolQuVtC1NORwRKfA?=
 =?us-ascii?Q?/C1IIo9rJNz5L8cKumHy3Drn4Z8htQCdkeXQm8E/pGvFywK0NenBypEXXyDv?=
 =?us-ascii?Q?2vU99oP8joPqO/McfPgVEU5ictVrDkGgiqFNDuNAkh9hI/lTqHXkbeACuU4m?=
 =?us-ascii?Q?yrw2E0VRaVao9Fk1LzVREUeoLo5d3AEmqA=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?z/abjz8hPRexr5eaXHI1oGuRqX4eCuYZJt0FAltsIviqYrYbb5CxxbSOtayG?=
 =?us-ascii?Q?poq45/t0sKRCRNSVrHPqaaEUjgWlUWaIwjPvzuHl+9NqCY1HwNJJ++DyYCo5?=
 =?us-ascii?Q?WMq/0qcaPhxJnxmJjVcr5ocSiuMNj8zlvnnYrs2E70ySTMjE2QoyRxjYkbVZ?=
 =?us-ascii?Q?Sp3Ne5iMSwjyMt2zsCpH85y41htn6AwrvESAEaH+Kxko+9P07k3kdiTM0eI7?=
 =?us-ascii?Q?Jhx9ciwxs/aQ8UoABXe/NEz/Ohi3UH5bGPcLK1Gm9nwL4X8EvciES0uzWj+X?=
 =?us-ascii?Q?Qpi+lOdkGX3u97Glpv3ubPsorGF3jOEnMJ335P/HcuWZmosTlkVvir4MhBr+?=
 =?us-ascii?Q?EhPMKUm2bR3ybZTjigJv0u4riPMPA758MOcaoci5IWpILcCJXC7+GHg1Ol7T?=
 =?us-ascii?Q?gOR9DnGjhbDREyB9cLjGp9sUWd1Uil7G6d4fpC0UkOXJOJVg5zuuxJVq1ry9?=
 =?us-ascii?Q?g+vyi+Uotkn0XBF1AYCYRzmS3wFjzRl6Q1/GBvCd8ibbNZjTUH9kGmtyt066?=
 =?us-ascii?Q?Gwlc6W+7idrXoJLTTit+yL9b/867JOmBc06rQGRszeG85RQm8dTSr7zCWfFQ?=
 =?us-ascii?Q?R7XwCQmjGlS4egYA/kJuUTiQzQEY6wWyswqUDzIPEz6apzkLe0wJx4YxtzVA?=
 =?us-ascii?Q?OZNAA5Hb4CJXeAG0VjaN95YSZO6p2bmj6MCdcqo3s7KSYKgwsrIXVoEfODOG?=
 =?us-ascii?Q?/0OnQX8lDVkdJ2q+JS33PduhsC/ArBXvA+MOv5RLbPBAO668Dbi5gDw+KlF+?=
 =?us-ascii?Q?DILl6mGHqxTrUAsupR2I1H2Gi32A/LWjCFpjkxXH/GxpVtr3E+HDGY8dh++I?=
 =?us-ascii?Q?Bs0CEtSXrYWncoJjyqLGxy69DtOOyZukSjak4LgE4s4mW9hlBv41Kx2w6JSp?=
 =?us-ascii?Q?gtYTfhzPLxbd1pfio6m1JniZhrUiyS6U5BXSpuXj8UozzQ6mbZLaSrZzHpJ1?=
 =?us-ascii?Q?VjGUVHvT/QMxXf6Jc9ZqbMVO6pWzp3JsASjwxtVU/McjABFyXD8u6f98CJGK?=
 =?us-ascii?Q?IhjiVZv09Z84HEsBu+RTGxubXehlk2ad7uI84pwIf/zpCeNACdM8EIr1xvl4?=
 =?us-ascii?Q?tyLUOTHxvtBV4l5kBuvQ3mP3dEKtwTSCESK49E6iwx2y0YONJoLXPtQOQ5NL?=
 =?us-ascii?Q?UjEGZhfZcXscvOGZHmTCDu9q0hc/aqDQwyXXPDQCIQPfblOeLCMMNTiFbyiv?=
 =?us-ascii?Q?icWP7cBESkoc2LObzdIjUyKGDOXz4VzZgCWbiczl9NWJviH19rZuiUa2EVU?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-7828-19-msonline-outlook-12d23.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 22a25839-37e3-4280-b4d9-08dd60226b7a
X-MS-Exchange-CrossTenant-AuthSource: DB7PR02MB3802.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 22:25:15.8611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB9091

Add ExpressCard parport cards.

Signed-off-by: Cameron Williams <cang1@live.co.uk>
---
 drivers/parport/parport_pc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/parport/parport_pc.c b/drivers/parport/parport_pc.c
index f33b5d1dd..787e894bb 100644
--- a/drivers/parport/parport_pc.c
+++ b/drivers/parport/parport_pc.c
@@ -2854,6 +2854,12 @@ static const struct pci_device_id parport_pc_pci_tbl[] = {
 	/* Brainboxes PX-475 */
 	{ PCI_VENDOR_ID_INTASHIELD, 0x401f,
 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, oxsemi_pcie_pport },
+	/* Brainboxes XC-157 */
+	{ PCI_VENDOR_ID_INTASHIELD, 0x4020,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, oxsemi_pcie_pport },
+	/* Brainboxes XC-475 */
+	{ PCI_VENDOR_ID_INTASHIELD, 0x4022,
+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, oxsemi_pcie_pport },
 	{ 0, } /* terminate list */
 };
 MODULE_DEVICE_TABLE(pci, parport_pc_pci_tbl);
-- 
2.48.1


