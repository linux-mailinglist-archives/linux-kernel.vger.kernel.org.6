Return-Path: <linux-kernel+bounces-199195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 105E18D83A6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 15:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33D911C232CF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 13:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDCC812DD9D;
	Mon,  3 Jun 2024 13:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b="T6ZYYCvG"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2123.outbound.protection.outlook.com [40.107.21.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A546A12CD91;
	Mon,  3 Jun 2024 13:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717420406; cv=fail; b=F8wRcFL1UkRQi/gbUZOnGxWE6jLPe9vXUpKUPfBwe7ZxqqyaIomiaYyJLcp2phyKyqg3FDsQQ6xP1uFsvtSz6VHqqOPFI2VdLNE9BDqwgElNfeFKMyTOy3XQ6oK7rAgvqRcgjuY0z6YceGqovVvboD7U65T8Rt5OeIIuu7qpeR8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717420406; c=relaxed/simple;
	bh=6wc4D+AYyJCfpfCMudtNcBWwKmuFCHGV1pb3P+xnQH4=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version:
	 References; b=slaMz4IxYf3V5aCubKJY5jQjIL7l9cEGVChFzyxxlMihGI8ZCI70d1GlZNmqLFy7i4enZ9oZY8JsneQhJ9XPP9A6Wxg3Ai1qaTiTxEMt2TZgzfQoym+qyuRrjOXPlI9zes/PoULNinvoRmVqttScNGfghNLWh+bYlpWkc1PMLhY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl; spf=pass smtp.mailfrom=topic.nl; dkim=pass (2048-bit key) header.d=topic.nl header.i=@topic.nl header.b=T6ZYYCvG; arc=fail smtp.client-ip=40.107.21.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=topic.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=topic.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ffTVXmHhRsDEbytjYSIveFTEeISHxh+ZSPISSvmCbGhsGZdvzVLMApk8uWj2Tejny+QcNZ4j2ZK/6/EBy2DNQ/pXowDSdLzgRccKf5jNoMMKX14k8WxnD/HbJGxb1w9P++OOSExzveByNekV4UkTw4eUx0J25AR+e5EXjWZgkxjcttIiW3w4gJs9puuIyzkTOuDTHUtesqTdWprR/rQ3glPvrlu29kbC//llxsNp7fbEA9hLCAnk2JbSYEnxqmPizoFhIlSiqnTJqY0ZLR/L32570Sz5UDMuIyqoMig159uznzZzyPz52Qtfenhgv38ZU0zSkzXEk66Cj/Wr7ikHRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gtdp2ZAXSM5r0CL9MWQWysyXPkttpo1nT4lYWbQTGoE=;
 b=ekfBWqNrRBf4uoKH5Gzn12iBUEZUC8MFxV1cB7TYaEPutzLURH5eVlSCEifjx7IF4v7M64LzGGfFq4bxdVFmsSiO3X1sxodFmWplOqMLOITYUgupIa1YvMP/r1sJkyREZjMQWnmJDOVLfXxfnlPeNjCFDseiOqeK6nczsfWC/WkR49CKAxKAsObkWwqXVqlZxvQct5+a2hS+u01Gmjry5vyr3Pp1IUKqw45xBBCWm15RPMt1NWLj2IGpi7V5F2rhOSVcQhV7EAhmaNkv50pzMztcUGwSMsk8oEpu8KC63guTHTBGkZiRdaxDpfoYXVXgIgHog55/8FHoOGZdevga/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 13.93.42.39) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=topic.nl;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=topic.nl;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=topic.nl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gtdp2ZAXSM5r0CL9MWQWysyXPkttpo1nT4lYWbQTGoE=;
 b=T6ZYYCvG4sJV0GOVuNFGPAjZRYg5NTI6xzn82iduCXPhc3JuCpEOQkm/MdfJF37hbEWUieBMjBGUuxRvT0se00eB4/fdtbnHfyFwaY+6FUb/LP98eRkg6Yrm7CxY6M1itv2WqzRW+tbsbhTsj3jDXJcCudDr/jQjf4WEe8t7SHzwqfShobHjP5/j0RTBzRv/YPxfiEZUUoyAJCYANRusyCR3H5rsTk8brZvtZ1C7ilITU4hSOUmWoQaWp+DI3jooho94c5cM1fZhaS293/VS6Z+wAeICeI1l/GQw0ObdWdQRYxBcKqvCUGQTwM4hOKXjiCKziWIq1s7EuqRQZFq64g==
Received: from DU2P251CA0019.EURP251.PROD.OUTLOOK.COM (2603:10a6:10:230::26)
 by PAXPR04MB9091.eurprd04.prod.outlook.com (2603:10a6:102:229::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Mon, 3 Jun
 2024 13:13:16 +0000
Received: from DB3PEPF0000885C.eurprd02.prod.outlook.com
 (2603:10a6:10:230:cafe::5a) by DU2P251CA0019.outlook.office365.com
 (2603:10a6:10:230::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.28 via Frontend
 Transport; Mon, 3 Jun 2024 13:13:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 13.93.42.39)
 smtp.mailfrom=topic.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topic.nl designates
 13.93.42.39 as permitted sender) receiver=protection.outlook.com;
 client-ip=13.93.42.39; helo=westeu12-emailsignatures-cloud.codetwo.com; pr=C
Received: from westeu12-emailsignatures-cloud.codetwo.com (13.93.42.39) by
 DB3PEPF0000885C.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.15 via Frontend Transport; Mon, 3 Jun 2024 13:13:15 +0000
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (104.47.13.40) by westeu12-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Mon, 03 Jun 2024 13:13:14 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=topic.nl;
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com (2603:10a6:20b:42b::12)
 by DBBPR04MB7929.eurprd04.prod.outlook.com (2603:10a6:10:1ec::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.23; Mon, 3 Jun
 2024 13:13:10 +0000
Received: from AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a]) by AS8PR04MB8644.eurprd04.prod.outlook.com
 ([fe80::e86d:f110:534e:480a%5]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 13:13:10 +0000
From: Mike Looijmans <mike.looijmans@topic.nl>
To: linux-usb@vger.kernel.org
CC: Mike Looijmans <mike.looijmans@topic.nl>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] usb: dwc3: gadget: Inform system of suspended state
Date: Mon, 3 Jun 2024 15:13:04 +0200
Message-ID: <20240603131304.233403-1-mike.looijmans@topic.nl>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AM0PR03CA0101.eurprd03.prod.outlook.com
 (2603:10a6:208:69::42) To AS8PR04MB8644.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AS8PR04MB8644:EE_|DBBPR04MB7929:EE_|DB3PEPF0000885C:EE_|PAXPR04MB9091:EE_
X-MS-Office365-Filtering-Correlation-Id: faacfcce-b147-4a05-a53e-08dc83ceedad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230031|1800799015|366007|52116005|376005|38350700005;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?R24Miv8hDYuzJVIsetTrBo10R1XKUpIVcZyNSuMepDG8bdiWnxMu6TkyfWO9?=
 =?us-ascii?Q?hE1mSfCbiCpftqgqh2GujGySqOu8FZUETFXPcTsNs+LuV1Uihj6XuBDxGjym?=
 =?us-ascii?Q?RSB/unRvh2VbtxOJwVcmUISM1Gf+oQZaRuILWWJw+4iNbaHEXo7Y/rxs9f2+?=
 =?us-ascii?Q?JuOOfEFFheKd6/j1VSG/rFZvPknSmzVTlhxyPMva6eGykA6p2dYKSF3OclQv?=
 =?us-ascii?Q?NKq00SdiNTcmJyTgni8101VoWamNmgwLciD/IDRCcpvU8YDehg6h4H5MGu8M?=
 =?us-ascii?Q?8wzpl+ra0PmIIpgo4dQxqbv8AUFE2UEoVmwzDOWXDJW5X1ql2cM+SRSZQGY8?=
 =?us-ascii?Q?hAq1pcWkEOCN20/wjA7/KauysDeOqC6QAA84xSKvw3Axp7ig3CXSb2OA7OmT?=
 =?us-ascii?Q?Z92W6cY3wIo/2OvZ0A8BoOa/MqzoqlUg1NJm4vVR1NTEsWYBKXoFwzGMfNFQ?=
 =?us-ascii?Q?TG/6exJK+PyxaT3YUe8OyA1uebZfc1Icdk2dXZlgHzACGPdVzaGhvPSeEdD7?=
 =?us-ascii?Q?uCo9WNqZsbnAYw8ip6GoGkWx/NzNINXrNBKuXFZdjret2SGl00BY9BYhvSKm?=
 =?us-ascii?Q?kOb0JB0u5PFN5G4wBDLGZaoWKUEymZrsWgwfOkyY+Iifgc425wDCfRlBX90r?=
 =?us-ascii?Q?BCHhRfYkUL07Hq4WemX7YORnAe19l/cIqe3xbp7FF44FVstKDcnxNXo6tYzR?=
 =?us-ascii?Q?TzX0WHF+n9bCcN4BTPnwvFrU5X7LVa1Ii5CriY8qHZamouA+mLKft7QIjN6Y?=
 =?us-ascii?Q?2shBw5eTp8xnvZ5JzNGlL0OZA+/Lqd+X66gV39I3LIdepLpP8GeFKPkwc+y+?=
 =?us-ascii?Q?cNHcF+LMvKd/dQTMSP9gUOFU+BlvonBdm3Y30w3fotFJzx5HclNBjjljKNXm?=
 =?us-ascii?Q?sX5pbbWGwV084w3YH683+2QJJYLQ5oDejdC7Bdg7SR7ZlxECVUmRfnl6QSsh?=
 =?us-ascii?Q?alGBoX7UFa2gCfoFUNpifxs1DYx4e6XKqISDRvlrUrixYpQ0Ar8fgh+gjpCb?=
 =?us-ascii?Q?V3xKUqDEkZf1cJWVdN4MAjcgw9NlJ7FNNoqRXnWb3jAnUGaVDcQMbFNi25ty?=
 =?us-ascii?Q?R6+v5kauhD/n3SwJcsEWvV2l9io6AtCQr4Kjb4QgHgu2niCQ/GHpNdGI1Uss?=
 =?us-ascii?Q?KlOvrYrjvM5Z7cpocjgrZj1IGT/fc9zjw7g97FOk4M94ryiAfQ6Et/J15Sns?=
 =?us-ascii?Q?FEnlKZsFvJb/61AqAFLfbpGtvEfedX8RWuW9Sas9gBv3dShydkd7F2aidDPn?=
 =?us-ascii?Q?UBMFggn97URHdfNpVrb7oklW9L95N03Iw33pHpSiHLf5v0D4N0fk41f5QUTt?=
 =?us-ascii?Q?gJ+8WSruFSXuqoak5mhjhsauWocNIJwBsDNo5nlce/dUBg=3D=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8644.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(52116005)(376005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7929
X-CodeTwo-MessageID: 12ebd205-b4a2-4b8c-bc9c-a3e90792ead2.20240603131314@westeu12-emailsignatures-cloud.codetwo.com
References:
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.c5f44c79-75b2-43c1-a791-806fe8b693cd@emailsignatures365.codetwo.com>
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB3PEPF0000885C.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	3b6bf983-709d-490e-fe52-08dc83ceeac3
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|36860700004|1800799015|82310400017|35042699013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?raoQRY2ZEe/cZ5AYotKnhFooOvLL1BS8kD+fApGyHr0duivoWGRyCRPuUhTH?=
 =?us-ascii?Q?zLgIIX4M9EUfVc9YPTKLBUSXm4xcQoMqs0/tebTBg/1G6+t8drFlmscJs1KO?=
 =?us-ascii?Q?35/VHeI8YH/eqs4lJlq9fa/q/8TlrJYONundkIhdG/6ol57K0ERhE5tMw8Oz?=
 =?us-ascii?Q?YMdj25/hM8RiUldJfPpyChlF9/N9nlPYlWA0jkE6D7UgVssCWzjcdMcTDVn1?=
 =?us-ascii?Q?Xb6sKAF6sfh9PI94vPpjZh4qrRIOkPvdBEQPo9T93bbe16iqsemv+uh8coce?=
 =?us-ascii?Q?7F0ZziyLNJywRCWoPKTNVTV/MMVtVk8LVh2Ej8HYyOMSrhbNs1umfy4UpBpi?=
 =?us-ascii?Q?yJFc1szSCRRNJfr9dmSgT++jSbwrPQEc083dKMfwIANPoEQ9GrKNZNkbgFQn?=
 =?us-ascii?Q?GiZ9EHwLF5Sgkaj3Ytg4WxZ9pBquScMLU9CI4XBsYhDldvHuFkFiESDmeOyx?=
 =?us-ascii?Q?9qKL6Kd4ugOfIFGkGNocU6crLI/TIQOD+eYGYi0zvep6DWJ/OJ0Agp++wABu?=
 =?us-ascii?Q?9bee6tieKtLVf9AqJSDgaLwBjAN/Rf6K1kwKhbQU3FK9AAOLgQ634ewTaMbl?=
 =?us-ascii?Q?JYTzhZtu/qyHjVt7JE85iO5q2kilUojXjSYycfJ6USd8M9FExFlffJHzoNW1?=
 =?us-ascii?Q?N9c1FwPe43kfIXXr0w9VegvqBuhTjUVa6QimV7u9wW1B0zhsnNHjQeYSk4m/?=
 =?us-ascii?Q?uxdT79NcJnkSHweo0PrmZwjD5Zsr+5as3J4K1X9pHViBvfQb9P5r8d9X+eax?=
 =?us-ascii?Q?cjDKHkSzJFOH2D5LtV0BXj7Bjb0K2wVFQjL99SUDbMPOzumVBLk08NL0rqiP?=
 =?us-ascii?Q?uMXXgYfq7UQbt55GHUXs2uBe5IqldahhhJPa5JUg2i7+pLJIKHMijCgeOIqt?=
 =?us-ascii?Q?CIEi+GrqOCzkDDOpHZQJZcUn1DgR7XnFJMaobzFQuAifJHUEgd6YohwX93EW?=
 =?us-ascii?Q?qa60ah6rX3zZpdE1/5sqv039xm5fOiqdUk6GxfwRlcmKXV3LaUPoa0WIbf46?=
 =?us-ascii?Q?N6U3kNwK34TtshUV6AKMXT0y3u0fB2x0zB2fNrhsVjaqY3WwbDBM8OpFtRZn?=
 =?us-ascii?Q?Yci5RYBURvuCyDf15Ou+UKEc7FMOfga1S8pbHn/WpyqASxbKkGGzhjYm6KZz?=
 =?us-ascii?Q?opTeT6Qx8MLc7rE+YCCymfZV71R78t5qkyyr/i/xGK9rFJXK7ymMeStkF6rH?=
 =?us-ascii?Q?u0106RNcYKVtUUoEsp2pPf4lMHXCCOf0nbsSugRMu9E5ZpoUPuSBS0Uhqx1B?=
 =?us-ascii?Q?zK4NTEd0ac6+pk8+wXq2mLJPKDKbafksylvyFmESsHuE5pki1Q8rCb8Ia2YD?=
 =?us-ascii?Q?cMPy5VBHX+wpvrkn/BvNraqJ?=
X-Forefront-Antispam-Report:
	CIP:13.93.42.39;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu12-emailsignatures-cloud.codetwo.com;PTR:westeu12-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230031)(376005)(36860700004)(1800799015)(82310400017)(35042699013);DIR:OUT;SFP:1102;
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 13:13:15.2287
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: faacfcce-b147-4a05-a53e-08dc83ceedad
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[13.93.42.39];Helo=[westeu12-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB3PEPF0000885C.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9091

When disconnecting the USB cable on an LS1028 device, nothing happens
in userspace, which keeps thinking everything is still up and running.
Turns out that the DWC3 controller only sends DWC3_DEVICE_EVENT_SUSPEND
in that case, and not a DWC3_DEVICE_EVENT_DISCONNECT as one would
expect. As a result, sysfs attribute "state" remains "configured"
until something resets it.

Forward the "suspended" state to sysfs, so that the "state" at least
changes into "suspended" when one removes the cable, and hence also
matches the gadget's state when really suspended.

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
---

 drivers/usb/dwc3/gadget.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 4df2661f6675..99e8ea9db600 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -4343,6 +4343,7 @@ static void dwc3_gadget_suspend_interrupt(struct dwc3=
 *dwc,
 	if (!dwc->suspended && next =3D=3D DWC3_LINK_STATE_U3) {
 		dwc->suspended =3D true;
 		dwc3_suspend_gadget(dwc);
+		usb_gadget_set_state(dwc->gadget, USB_STATE_SUSPENDED);
 	}
=20
 	dwc->link_state =3D next;
--=20
2.34.1


Met vriendelijke groet / kind regards,=0A=
=0A=
Mike Looijmans=0A=
System Expert=0A=
=0A=
=0A=
TOPIC Embedded Products B.V.=0A=
Materiaalweg 4, 5681 RJ Best=0A=
The Netherlands=0A=
=0A=
T: +31 (0) 499 33 69 69=0A=
E: mike.looijmans@topic.nl=0A=
W: www.topic.nl=0A=
=0A=
Please consider the environment before printing this e-mail=0A=

