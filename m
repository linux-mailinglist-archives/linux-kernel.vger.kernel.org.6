Return-Path: <linux-kernel+bounces-548035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7DCA53F0F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 01:24:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6355316E5F8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 00:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42EE76AA7;
	Thu,  6 Mar 2025 00:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iWvRtDW9"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2088.outbound.protection.outlook.com [40.107.21.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9644C76
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 00:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741220688; cv=fail; b=I4sZ4s7AKaYfnriRhuVbNepinmKZzPhRhuxJ4KNopCFTrC1bA8tWPnxL3vrA7GXx+OGQ8J7PFOEzUq+cQpBuqpt4l34leg8NsRpco/JPFNGXZd28pXTBjiLw8TUzhznPnFGHKRiYWfde5wTzCA64i18wl8cd40DmN0wWWJHFjGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741220688; c=relaxed/simple;
	bh=eaMIIZo119YtgZBLFFFRKfWZ73UZ/xHhlCbJEva0da0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bBcwt+kIL9PERU8ycWe7jN0HPv4RNYVMUvdAJn+ABUEGRbJ75GVVTJhWeacCWPPlwsR0orcYjnkg4qeOmbzIiyhPd7ZOYz7RIuHghQg5LcR7iHq59b+0uU4BPMDjjxM/8VnsDpqMkrJM/YL/oqT46LRHK7pmK/4jhqvkHDADFuc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iWvRtDW9; arc=fail smtp.client-ip=40.107.21.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sdD/knAwPAg603pR/zSUxBy4rgUqdosUIFmcGpli7pflRlvzwPTGhL5T9orvY4BeJUBybpO3aj40iXt4sT7w7fvvvCQYF3yGs2HmohUJKlE67qj4h/rEnUnueN7Q0BKAIHZGuR6k4/L+N37vBBJgn1oHkjmygyPJKVlXeJithKCzRBIH6Z93GxvPZApP8Xs7Rhebf0Oqz4MqWs8hvO12By4+mEg21rVsiXd+cjyRpVb5iShXgyK9iufSu4/9WkMoc+ER8XWh779R2HwcPshT4ROds7q10xWx2Vbvj9gEEcfBpeUybh4y6VxreMjhs4coA6NtzXsuFKGBjJGKxETs2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eaMIIZo119YtgZBLFFFRKfWZ73UZ/xHhlCbJEva0da0=;
 b=G34/5PdP8UVhyZOp49fmgeNUfZmlyOgbQbsHVouzr4aKtQ76Je4S4qdJkDvkFZr/a8xPC2NKcyHNS/NMlG6+CKj+rL8JxHsD2/5eniIE5P3agC2Zo9p6K0guuKpJ0bvOf3bF6MiM/YLuGAeeGA/mVweAmooKEpyS86wJ/Xx0jZc5EKx/5fLw5fQ2wrvab2fmtvR/Ognks9bDUk3xB7v8QdPboGl1NC7K9NHsEgNo+wewJu6JnN5DGsbkSZHAGHsW2Ifh7VkxZtmzuTASe8c+Xv9kyHPJdNe1IbeXtRR3sdrADtDKOIdzBqZwUnWmA8JoSc940R6By8UH6hSt6deR6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eaMIIZo119YtgZBLFFFRKfWZ73UZ/xHhlCbJEva0da0=;
 b=iWvRtDW9AULIcLiOnDLtLHTzsdlU1zwWI4jxld+/rTnXwBmHtR8ny+taX8x4scpUevXk6y72cjqEQCUa1KW/hkEhf/xZ5/mFpicH8G5es9DTL9FYbQveeHd1US+NWaRdS9yPv0oFMokKimGLGYFZY5kt5ED6o0kmziELHWrvXfewEtF9zVmb324lGYDsFMXA6+ep7akpisF9/AMqC0l86NaPvCsySBQ3vy0dGnJHLz0yvKx4kcfeqcehKoDFRC3dkTT2cP8/BICdgpQ8HogAP+1XhJQi+YnYQzrh6eK4NiAHWwjIQRg/P2qQEEfjS9C9RGrW7xpBe7WuP5szl9lRnA==
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by PR3PR04MB7452.eurprd04.prod.outlook.com (2603:10a6:102:80::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Thu, 6 Mar
 2025 00:24:43 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%5]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 00:24:43 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Stefan Eichenberger <eichest@gmail.com>, "vkoul@kernel.org"
	<vkoul@kernel.org>, "kishon@kernel.org" <kishon@kernel.org>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "tharvey@gateworks.com" <tharvey@gateworks.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>
CC: "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 0/2] phy: freescale: imx8m-pcie: fix and cleanup phy
Thread-Topic: [PATCH v2 0/2] phy: freescale: imx8m-pcie: fix and cleanup phy
Thread-Index: AQHbjd0NnDUH/ibr20CqhJb/kTqbFbNlP3Tw
Date: Thu, 6 Mar 2025 00:24:42 +0000
Message-ID:
 <AS8PR04MB8676367C2BD21FB1A8C386748CCA2@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <20250305144355.20364-1-eichest@gmail.com>
In-Reply-To: <20250305144355.20364-1-eichest@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|PR3PR04MB7452:EE_
x-ms-office365-filtering-correlation-id: b2600a21-abe9-4f5e-3507-08dd5c454a91
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?SHVJOEJlS1R6dzFQZkpmNER0c05xYlhHSUdENmpHWSs2TXdIVGRZaFR4UHdB?=
 =?gb2312?B?L0xGdFlvSSs1TjRCS3E3c2dLUkk3OGdQOFBxVkx1VEpGVWJXd0NtSFBwem1T?=
 =?gb2312?B?bVhBRUlZYWZsaWtMT2hkOU9qZkNuQXBMbytsNDJpWVNoWGhHZ0tBWFpHOUdD?=
 =?gb2312?B?NHNTUUlrd2Nxd25hb25iSFZIakswOTFRbUcwYXRzMk9RSmRpdW9FcXlDanRs?=
 =?gb2312?B?azVkUVl1WUx5cW1aRXY4Zkx6SDVMRmZKVTRMSXd2dk1sbFpkYlpsK1IwV0pw?=
 =?gb2312?B?QXZnd1lIdVU2V1pNVHBnZ3UwUUFWcnRkVzRZOVFKcUgxYU9YQ1JlejRIaDFS?=
 =?gb2312?B?d2htWm9IUWdWSUNNYjdNblVRT1ZVd1lCWHdUM0p6NlpCY3NqczNEek9RbWc2?=
 =?gb2312?B?aTRZOFZJNXNwL0tnTFZVRHR6OURVQ2F0eDlPdkExL08wWEdGTXpwVUV2OFhi?=
 =?gb2312?B?T3VYd2VQUFhSY2ErUzArTEEzKzFzZE5aNnpoUzVKUHZaK2dtQ3Nrcm5TNmoy?=
 =?gb2312?B?d0RxUEJiZk43WERuSFBaNytqZTI5YWxQQm9YcHVGb05LK1d0dXoyK05FWnJq?=
 =?gb2312?B?MndJRk1YeGlZMnloVFMwT2tma2RoQUZadzRDbTBjdHJaaXJGeGc0NldkT1R1?=
 =?gb2312?B?Wk9kNktHQ3Nza0FuL1BicVZ6bWRLMnVGc0tEYkZVRC93RWRqQXNRaVZWU1ox?=
 =?gb2312?B?T1lTbUNWN3VlNXNwWHhBeWlmelZZTVNVQ2NPTUJZZEM3dVVxTG53Z1ZHZ2gv?=
 =?gb2312?B?REpQem1zbjlrM0JULzRXRGJsdWVJL2ltTkMyRzcwMlowbW5vV2pTK1BUbmRV?=
 =?gb2312?B?b2FDRVlpdFR3TFVJbjc5VTYraEtGZC94MG5MTHN1TGx6NEhJajM2UVVvWDRE?=
 =?gb2312?B?RnN5OXNncWZGSkdqVHJtaks4VzV2cllRQWs3akI0MUJDK0JNZTgwUFlWdHBp?=
 =?gb2312?B?ekdrdTE2MFNKTWNPbnNaM21JMkljV1V6dmxZNmJjNkQ1V2xQQ2JjcUJiREVT?=
 =?gb2312?B?UW1Ja2xXOE1LVnhpaGRBZmw0YWhXdGRpd1lQcmpha0c1Y2VueHRyejdEbGxD?=
 =?gb2312?B?UWh3d2V6WFNndW1RTWRab1FzdTAxY1N2ZnpYWjVTSVNjRWZNTTRlbDZ4MlN2?=
 =?gb2312?B?dDNhdExjTGFBSHZyUjlMU2YzMTRVOExXUndoVVYrWTB0UEJqcHZWMjJGNStz?=
 =?gb2312?B?Q0lJMmNSMlNjWVBKUmlwYUVvT0VUYU84WVZ6d0Nib3djMisrcXhiLzVZYUNy?=
 =?gb2312?B?bHJoSURUaDZnWS9iTkU3RFUzbGJEaVQ1QnZhNTRaZG5EbXBMaXNWdlBNeVh0?=
 =?gb2312?B?L05ZNzRNdFpKM1pETCtuSUQ0cDRRVHpmTkdJU3NmYmhqalJOZE9aWkl6WlNh?=
 =?gb2312?B?MW5sdzRyZDd4K29kMmtqK3lGSHJ0Tm11M1FzUWRLWDVUcjcvZFRhYVNQSnlU?=
 =?gb2312?B?cU1aOG82NWJ5a05Rb3JpZnVxQTVrQTB0S2hHTW9RejBYYmNnYTFrS1ZIUGFa?=
 =?gb2312?B?L0oraFZxdVljNnN6L0dnWkJpUXBSTHFVSFY4TjRNRVh2NGtGbi9LU05vajRx?=
 =?gb2312?B?aWVKdHdEV0NpejEvTVNZQUxpaU0zQXNCQTJpaWRxVWU4UjFBS3l4WU9oNGNP?=
 =?gb2312?B?TWExMnBWdDh6MlJxWENSL0ZwamJRSWt5MW4zT1NwY2g5dkZGR1lWVWdKQUkz?=
 =?gb2312?B?NUdnRVRvZEFTMzcwb0orWFhvZ3RNUFozSDJwRk01cFIyWkppcHhLNVZES0o3?=
 =?gb2312?B?RXJYMkRmQnhJNDBucVVZV0plWHZKTTdMWU04clRaMlk1SUliaFdvZ0JnQTBi?=
 =?gb2312?B?MVAyQ2pRZmNrWVpYeEQzMjh4aGptZk1TZVFZRjRDKzFmbXNCWHVXUjcxcHJj?=
 =?gb2312?B?dGE2Z0E1aS9IWmR3Smg1V2JUWnZkbEdrS0VpVWxxMFNKZUI5R2diNGovcGFL?=
 =?gb2312?B?SDg0Sm1NY1JqS1pXWlkwdnhFaWhFWThqL1lzQ29oSDZTSjlrOHV1YjNZYVZq?=
 =?gb2312?B?NUExcktVKzlRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?dk0ybkwzRElYYWM3TjdjM2pISVh0dzh4Y1VVRnpjRW8rUkRDMlM0M2xYak4y?=
 =?gb2312?B?dGhJNG13RjZSWjZrL01ZRTVxTVJOZHhrbzBrZU9JMytUbmpEenJOUlV3eEMv?=
 =?gb2312?B?aU5OZDJQVHd0TTRCaWQ2b3ZUa0EzS1NUdWRDMlVQcDlmWFNWMkhpa3FFODBs?=
 =?gb2312?B?c3VNRVJIS2U3cnBCMVFkMUhNNTRPK3BUZTd0U2laY1N5YWtJMUZUZ1p2ZlJT?=
 =?gb2312?B?aVdhcDRibnlxR0NpYktjWUlpZXhJRzVDNnNpREJpcWVOTE54NHZ1ZUhkSkFh?=
 =?gb2312?B?TzduT00vUU1LUDhMUDd3clpseWQ0OWRPYVoySTZSNzRvS3Zmbk5yd0lick9Q?=
 =?gb2312?B?Ly9HZG1rSnRNbkFieXZITnBERGpXZ1NidmR5NnNXdFAvSlpyZjZxUFQxcCtY?=
 =?gb2312?B?d2ZTS09QZ0wxWUpOejhwazU5UHZsbUdqK3dEUG9pdkRXUUovem50TmM1RU5N?=
 =?gb2312?B?aGlXa2owbm51MlpKV3lXR1RZRGVSOEduT2IyK0E2MS9yU0tjK3FOWWhUOVNn?=
 =?gb2312?B?dUwrSVZMVHhVQ0FteXo4dWZNODVTQS9VMEFLUWt1SEYvcWRhWkY2S0NPazZV?=
 =?gb2312?B?R1F5ZmtSNmtnUDJwMHZpbTRnSlVuZ3J5STRTRERLbWU2ajlQQk5RbkVNRGhG?=
 =?gb2312?B?d2p4b3ZEdkVmdTcxRHF0TUpMWFFHTlBlLzY2alh5dmFjM2IwZDRFVHFabGI1?=
 =?gb2312?B?Sk91ZHlIRzlkZGRqY1g0WVBpSWpCNmFiL080aWVVNjlwalRod0RyUUFBbXBx?=
 =?gb2312?B?a3RLaEZaUWV6ZlNDb3lSditsSzl0VFJOWWVCWS9MZE44c0F2cHZzNjBISWFn?=
 =?gb2312?B?N2o3ckRiN01ILzVaK3ZpeUhOTHhtNHlUZGVYQzAxK2JwTlRVNG84a3VVV0F0?=
 =?gb2312?B?Q0VCcmpnd1NrclJmZS9naUt4M0tBelMyU1AwU3Y2c0JWcVdnS3V2L05jS3dZ?=
 =?gb2312?B?SHkrTjR6ZkJnR1FxVGtQbjZXWFpiSzI0MmNDalovcUVPNm5wVjMzN0RIZGRx?=
 =?gb2312?B?Q0ZvWFNZWE02ZnlNRitKTllaZk03U0RzK1V1TFphSnFvV1o1MzZYdGswOVZC?=
 =?gb2312?B?d0VTMzYrQzB5anUzVWVSNDFWMGFONmhycW1mK2pwNUNGMDM5Q3lzSjU3cWFv?=
 =?gb2312?B?WENuZ2MxNXZreHVsajVMclcxWFFEM3lyRXErNlJzWkh2emFqUzhqbm50akZy?=
 =?gb2312?B?bHYwQ2tEeUF2RmlqeG1QUFdqY0xoNWd4amg2U1pwNDhJckhodnE2VXoyaWZl?=
 =?gb2312?B?UGYrWkZ3R05KSlpWZWxtaTRZQ2pnQ1p3bDlOZUNMVXRVcUdXQkVSSlQ5MGJF?=
 =?gb2312?B?dlA5RWRkWm5FTFUzNU52YlVXKzUrQUczTEp6OS8vR3FPMTVtNXVPbm4yUjdr?=
 =?gb2312?B?ZjYyOUhHcExpOHU3T3FkTzBUeUo5czU1TTdHVjlKVEwrclhJTHVvMldpNGtQ?=
 =?gb2312?B?VnpVOU9WU3NyRFh5T01OQ2dlV1hhUU5aM013aTFuVCtDR2p3S0pnb2RBK01j?=
 =?gb2312?B?R01nRkVVK2Fic3NLNzNlbjNUbHhWbkF0T2N3elRJWmNUK2E4YXN4MlVRdW5F?=
 =?gb2312?B?a0ROYjlaR1BPeGxRb3BNNVBjZEpqaTc5YTd2UHdub0NjbGNxWGFtcjY2R2Fz?=
 =?gb2312?B?NHBvazJpeTJDYk5WWlpITWY4cDVPUHN0R1psVDRZQWFINGt6RlJSelQxRDcx?=
 =?gb2312?B?cXBvMk9hN0xCZ0RoL2swVlNmMVBNL205UnZMUmc0VlBhYlpOR3lTNklWdzhp?=
 =?gb2312?B?TmxiYzdBbElIL3ZXL0ZCZTcwTlNqbzRjTXl2cko3Z01rTUhyVGVxSlZyUmVD?=
 =?gb2312?B?Tm5ZN05ydDZhNEhtMk9GS0x3WThYMUdjOHJtY3F5dHlSUjI3WGxUUlZ1d1E1?=
 =?gb2312?B?VEVzOTRibUViNjdJZEpRV1dpQVROTS9leWJsMC9iRVF2aExMMlNFNkE5ZDZ1?=
 =?gb2312?B?TUhCaGZMVXVMaWtIdGtzTnZUcXl6YjZDV3ZHM00rOE5za0tIL09tRFA2OEp1?=
 =?gb2312?B?cHBhQXU3N3lPWTFCQU1mcDFNWVF3dTV1ZEdZSHp3ZUVNTVJMUkc2QUQ2cCtG?=
 =?gb2312?B?bGJtcEsyOHZWeUtCak45QXZTYkh4S2xNbVVXUVE1RE5nMWorT1RNR3EwdFYz?=
 =?gb2312?Q?0uwJLT3b4lNkFd0j8oTRE2mSp?=
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
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2600a21-abe9-4f5e-3507-08dd5c454a91
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2025 00:24:42.9735
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cAB7hpRny6elzpyeFYizErPZ4GG3XZ0w/mb1xVmBhMHRNTXPvQGgB2hs/DG5LVsYtZAr6pQSaWwM2w7kedVLEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7452

SGkgU3RlZmFuOg0KVGhhbmtzIGZvciB0aGUgY2xlYW4gdXAgYW5kIGJ1ZyBmaXguIFBsZWFzZSB1
cGRhdGUgdGhlIGNvbW1pdCB3aXRoIEZyYW5rJ3MgY29tbWVudHMuDQpGb3IgdGhpcyBzZXJpZXMs
IEFja2VkLWJ5OiBSaWNoYXJkIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQoNCkJlc3QgUmVn
YXJkcw0KUmljaGFyZCBaaHUNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9t
OiBTdGVmYW4gRWljaGVuYmVyZ2VyIDxlaWNoZXN0QGdtYWlsLmNvbT4NCj4gU2VudDogMjAyNcTq
M9TCNcjVIDIyOjQzDQo+IFRvOiB2a291bEBrZXJuZWwub3JnOyBraXNob25Aa2VybmVsLm9yZzsg
c2hhd25ndW9Aa2VybmVsLm9yZzsNCj4gcy5oYXVlckBwZW5ndXRyb25peC5kZTsga2VybmVsQHBl
bmd1dHJvbml4LmRlOyBmZXN0ZXZhbUBnbWFpbC5jb207DQo+IHAuemFiZWxAcGVuZ3V0cm9uaXgu
ZGU7IHRoYXJ2ZXlAZ2F0ZXdvcmtzLmNvbTsgSG9uZ3hpbmcgWmh1DQo+IDxob25neGluZy56aHVA
bnhwLmNvbT47IEZyYW5jZXNjbyBEb2xjaW5pIDxmcmFuY2VzY28uZG9sY2luaUB0b3JhZGV4LmNv
bT4NCj4gQ2M6IGxpbnV4LXBoeUBsaXN0cy5pbmZyYWRlYWQub3JnOyBpbXhAbGlzdHMubGludXgu
ZGV2Ow0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogW1BBVENIIHYyIDAvMl0gcGh5OiBmcmVlc2Nh
bGU6IGlteDhtLXBjaWU6IGZpeCBhbmQgY2xlYW51cCBwaHkNCj4gDQo+IFRoZSBpbXg4bS1wY2ll
IFBIWSBQTEwgZmFpbHMgdG8gbG9jayB1bmRlciBjZXJ0YWluIGNvbmRpdGlvbnMgd2hlbiByZXR1
cm5pbmcNCj4gZnJvbSBzdXNwZW5kLiBUaGlzIGlzIHJlc29sdmVkIGJ5IGFzc2VydGluZyB0aGUg
UEhZIHJlc2V0IHdoZW4gcG93ZXJpbmcgb2ZmIHRoZQ0KPiBQSFkgZHVyaW5nIHN1c3BlbmQuIFRo
aXMgZW5zdXJlcyB0aGF0IHRoZSBQSFkgaXMgcHJvcGVybHkgcmVzZXQgd2hlbiBwb3dlcmluZw0K
PiBvbiBhZ2FpbiBpbiByZXN1bWUuDQo+IA0KPiBDaGFuZ2VzIGluIHYyOg0KPiAtIFJlbW92ZSB1
bm5lY2Vzc2FyeSBjaGVjayBpZiBwZXJzdCBpcyBub3QgbnVsbCAoUGhpbGlwcCkNCj4gDQo+IFN0
ZWZhbiBFaWNoZW5iZXJnZXIgKDIpOg0KPiAgIHBoeTogZnJlZXNjYWxlOiBpbXg4bS1wY2llOiBj
bGVhbnVwIHJlc2V0IGxvZ2ljDQo+ICAgcGh5OiBmcmVlc2NhbGU6IGlteDhtLXBjaWU6IGFzc2Vy
dCBwaHkgcmVzZXQgYW5kIHBlcnN0IGluIHBvd2VyIG9mZg0KPiANCj4gIGRyaXZlcnMvcGh5L2Zy
ZWVzY2FsZS9waHktZnNsLWlteDhtLXBjaWUuYyB8IDIzICsrKysrKysrKysrKystLS0tLS0tLS0N
Cj4gIDEgZmlsZSBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQ0KPiAN
Cj4gLS0NCj4gMi40NS4yDQoNCg==

