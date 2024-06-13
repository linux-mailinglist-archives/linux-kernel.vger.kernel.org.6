Return-Path: <linux-kernel+bounces-212874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B743590676E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 10:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14238B29835
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 08:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B14913D60C;
	Thu, 13 Jun 2024 08:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fs3YbGz6"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2079.outbound.protection.outlook.com [40.107.241.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F49F28F1;
	Thu, 13 Jun 2024 08:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718268485; cv=fail; b=EKwDJS3C/54s+DNDHjnwd1FIB8pX0ZHdRhIdP7c0ly57qIio2jtISg5z2FCvb099k99wjIhKeGKaDQJGLzELz6EjgZ4IE65AkJBq7rmT9ADWtRg5JdegeFypV5VW1nCI6/gWg5EjieYe/PJ+qTuxaRLVKwO+Nz4bmw47cLnuPa8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718268485; c=relaxed/simple;
	bh=9+bjxJxxuHZK1Q3iWdGNypFZXrUFepNf6yIApBRQRnE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QVi33swWzsDsCINKHU6ZiD6V4mWHloCfTM/atWrB4OVneU4/GJcnV0fYcsMeWrffk+hvg0jSRZaLRBlXNydDCg5pfpCtLS5O5zUL019jIn229SYGlgojBzwLQkISDGbGeCeeCOfuLczecxuskgElVhxK+udwiLWYVjnC9wOKEBw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=fs3YbGz6; arc=fail smtp.client-ip=40.107.241.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GH/K/gUQ+HVoU9mO6Sg67zjRG5mx/4FuSDWIjsqL5SURcCnzorWQwquIhy6BJl7DRYcnPwsyHyyCN9SRCIg/lVQxHOsUE5Sqpade9ZptX6hTQZHr6jIWyxBVagOYMES41eh2g7Z/rF0br2q2XbaCck5DSFCVNp23kS35m/fnntc1Vo1lfF1uvQWGxY45OlUIf4RBQhMlObSeWjhczQEE99J3d09mkGfWzmReZOsDiOFq4/ZchJazwM0WTdKtv4SYdAakAuhMxkQn9HqW+bUuFT9U1cjzd0IxA6F8ipRKrtsM0HeVy0Am1MTzz8r/dWsCwuVSSq5TK6LKa/fcUDCpoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9+bjxJxxuHZK1Q3iWdGNypFZXrUFepNf6yIApBRQRnE=;
 b=GLMNx+iMasLZEpiiVLtaKNpeUCYMFy+INy0pq6RdBP7pyvwj2D3FvGMbMC7mCEPMKd3X3aX9e+QfxqLvCuNU+yKyuVmhKH5qmcIbePf50BjwALPaRPmm3qKGCLL+ib6zsN9+P5BK3r3O8WP5PJhTt+2cE8Xo6c02g52jQlwda6y+nM0cLhqNI+/RmjGR9tNzw3rhBQNzdSbhSDaIVdB3PGUTAiux2Znb6KruedNRY6IBU+LpcRYPI27CtjV3LNl9NJ5brb0PsnZeBJu2PrC4o9b5PjbuLNbU3rRnibMa6U+KILZ5qA+HRdhBWnCYu7FV6nprk2cx3t4Q44UaLLvP4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9+bjxJxxuHZK1Q3iWdGNypFZXrUFepNf6yIApBRQRnE=;
 b=fs3YbGz6DGG1xArJwegaF4d3V0yVqfNxjCnOM4ikfnWbzGI34hQyWfla8x8Q+gXO3leztwOczy1b1mWcCr2az237FUGpS+d/dd0InY2a4JFQHyh24I2kwiG3dO/dv9YZvg+z9xTz1iBO7LIrn6OLixIeGJrzdDkHSD5XzHP2aFU=
Received: from DU0PR04MB9299.eurprd04.prod.outlook.com (2603:10a6:10:356::7)
 by PA2PR04MB10514.eurprd04.prod.outlook.com (2603:10a6:102:41e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Thu, 13 Jun
 2024 08:48:00 +0000
Received: from DU0PR04MB9299.eurprd04.prod.outlook.com
 ([fe80::9271:bc93:9fc9:d427]) by DU0PR04MB9299.eurprd04.prod.outlook.com
 ([fe80::9271:bc93:9fc9:d427%4]) with mapi id 15.20.7633.036; Thu, 13 Jun 2024
 08:48:00 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Vabhav Sharma
	<vabhav.sharma@nxp.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Franck Lenormand
	<franck.lenormand@nxp.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Varun Sethi <V.Sethi@nxp.com>,
	Silvano Di Ninno <silvano.dininno@nxp.com>, Pankaj Gupta
	<pankaj.gupta@nxp.com>, Frank Li <frank.li@nxp.com>, Daniel Baluta
	<daniel.baluta@nxp.com>
Subject: RE: [PATCH 1/4] dt-bindings: firmware: secvio: Add device tree
 bindings
Thread-Topic: [PATCH 1/4] dt-bindings: firmware: secvio: Add device tree
 bindings
Thread-Index: AQHavW5l3co4p5AGlkCtInU47ZH/Fg==
Date: Thu, 13 Jun 2024 08:48:00 +0000
Message-ID:
 <DU0PR04MB9299FB3B70920CF85CA2FB6B80C12@DU0PR04MB9299.eurprd04.prod.outlook.com>
References: <20240509-secvio-v1-0-90fbe2baeda2@nxp.com>
 <20240509-secvio-v1-1-90fbe2baeda2@nxp.com>
 <750f5388-20f9-45a3-a1e6-ceac4b91329f@kernel.org>
 <AS1PR04MB9358A2457AF05553457DE9B0F3FB2@AS1PR04MB9358.eurprd04.prod.outlook.com>
 <1486a1b6-4119-4121-b6df-3da21d06add7@kernel.org>
 <DU0PR04MB929983AB361DB081B44E7AFE80C02@DU0PR04MB9299.eurprd04.prod.outlook.com>
 <a752a912-a328-49c8-b887-fa95512785cb@kernel.org>
In-Reply-To: <a752a912-a328-49c8-b887-fa95512785cb@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9299:EE_|PA2PR04MB10514:EE_
x-ms-office365-filtering-correlation-id: c5261d7c-d710-4b9d-8bda-08dc8b85879a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230034|376008|1800799018|366010|7416008|921014|38070700012;
x-microsoft-antispam-message-info:
 =?utf-8?B?dVY1WmN4S3ROMU5jUkwraUNzc3ZLUy8wZE9kNnFQZVpPUU5OdXJxVFJZamRi?=
 =?utf-8?B?TitkWU5JaG1sQjVIUjNyOWpoREc1M3JZNWJvZzlhY0RtUkYzNkRCeGFUYjh2?=
 =?utf-8?B?NWp3YnlieldIVURQTHpmTkd1K0pIRDdtNTVObjc3WUc3OWlYT1JKdCsxTXg3?=
 =?utf-8?B?bzdJVXFndVYxQlA1OCtwZitMYXZoZGJ1dm1PYy92eFlET3NQYWZZc1FIRXRU?=
 =?utf-8?B?dVBxdGFra3JSRHBwYzJkNk9BZnNadWZqTUxyUHRSYTdVVHp6MXZoNTBuTk1B?=
 =?utf-8?B?OUlkUjRBbk9uOG95NjdmZ0haVDJwNHFQZ3hGcmNxVFZsMXVkSVFiNUpmSldv?=
 =?utf-8?B?YjRQL3pobE8ydzdzZllra0ZoVGZYblF2QzJGMGw2cVdDcTZhYlJ5V0M0elBL?=
 =?utf-8?B?UkEyN3BLUXJxaUVjNnpETlBPNU9aUXNFMEZuSit0bysxYzY5bm9vbDI3Yzky?=
 =?utf-8?B?cFMzQzY0ODlkTkZPL2EzL3JPWWhEbTRaRGNNb1VuU3QyUm9qd1VhQmhSNDBr?=
 =?utf-8?B?am5IYTdaTEZjQTBqdkl2L3E0eTRBUDFEMVJoMGtrMDVWSGlUMTJUY2hRQjlp?=
 =?utf-8?B?d3djUUt3NHJ3blRLV1lJMC9icTcvMHNKT3pZV2FVWERoWDZEUTFXV3dhRHJz?=
 =?utf-8?B?YUlrRU5wOEpFU1B6eUJhSmdLL29VVndaYVVoQ3MvbWptSUNMcnFPOHJUelIx?=
 =?utf-8?B?QXpvQlh4Y05vOWFqaVpPZWY0UUR6QXZ3bzBWVy9WMVcwYWRUUHh2TXBNWnZ2?=
 =?utf-8?B?aHZJajVGVzJOVG1IQ3VoZWtMMVNLbHlXUUpJSUhoMEU4QVVFRDRnVjRwSWlk?=
 =?utf-8?B?RGlIUXB5NlcxUklLSkJyVm9OSlBMVWtFaTFVYjV1a2YvRWtUbG1mZDdBY0ZJ?=
 =?utf-8?B?MDI4eU8yVWZISEFCT0doZWhmME1nVlA5MGMyend0SEdpM25kOU1NaEFMN2o2?=
 =?utf-8?B?eW5JVnp1dnNiSGhLdTFoek5ZUisxTUZlQmxOYk1aYXZiUFNDbXFiTUI5QkI5?=
 =?utf-8?B?NUs4dXRna1paZ3h4Q1RGUkk0M0N1NjY0dzhGQ2JLd0I2RURWNy9PeGpsUjcw?=
 =?utf-8?B?ajFTRUhzdVhTaEhXT1ludjFuWlphRnJkRHdLajdac1RNRGhZZVhjVVBqa1h6?=
 =?utf-8?B?eXorNmtvTmQ2NGxoMGVzRDZaS2RueHBGaGZLUWhlaFk2aG8yRmxKSlVpZVlI?=
 =?utf-8?B?SjAxRXNhbVQ1Z21XM3BFY0crUWVsaDNiTWRTWkMwb1hkRUw0ZG4zNytHbXgy?=
 =?utf-8?B?TXphb0dITkZNdDBza0xyMHYxd3VFNFplTFFmTThEZ21HVGlUREs0UXpZWTZK?=
 =?utf-8?B?TnJic2lJU04xRVZoSkRRNzJMMmo4Nmg2ZW95L0tqcmFCQnl3eDZENTlkSzNP?=
 =?utf-8?B?WUl3elpXY1FaQ1dJOHRPMGsyNHpjcGdyTGJqYWNDNEErL3lSaGIyY3pXS2hY?=
 =?utf-8?B?S0hGRG9ZWTJtU1pRbXhPcjczTlh2Mkd2ZkhwSENjNWY3b1pKN2NGcTZSNTJq?=
 =?utf-8?B?SUtJVy9zMkdVZTJKZVRQRFhuWDJvQzVzQ2pKcGdHUjVpOVVnU0NYbEprbFJR?=
 =?utf-8?B?Mjh2Mm5hcjZZcnJYSkFJRk9yS0NIYmJ4RGFXQ1VGalNpY0lKcmhobWV3VDZj?=
 =?utf-8?B?UVE4bDJiU3kzeWRIaFNlbDNVc1JBenA2c3pxU3k3OGhxZk4vNDhNZ3JkaHZt?=
 =?utf-8?B?NE5pMEx2c3pFTENXMXBYRnIrbnRYU0xKa2JxZllZYWt0K2s3UU41RlJQaHJy?=
 =?utf-8?B?VkNvUlE0K0xUNk1DQ1BGd2pGNXZlQ3pzcXRNOUpNUllrSkx2WnRoUEg5dFFJ?=
 =?utf-8?B?L2JSWGJZZU13MnBUNW1uQXFSbytURWpsSS9tT3BWeXpTYjhoank2UjZUd3JV?=
 =?utf-8?Q?9xpKhL7jQIASo?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9299.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230034)(376008)(1800799018)(366010)(7416008)(921014)(38070700012);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SDRHSkJEcS9PR0ZQWGY4a0w2c2dEYjE0MUJueC91bXdJSjR4dW11WEdDejdu?=
 =?utf-8?B?Z1dIN0U5ZkZkc1NMOGs3SHp6RVdWamdVNHJybm1oZDlpS2hPM3RxSDlPK1Vu?=
 =?utf-8?B?N2wwSm5veENEQVJ0MThoZXdtVCsyTG1TWHlzMzZ6b3d0OCtidGNOSU9sZjJa?=
 =?utf-8?B?VFJqWjNwQjNJQU45NkdmUWk1M2J3K1prVFZicGN1Tkw3TU1hYnNNK1haOUZU?=
 =?utf-8?B?NStMNFRHMm5kc0F1LytNS2lRUlpqNzU0L25IMXR3N3M2ZWlEVlZzQmVxRmxs?=
 =?utf-8?B?VTREbjJvVTB4azlSbHprb3E2K3B3WERkcUtvaWQxaWlZY3MzdXNFb0ZIeWxO?=
 =?utf-8?B?eW0rWEJOQ2NKcXdkMllicUIvRFY3YW9Rd0hKQW1jR21JV0lKNVBkQm1LY2tW?=
 =?utf-8?B?UlY5V3QrMFFFKytmeFN0VS9sSlJ1MlZmT2RIWUlFTmxPRnVHNGRpTm1UelF0?=
 =?utf-8?B?SmVvcHhCQUd2MmlySEllaXBreWkvTTF2SzZGUFA0RWhOMnJZdkQ3MlFWb0o3?=
 =?utf-8?B?RGoySEFoK3VXM3p2cWpZNUo0dGpGdGV1LzFvYW1WalVPUEwrTGdWVjMrbTVN?=
 =?utf-8?B?Q2hvUFRBRDMxTVpqNFVCWG5zRXR2dG4zckVSZ2hzaWh1SUhkdmNDYmJVQ0ho?=
 =?utf-8?B?OVN3UkVqRUlsU2JMbmVmMXJyK29oenRSNWQ5bDJ5ZVE2YmZRK0FSSnZybWxM?=
 =?utf-8?B?S0lsYW9jMnJ1ZStWbm5yaGR5aHp5amt3ekZCbVN4aG5WNkJvYUJBNVBTdkE2?=
 =?utf-8?B?T1BJc3ZVeXc0Tk1jeDZMM09QaUZWb1Z4Zy9UOUl1cTRQeGd2MHRMOHFsV0Rs?=
 =?utf-8?B?aHMyenhoNk9FOWFCK1BuTENHTnlIbk5FSkwvN3REdXp5VkZJQ21Fb3N5TFcw?=
 =?utf-8?B?dDFRb3pxclFJdWZmRTdJOXJkWHUzczFReVNpS3FRZEhWRXNUN3NaZnh5MVZr?=
 =?utf-8?B?czZpams0dEk0cWsxSG11aFpURU5DTE4xZjk1dHppNVc3Q1dTcit4QUtURWxp?=
 =?utf-8?B?RGlmYWRRSytwT2xoV3RqVGdQVitBb2hOLzRSaEpVM056ZXU4YXNXNktGMHpW?=
 =?utf-8?B?VlhiNGcxWGNENDlQZUhKaEczUGUxSjd0Snc4eVludzc3czZpTzZzMUVmNllC?=
 =?utf-8?B?RmlTZjNzbkVwTUZla3A3UkxaaTFvSTFLV1AvUDB1bktCVm5GZEIxMUhrbkh6?=
 =?utf-8?B?aitpMGZvZk5WN1VBRXcyQlpUK1RVb0U3cmJkc0tzYlJCcS85MTQ2dy9hN25F?=
 =?utf-8?B?TWhQRmRxMWp4WTluYkxMTVRnUklMV0dtbm1jRDNaSjJ2SDkwNk5COVM1dWRL?=
 =?utf-8?B?QWFsSTBLMWtrNmRYaDdoNHFiU2FkemhQT0oxNnhrTWNxY2tjSDQxWk9sRXVj?=
 =?utf-8?B?RitzT0tnR2pqVHppMG1VOUdMTUZVeGc4T1djWWtOQmhRQ0NETUcxaktjYU1q?=
 =?utf-8?B?MzN3ZVNRU2dMQW83a0VnNnR3VXY3cnVpM2VzYjNsVEVFcTA4b0JPUTFnOWZ1?=
 =?utf-8?B?N2hxcXZUOXZyKzFDZFMvcjFlTDNHZkpQNU9wR2ZPVW1DWUllQkF1YnlXZnJl?=
 =?utf-8?B?cHJiV1U3T3ZabWhNUlFBWGpZL3RTRCtUeDZ5c1B1L2gzM3NmRlVwZ0paRDBM?=
 =?utf-8?B?ZkdjVlk2aGl5ek1kNmJueHJZdlI4QmtZRWdLK2VaaTA5cDIzT251YmMwK2pH?=
 =?utf-8?B?TkNGaXkwNEVwTUVwVWN4REYyTjQ0dVlnNEZ2ajBVb0F6enJjUlVFNnFVSVQw?=
 =?utf-8?B?NE54YkZYMitLclFERW9CZnJLQ1FBdC8wMy9YK1VSV25lTW1tV2FXWWJBQzlO?=
 =?utf-8?B?cGROVGhrd3NZUGtlUmlTRlJwRnYzRVBzT3UrU3RSNjhNN1dBalNEdnI2L0N1?=
 =?utf-8?B?NnNzME40U3NqZ2xzN0FGN05rV2tvWVpsMDJnbzF1aFVzWjRRYWhVTlhrbTVK?=
 =?utf-8?B?YlMyaUE4eGRmWjRBb2RnSEdwaVBRWnhHY3dOT0ZNM20yMzVDK3gyZ0hXMW9V?=
 =?utf-8?B?Y294bGVCcWVVQ0kvaDdNZXNMSkpWVWNEMTlQQ3JnS1pqemhwaDhzOWJTMlJ6?=
 =?utf-8?B?K0tiTmJ4VU5KcDNRVGMyNjFWNmZuTDU0WXJKUUNhSDREZ3pldjhrQ01jRUZt?=
 =?utf-8?Q?h7gi7Dsw0ccXRfA1cAFEB/3lO?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9299.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5261d7c-d710-4b9d-8bda-08dc8b85879a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2024 08:48:00.1284
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jgtk17iNNQuENJh2iULuP4TpL50GIpzlMUwyGuT7H35tnImMDg0pkmC+rxv2DHhAb3OwtRtK+yGZFv/4TquuzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10514

SGkgS3J6eXN6dG9mLCANCg0KPiBGcm9tOiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnprQGtlcm5l
bC5vcmc+DQo+IFNlbnQ6IDIwMjTlubQ25pyIMTPml6UgMTQ6MTQNCj4gDQo+IE9uIDEyLzA2LzIw
MjQgMDk6MjAsIEFpc2hlbmcgRG9uZyB3cm90ZToNCj4gPiBIaSBLcnp5c3p0b2YNCj4gPg0KPiA+
PiBGcm9tOiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+DQo+ID4+IFNlbnQ6
IDIwMjTlubQ25pyIN+aXpSAxNTowOA0KPiA+Pg0KPiA+PiBPbiAwNy8wNi8yMDI0IDA2OjU4LCBW
YWJoYXYgU2hhcm1hIHdyb3RlOg0KPiA+Pj4+DQo+ID4+Pj4gTWlzc2luZyBTb0MgY29tcGF0aWJs
ZXMuDQo+ID4+PiBPaywgSSB3aWxsIHVzZSBmc2wsaW14OGR4bC1zYy1zZWN2aW8NCj4gPj4+Pg0K
PiA+Pj4+IFNvIG5vLCB0aGF0J3MganVzdCBhYnVzZSBvZiBEVCB0byBpbnN0YW50aWF0ZSBkcml2
ZXIuDQo+ID4+Pj4NCj4gPj4+PiBOQUsuIERyb3AgdGhlIGJpbmRpbmcuDQo+ID4+PiBJIHdpbGwg
ZGV0YWlsIHRoZSBkdCBiaW5kaW5nIHRvIGRlc2NyaWJlIHRoZSByZWFsIGhhcmR3YXJlDQo+ID4+
DQo+ID4+IFN0aWxsIGxvb2tzIGxpa2Ugd2F5IGp1c3QgdG8gaW5zdGFudGlhdGUgZHJpdmVyLiBX
aHkgaXQgY2Fubm90IGJlDQo+ID4+IHBhcnQgb2YgZXhpc3RpbmcgZmlybXdhcmUgU0NVIG5vZGU/
DQo+ID4+DQo+ID4NCj4gPiBUZWNobmljYWxseSB5ZXMuIEJ1dCBTQ1UgY2FzZSBpcyBhIGxpdHRs
ZSBiaXQgY29tcGxpY2F0ZWQgYXMgdGhlcmUncmUNCj4gPiBtYW55IGZ1bmN0aW9ucyBhbmQgYWxs
IG9mIHRoZW0gYXJlIGFscmVhZHkgYWRkZWQgYXMgc3ViIG5vZGVzIGluIFNDVQ0KPiA+IG5vZGUg
Zm9yIGNvbnNpc3RlbmN5IGFuZCBoYW5kbGluZyBwbGF0Zm9ybSBkaWZmZXJlbmNlLg0KPiA+DQo+
ID4gSSBndWVzcyBzb21lIG9mIHRoZW0sIGUuZy4gcnRjLCBjb3VsZCBiZSBwYXJ0IG9mIFNDVSBu
b2RlIChyZXVzZSkNCj4gPiB3aGlsZSBzb21lIGNvdWxkbid0LiBlLmcuIHBpbmN0cmwgRG8geW91
IHdhbnQgdXMgdG8gb25seSBtYWtlIHNlY3Zpbw0KPiA+IHJldXNlIGV4aXN0aW5nIFNDVSBub2Rl
Pw0KPiANCj4gWWVzDQo+IA0KDQpEaWdnaW5nIGEgYml0IG1vcmUgb24gdGhlIGltcGxlbWVudGF0
aW9uLiBJdCBzZWVtcyB0aGVyZSB3aWxsIGJlIGENCidwYXJlbnQgZGVwZW5kcyBvbiBjaGlsZCcg
aXNzdWUgd2hlbiByZXVzaW5nIHRoZSBwYXJlbnQgU0NVIG5vZGUgZm9yIHNlY3Zpby4NCkNvbnNp
ZGVyaW5nIHRoZSBkZWZlciBwcm9iZSBzdXBwb3J0IGFuZCBvY290b3AgY291bGQgYmUgbW9kdWxl
cywgSSdtIHN0aWxsIHRoaW5raW5nDQpJZiBhbnkgc29sdXRpb24uIERvIHlvdSBoYXZlIGEgZ29v
ZCBzdWdnZXN0aW9uPw0KDQplLmcuDQpzeXN0ZW0tY29udHJvbGxlciB7DQogICAgICAgIGNvbXBh
dGlibGUgPSAiZnNsLGlteC1zY3UiOw0KCQludm1lbSA9IDwmb2NvdHA+Ow0KICAgICAgICAuLi4N
Cg0KICAgICAgICBvY290cDogb2NvdHAgew0KICAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAi
ZnNsLGlteDhxeHAtc2N1LW9jb3RwIjsNCiAgICAgICAgICAgICAgICAjYWRkcmVzcy1jZWxscyA9
IDwxPjsNCiAgICAgICAgICAgICAgICAjc2l6ZS1jZWxscyA9IDwxPjsNCiAgICAgICAgICAgICAg
ICByZWFkLW9ubHk7DQogICAgICAgIH07DQoJCS4uLg0KfQ0KDQpzdGF0aWMgaW50IGlteF9zY3Vf
cHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCnsNCgkJLi4uDQogICAgICAgIHJl
dCA9IGlteF9zZWN2aW9fc2Nfc2V0dXAoZGV2KTsNCiAgICAgICAgaWYgKHJldCkNCiAgICAgICAg
ICAgICAgICBkZXZfd2FybihkZXYsICJmYWlsZWQgdG8gaW5pdGlhbGl6ZSBzZWN2aW86ICVkXG4i
LCByZXQpOw0KCQkuLi4NCiAgICAgICAgcmV0dXJuIGRldm1fb2ZfcGxhdGZvcm1fcG9wdWxhdGUo
ZGV2KTsNCn0NCg0KUmVnYXJkcw0KQWlzaGVuZw0KDQo+ID4gVGhpcyBtaWdodCBsb29rIGEgYml0
IHN0cmFuZ2UgdG8gdGhlIGV4aXN0aW5nIHN1YiBub2Rlcy4NCj4gDQo+IE5vdGhpbmcgc3RyYW5n
ZS91bnVzdWFsIHRvIG1lLg0KPiANCj4gPg0KPiA+IEJUVywgZXZlbiB3ZSBjYW4gcmV1c2UgU0NV
IG5vZGUgZm9yIHNlY3ZpbyBmdW5jdGlvbiwgd2Ugc3RpbGwgbmVlZA0KPiA+IHVwZGF0ZSBiaW5k
aW5nIGRvYyB0byBhZGQgZXh0cmEgcHJvcGVydHkgJ252bWVtJyBmb3Igc2VjdmlvLg0KPiANCj4g
U3VyZS4NCj4gDQo+IA0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg0K

