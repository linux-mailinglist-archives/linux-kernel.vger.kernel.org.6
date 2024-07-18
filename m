Return-Path: <linux-kernel+bounces-256130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A2393497A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 10:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35FD1B21BA8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 08:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8BC78685;
	Thu, 18 Jul 2024 08:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="B6iSIlbx"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011059.outbound.protection.outlook.com [52.101.65.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD377AD5A;
	Thu, 18 Jul 2024 08:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721289650; cv=fail; b=TQnmSh2zPskotLChai7hKHY/Z44PwyapqLrNchNi7DNgPQ5rSS3yTsdUpEifp+mWoPY69zt16AfroIskw5bHpItUsKaPTHTn66C+7a7LYNYXdEQvLzNnf1WiZZwEl5fQ7D3b9VxzN9eZD6VZRbtvpq9mv+8oapqLXflMYP61J5U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721289650; c=relaxed/simple;
	bh=5cUti7Ybtnguk4fdBvPtKTANipgVmuo2RRKtjFv4uFg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oT5TYKXcgNHvAoPy2FBPF0XcJXM8IJzi55fIQf4hJ9Fz1lIemAYcEmoU+VIgqdxusHFAx7SN0zNGN4G1i09Wf1zThexU0OYway0hbttUWcrUGxI9Jk2XhaQdA/r4DBoPOs4UW4CLbPfZis5o+aZe7wEiEtt0CV7GLlUKMraiG2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=B6iSIlbx; arc=fail smtp.client-ip=52.101.65.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p7drcGYuanXzmnrBwrAiyEdOxYFJaTug2uF0iKca+KMe2MNEcV1HUnXaTMqBuHpU2byeKvEnIj8EzUx+2ZB3SQ/Qh7C9653XQI1muObX1TNw6a5FmJOLKP1oGrvk//kQXjWYrq+GamrQFZEE7/GhyujjeYiLZsQxAqmvsSttweS9nLO8w7L8e4WoEfFagzfi6WodN4SS3yZPRJmVysGhnkmbNKI7Tz/EOaSjxaMotennHTNtPe7PM9goz0AoMwIEl9wbxn/0icR+iRO8t/g6I/vtY20yGmAtxewG+2fRtJR2LQ7Na6hC0tv+yfs5tif+5pNyQYhdcXaId5mzaMgfcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5cUti7Ybtnguk4fdBvPtKTANipgVmuo2RRKtjFv4uFg=;
 b=Luoc9YAHo5ResgTzFXblOPW073yST5enH6RgXk6SUpPfo0c1Y+0d+Bz9YuA0OxZR1ATZ3k7QPYJmHA3U13IX6PVzCRMoed5u17DM46ZD525GZ/HykPnwNusy9neD/Y+frXrR/ueNGUrF5vvpNG+Hud6LqlF124xZvpnoR83n5eokhVlqujBr3zs8uOIecOZ4IcsOVHJbNAIuZEE8h5h+S/wEBGNUBdvGxbzkZq9PwaxBiY188YDoqUWGwlAaSUO2rpULnn+0pWavkADjuLoZN6mwClqdSVe2PalFY3WNlFZbGftqQGvbmlIK3v50ku77W+Tw+rcLYrpor+Zwn0PiQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5cUti7Ybtnguk4fdBvPtKTANipgVmuo2RRKtjFv4uFg=;
 b=B6iSIlbxHq6bDDsmYjI6sATkPOHI5tWcPgAlYdZLNWI0sLejmY/El/FC8FkB5wHA6G11ajEhIM/d/w28q5wqN24qMF0SGrdO6gCHBg+8aKTRyS8CHUni55zYGZmSlnIc+re1vphimRKG80Lx5R2dqABNG6L3IzLbS5MohEIIVVI=
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by GV1PR04MB10582.eurprd04.prod.outlook.com (2603:10a6:150:211::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.19; Thu, 18 Jul
 2024 08:00:45 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.7762.032; Thu, 18 Jul 2024
 08:00:45 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Peng Fan <peng.fan@nxp.com>, "mturquette@baylibre.com"
	<mturquette@baylibre.com>, "sboyd@kernel.org" <sboyd@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, "abelvesa@kernel.org" <abelvesa@kernel.org>
CC: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 3/4] clk: imx95: enable the clock of NETCMIX block
 control
Thread-Topic: [PATCH v2 3/4] clk: imx95: enable the clock of NETCMIX block
 control
Thread-Index: AQHa0qccUHYbSPgnXE+KR8P79k6GH7H8JMiAgAAFP9A=
Date: Thu, 18 Jul 2024 08:00:45 +0000
Message-ID:
 <PAXPR04MB8510A3CD9DF92D2FEF8E003E88AC2@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20240710084345.2016687-1-wei.fang@nxp.com>
 <20240710084345.2016687-4-wei.fang@nxp.com>
 <PAXPR04MB845905EAE0154106199AB81088AC2@PAXPR04MB8459.eurprd04.prod.outlook.com>
In-Reply-To:
 <PAXPR04MB845905EAE0154106199AB81088AC2@PAXPR04MB8459.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|GV1PR04MB10582:EE_
x-ms-office365-filtering-correlation-id: 609af3c9-cb3e-440a-c783-08dca6ffba7e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?UGg0VDIwS1pncWVLUitKYWNVYlZlSndzbytVRU1jUTFORkt4ZDNjUXJMOGdY?=
 =?gb2312?B?U2xERFBaUFN5VER0UFZ3aURtbEFFQURSWkI1VzNIWUdJMVRxWlN1Qkw5Z0Nn?=
 =?gb2312?B?NWk4dTRUYWFPTUZaOGh6dDlSZDBBWXFJTjJ5dVRkd25RNWdETjFOTlN0S2NF?=
 =?gb2312?B?MG5aUjl3OHJlT3NZcVVsN25tM3lINW4weVdQZ3lQbUE5UXNwR2IwY2svQ0NS?=
 =?gb2312?B?QWxuZ3dsMkxiemoxaTFkb09PZGJoTDROcVhIYmVNd2UvVXYvVDgrM1VUY1lI?=
 =?gb2312?B?UjU5blZNTW5jVmhHMzVHU243S2JKaVlUK3BQbUxXY1N4Nlo0dE1WM1hENWlN?=
 =?gb2312?B?b0JxMlFzR3U1bEwvcVNUOU5NYzMxK09qNUhIUFhTNURmN3pFT1hKdkc4a1Jj?=
 =?gb2312?B?ejdDUm04cjVONCtSZlZLOERqVkdzRGV4bTZGQ0E0a0wxbTByN2o1blJySVNv?=
 =?gb2312?B?S2VldmlLOGRDaU14N3phRDBlR2NwVFZ3bWdEU3dYZklOOFR3d2Rnenp3SnBM?=
 =?gb2312?B?aDhvUS9VZzBFSG9sSmh6Y2xxY01KdVpwQS9Eek51bVFoMXpNRXZCME5BY3c5?=
 =?gb2312?B?eFI2MndYSUFPYkhrcTFSQkVsTnA1bGxnZWRMYml2RGNhREErbHZ5MWlwZ2Fh?=
 =?gb2312?B?eW1Xd25SOUU0VkJoNnVhRDdQcEtZUU9ZdGRHakxGWHcwMFJPTjMxd0Y1cW1U?=
 =?gb2312?B?SVJBYjdML2JGaHpNZ2dONkhCSytrcCtIdXIwb3U0M1dBODdYbG5hdSt3cDdh?=
 =?gb2312?B?b2pCNzUyQ2JSQWVVMURFZURLbGg1eGpkUW1YUUVqZUhBZHhVYW9ET285VEx6?=
 =?gb2312?B?TnA0SmNsRFpvdHkrVW9xNlpnTDMwM2hyTWlNTzZJeVgrclVndHVhOTg1WGZP?=
 =?gb2312?B?NEFMN3B2Y2l4VW9pYWJnbnZQbFNBWU9QRGlDWml6NCtuYjhpaGlXQXlMc3lB?=
 =?gb2312?B?RnhFZmtPaUVQelpYQ0hqVnZLcDBuN01oNnBJU1hwRldFRFQ1TGR1T3ZCc1NV?=
 =?gb2312?B?bDdqaFhFSVVWaUNMd1NKWFg4ZHFwOXhYb0lJSVlEMFQyZEFheUpzdlZLa2VU?=
 =?gb2312?B?YllxZDR2OWtuL2VnQzV3dUptVUdDaTg5TzBUVjlpSGtFWCtNMDFzdXM1SnI5?=
 =?gb2312?B?N3FUT0RFUmxjRWptdUxwOTVWRW5rRUR0YXR1WGtXMGk2RURIejVCQnI4QzZo?=
 =?gb2312?B?Q0htbndzVXVYbUJWK2xUUlo2TzVONURrYWRXYmxTMEcvdXkwckhrQktNMFlw?=
 =?gb2312?B?VU1jR3JyYVMzcUxSa0RGK2JENHlsTGt0SkUrZmk1SCs2dmtEZjNwb1RKR21X?=
 =?gb2312?B?V2doaFE4OWdLM3pQMFljNHJXMHdDRDJFVjU1ODhiZnVoQ3ZMS2Nta0drNHE3?=
 =?gb2312?B?Zldia1UxYnhHeW5RcXNYU3A5M1VPZmE3Y3I0dVArODhDd1gvRjBPVHI4VTNB?=
 =?gb2312?B?UUpZSytBTVFjSUhGRHdSRnBlcUxWQzN2SERhZktKY3RCWERTQVk0bVQ3bTN1?=
 =?gb2312?B?UUtKbnNRbHRuREtsUlNSK2Q0R1VaQ1o3NHg0MFJ1NE04WHBYUzE2djQ5dWxV?=
 =?gb2312?B?SmlRdUtjSWRxNUdGZ0drQ084UTU4K0JKWlFkMWpwYnBmSjJlbGk2cXR5Umts?=
 =?gb2312?B?UzIyNkZoUEt3ZVNicXdQSVVMY1hBZVYrZzBtOENvM2FOb1hRM1puUExsTzlz?=
 =?gb2312?B?M2VoRkRSVndZbTVHZmJHSXNtMFBRdU9XUWVlNVNscnBqQzNDbXgvK1BWbTFW?=
 =?gb2312?B?WTlva1F3Nm1nSnkyRjBIajYvaTBhSndXM1JkclY3UWJpWlBpUGNScnE2WGZZ?=
 =?gb2312?B?T2lub1VyUllrNDJGTUwyb3YxWHpOQzBnamdFRGxocFprUHZ1T1JkbTlDZkJQ?=
 =?gb2312?B?NnA0ekFYdVpGeUhkT3lFNjhrcWRkMzkranoxNllmbWRtdmc9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?ejlNQUJRRmc1bHBWd2hITmI5RU5ZMFpJbStaVXdPbFpOMjA2eENzWDVyVXFK?=
 =?gb2312?B?Vm95QjFoTWZpRmpnYnBhYlRobEpRMUVaTXNnR3hGbUd6STZ1c3VhbndjVU9t?=
 =?gb2312?B?ckh0Wk1iTUl3bjB3Y2p6M2c0MktORmFRYXVNYlN2WFJtenpKR1A3Q1Vqb3VU?=
 =?gb2312?B?ZmZ4TGgxK2ZlTmlWakxYRXc0UDEyWEh3YW0xOFZoeFVUcHEwSkpWRjVBam9U?=
 =?gb2312?B?UnlZQzdPVS9yVFF6ZE5PaUJadWdwUXdTd2JsTVRxUkNHVUxNRkd3L0hmSVZu?=
 =?gb2312?B?bEFGZzFLbHVyRURXQnB1dmxwc3VOQTlrRGdjeXpKSjU2SW5nRjNkWU1EYVUx?=
 =?gb2312?B?OE1aUWVvbGR0cEtrMnZidzNVSWc5MW1pSG1uQmdlMUgrbHorRzl5UHRIUU5Y?=
 =?gb2312?B?Qk9pK1QxWGdWSXBFZzlRV0tUYXZpR3k1c2hDSlREamJ0STZHNG9WbzNZdFZS?=
 =?gb2312?B?aFd2UmxTZTZxS2daM2cxMmtSeHVuNVRsNXg0OTNtSG9yR3BkVmdqdXdKbFlt?=
 =?gb2312?B?UHhCOEwvcmtJT2ZzbUtjTFRpd3dJZWQxaFNHU1MxQjV6bWpib2w2T2pzdDhX?=
 =?gb2312?B?OXRlb1A3WXdNU3p0bytPY3N3L0NkM2gyMnBKZGtyNGlFNW5IYUx2R3hrUElN?=
 =?gb2312?B?ekVsRmdGNCsxU1kwN0QxaVRBMWdFL09XOThCV0JCQkVDaFBEVkgvdmJSSTY0?=
 =?gb2312?B?WFhSTlBOQVo4aVlnV0txdjFFMjhweS96QXZpVlpNVGd0QVZvZ3o1bzhEczg5?=
 =?gb2312?B?R21raDZiVnVKMWJGK3FtOVhzWlZlUVF5eU5xU0kzWW80b2hHTWE1dUJ2d2Np?=
 =?gb2312?B?RnAvSFlYZll3a2djVzd1QlE3OEdPOUw4OHNYWE9pWHZnczF0VTFUZmxBenBV?=
 =?gb2312?B?Y3hYZFZBdFMzaUpJMlN6VVNtQzUybmNBWHpPODJ4WG0vZUQ0YlRZclp5Z1gz?=
 =?gb2312?B?eGoyakYxazZYcW96YTVqcmlpcnpuQnNnQkV3VmNpclBZVXBWeTNTS2RCeGdC?=
 =?gb2312?B?UkxPdUNiR3dLdS9TeVpMejlreEFZNVZRcnM0czZQWHJIeWw4MzN2VjZScldh?=
 =?gb2312?B?bUpNVGY5dHN5NnVmcXpvRWxWb01sSlpyaEorK1dyaHZzZmEzQms4NjM3ZnVI?=
 =?gb2312?B?MTNUbGNjaWVsNjZUR0JWQlZDRGhZWlBsU21DeTU5UndqQmJldjExRTFYYjZ1?=
 =?gb2312?B?MFhRNVRjQUpIYkZHMldJaXlZeFJkV3NwL0pWRUdENjVzMlNjZm1mYk1MZXQx?=
 =?gb2312?B?UHd2MkpjdUFOa2ZpZHJGM2tBbmZsYitHNGRYYXZ6bzZVNExnRlVJeVQ2VkVZ?=
 =?gb2312?B?ajJFL2NlbnZvY29ZQ21FMHdjVkJKckdmTDNZTk85MFdDNmo0bWhJSzBqNWUx?=
 =?gb2312?B?WGlMVUpuRFFXeVVtRURadmdmd1hzcUZYOHROMEF6L1Q5R2dqR2pTbnpDTzhi?=
 =?gb2312?B?UjZnVHRCV3U4T2JvbFhZRkpINTZVVjRxb0tydDNHdnhhd2llRFNpa0NCYW1X?=
 =?gb2312?B?YzFTckpjMUMrZW9hR09SYWFhL3V4S3VjZXJMek5McXl5dXdNSEpmVXEyQTBS?=
 =?gb2312?B?SWNNbWpzWWxxRGFvbkx3U0tmVDFQQk1rTXVmbDR0Ly9GVTZwN0xFNFpXWjZI?=
 =?gb2312?B?SnlaQmRNTUNBSW1xdTAyWEpyb21acmMrOGVBZXJ0SGh6VkJldVF2WDg1c3lt?=
 =?gb2312?B?VWVpSk1WaURobE0yeVFGMHYwS2h1empOMFhOZ2pmejN5dDlDYTZLVHh1eXo2?=
 =?gb2312?B?Rmp3TXBIZko4MXJhT0gwOElvSTBQdFA4Q3RqQ3BoVWd3bktCd2k5SW5JNzNt?=
 =?gb2312?B?TjVlZTJvZjBHSWRiazEzamVZWmlCcVB4S3VvSjVEaXpCQkgvRVM5Z0l6VXpK?=
 =?gb2312?B?ZkpJa0g3dGhuSE9LT04yRDJ2RGtqdlNGV1B3WmRWN1VpZHFXSTFoMjZtUDZr?=
 =?gb2312?B?NmV0U2pjK3htZVhFMm93bmw5UDYxa0VuU2duRFNWY1RHcE93b3ROU21XN0Iz?=
 =?gb2312?B?SDJsVThMVU8rdGtQMnlhQk5DdkRZTEhWVXI2c281cERDbXlqNDJsMm43SUQ2?=
 =?gb2312?B?MkZ3RVEzemFzek5uOFJkZzVYcEFYam1zcVpZWFY3emFqamt2MUlCSnh0ZWtX?=
 =?gb2312?Q?Ng1o=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 609af3c9-cb3e-440a-c783-08dca6ffba7e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2024 08:00:45.5443
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fAdciDS6eU2iNxaYs29/kLU0Dxv2ZTyFdDQpL+odBocaEemL9t1BstbCEypLaWhEGc/tJzQqQpUsobkqJaAReg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10582

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQZW5nIEZhbiA8cGVuZy5mYW5A
bnhwLmNvbT4NCj4gU2VudDogMjAyNMTqN9TCMTjI1SAxNTozNQ0KPiBUbzogV2VpIEZhbmcgPHdl
aS5mYW5nQG54cC5jb20+OyBtdHVycXVldHRlQGJheWxpYnJlLmNvbTsNCj4gc2JveWRAa2VybmVs
Lm9yZzsgcm9iaEBrZXJuZWwub3JnOyBjb25vcitkdEBrZXJuZWwub3JnOw0KPiBzaGF3bmd1b0Br
ZXJuZWwub3JnOyBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOyBmZXN0ZXZhbUBnbWFpbC5jb207DQo+
IGFiZWx2ZXNhQGtlcm5lbC5vcmcNCj4gQ2M6IGxpbnV4LWNsa0B2Z2VyLmtlcm5lbC5vcmc7IGRl
dmljZXRyZWVAdmdlci5rZXJuZWwub3JnOw0KPiBpbXhAbGlzdHMubGludXguZGV2OyBsaW51eC1h
cm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmcNCj4gU3ViamVjdDogUkU6IFtQQVRDSCB2MiAzLzRdIGNsazogaW14OTU6IGVuYWJsZSB0
aGUgY2xvY2sgb2YgTkVUQ01JWCBibG9jaw0KPiBjb250cm9sDQo+IA0KPiA+IFN1YmplY3Q6IFtQ
QVRDSCB2MiAzLzRdIGNsazogaW14OTU6IGVuYWJsZSB0aGUgY2xvY2sgb2YgTkVUQ01JWCBibG9j
aw0KPiA+IGNvbnRyb2wNCj4gPg0KPiA+IFRoZSBORVRDTUlYIGJsb2NrIGNvbnRyb2wgY29uc2lz
dHMgb2YgcmVnaXN0ZXJzIGZvciBjb25maWd1cmF0aW9uIG9mDQo+ID4gcGVyaXBoZXJhbHMgaW4g
dGhlIE5FVEMgZG9tYWluLCBzbyBlbmFibGUgdGhlIGNsb2NrIG9mIE5FVENNSVggdG8NCj4gPiBz
dXBwb3J0IHRoZSBjb25maWd1cmF0aW9uLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogV2VpIEZh
bmcgPHdlaS5mYW5nQG54cC5jb20+DQo+ID4gLS0tDQo+ID4gVjI6DQo+ID4gQWRkIFJNSUkgcmVm
ZXJlbmNlIGNsb2NrIG11eCBmb3IgRU5FVEMwIGFuZCBFTkVUQzEuDQo+ID4gLS0tDQo+ID4gIGRy
aXZlcnMvY2xrL2lteC9jbGstaW14OTUtYmxrLWN0bC5jIHwgMzANCj4gPiArKysrKysrKysrKysr
KysrKysrKysrKysrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMzAgaW5zZXJ0aW9ucygrKQ0K
PiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL2lteC9jbGstaW14OTUtYmxrLWN0bC5j
DQo+ID4gYi9kcml2ZXJzL2Nsay9pbXgvY2xrLSBpbXg5NS1ibGstY3RsLmMgaW5kZXgNCj4gPiA3
NGY1OTVmOWU1ZTMuLjE5YTYyZGE3NGJlNCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2Nsay9p
bXgvY2xrLWlteDk1LWJsay1jdGwuYw0KPiA+ICsrKyBiL2RyaXZlcnMvY2xrL2lteC9jbGstaW14
OTUtYmxrLWN0bC5jDQo+ID4gQEAgLTI0OCw2ICsyNDgsMzUgQEAgc3RhdGljIGNvbnN0IHN0cnVj
dCBpbXg5NV9ibGtfY3RsX2Rldl9kYXRhDQo+ID4gZGlzcG1peF9jc3JfZGV2X2RhdGEgPSB7DQo+
ID4gIAkuY2xrX3JlZ19vZmZzZXQgPSAwLA0KPiA+ICB9Ow0KPiA+DQo+ID4gK3N0YXRpYyBjb25z
dCBzdHJ1Y3QgaW14OTVfYmxrX2N0bF9jbGtfZGV2X2RhdGENCj4gPiBuZXR4bWl4X2Nsa19kZXZf
ZGF0YVtdID0gew0KPiA+ICsJW0lNWDk1X0NMS19ORVRDTUlYX0VORVRDMF9STUlJXSA9IHsNCj4g
PiArCQkubmFtZSA9ICJlbmV0YzBfcm1paV9zZWwiLA0KPiA+ICsJCS5wYXJlbnRfbmFtZXMgPSAo
Y29uc3QgY2hhciAqW10peyJleHRfZW5ldHJlZiIsDQo+ID4gImVuZXRyZWYifSwNCj4gPiArCQku
bnVtX3BhcmVudHMgPSAyLA0KPiA+ICsJCS5yZWcgPSA0LA0KPiA+ICsJCS5iaXRfaWR4ID0gNSwN
Cj4gPiArCQkuYml0X3dpZHRoID0gMSwNCj4gPiArCQkudHlwZSA9IENMS19NVVgsDQo+ID4gKwkJ
LmZsYWdzID0gQ0xLX1NFVF9SQVRFX05PX1JFUEFSRU5UIHwNCj4gPiBDTEtfU0VUX1JBVEVfUEFS
RU5ULA0KPiA+ICsJfSwNCj4gPiArCVtJTVg5NV9DTEtfTkVUQ01JWF9FTkVUQzFfUk1JSV0gPSB7
DQo+ID4gKwkJLm5hbWUgPSAiZW5ldGMxX3JtaWlfc2VsIiwNCj4gPiArCQkucGFyZW50X25hbWVz
ID0gKGNvbnN0IGNoYXIgKltdKXsiZXh0X2VuZXRyZWYiLA0KPiA+ICJlbmV0cmVmIn0sDQo+ID4g
KwkJLm51bV9wYXJlbnRzID0gMiwNCj4gPiArCQkucmVnID0gNCwNCj4gDQo+IEJvdGggdGhlIGVu
dHJ5IHVzZSByZWcgYWRkcmVzcyA0LCB1c2UgYSBsb2NrIHRvIHByb3RlY3Q/DQo+IA0KDQpJIHRo
aW5rIHRoZXJlIGlzIGFscmVhZHkgYSBsb2NrIChiYy0+bG9jaykgdG8gcHJvdGVjdCBpdCwgcmln
aHQ/DQppZiAoZGF0YS0+dHlwZSA9PSBDTEtfTVVYKSB7DQoJCQlod3NbaV0gPSBjbGtfaHdfcmVn
aXN0ZXJfbXV4KGRldiwgZGF0YS0+bmFtZSwgZGF0YS0+cGFyZW50X25hbWVzLA0KCQkJCQlkYXRh
LT5udW1fcGFyZW50cywgZGF0YS0+ZmxhZ3MsIHJlZywNCgkJCQkJZGF0YS0+Yml0X2lkeCwgZGF0
YS0+Yml0X3dpZHRoLA0KCQkJCQlkYXRhLT5mbGFnczIsICZiYy0+bG9jayk7DQp9DQoNCk9yIGRp
ZCBJIG1pc3VuZGVyc3RhbmQgdGhlIHVzYWdlIG9mIGJjLT5sb2NrPw0K

