Return-Path: <linux-kernel+bounces-246872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B6492C844
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 04:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD2241F23334
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 02:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900EFB660;
	Wed, 10 Jul 2024 02:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="YQGg0A7B"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2088.outbound.protection.outlook.com [40.107.20.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B905CB8;
	Wed, 10 Jul 2024 02:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720577368; cv=fail; b=T080Akv/KPVc9E+vewin2FXJre4Y/C/CnJL7hlgbn0T7HfWwfjFenLUh0oIg3AEw17jQKdjH21eMu7cTlKaeNY1uR7F0mUYiTGYp/+8NSEUz8Zfz6+bS5e8DqI/pSFxXOTUWPEsn2VkLXSCSHKbeVX1ZYkL45nvGH11LP/Opo2A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720577368; c=relaxed/simple;
	bh=bGAVu/x9nls8AgBE8ZfpZaGhTh+EKuo8AXPGMUaqhnU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rFtPeVyZlVfdE7eYS2X2ySNssMVFVyOq/BShXORs9oCZaOB3RMfq6nuOBVAkq2HiI+tPAXwQ+mbT82iBj60qFx/jGE0N1f3PhH9DSkTxQo/QqF+pM3A0fULUYLpKmB4UVqMlxPGnU7qnOTcHUTQxxnf5MsFoQL0u6m7WBp70TT4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=YQGg0A7B; arc=fail smtp.client-ip=40.107.20.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RPtqfpE46SrmX3INCeKvN8+gbtENvr4tvW1ET6KUU7IkhwGHw6Hq5N0HB5fEnXG6OuqHY6UDSjJmve3pdtADfnf7zTmrysrDUyo3MWFkyZQUpzp1eIbCyFi7ufL2NULuh/2xn/LsK1mAEXlyKbpDvGnzllcN9qw5uRCubUKVZZtNULxakKnAn0XjZQ0mp3Nmfj5BwtuUJvonrbOc2FByObtnbBRUgQ/peMOrtOfP65B2B2krS3/s+RpAMK9nNjRPcbmkhNcy+hATu+dxIQIf0vMgt/cymAPLqHfsivpmSxgipXO07MbEuASk4fi9GLYjXgrrmtSahBQrIxNLOkD0nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bGAVu/x9nls8AgBE8ZfpZaGhTh+EKuo8AXPGMUaqhnU=;
 b=kCq639CqMoDbcYc3jGNJUoKpyK3KPBDyXewUVnW1ZIBaG+83zFdOFmayMr+24aEWP00VY03RJEUWukopHyoAw+4PlWLAKh1B8QX0VVjZQ8hmPkBLbaYqAqH8Zugs5+wZnf6ZDcosahUppAWkdYyMtJ1cKwovEw2nCl2xO/+9/3o1FzEwXKf72l8m+73TMWHNKMftrS1huAuEQGMxWezscEn1rttvKDzea7xqBOdHa7Wmm1FhUpQdd8eUgzpEvyDMCGH6cifLloKoe+rLIqb+NUSH7xadPXhNCCQ0fDvxIRjwti3Bq7oDNzc/ENmhEyNeaeFZtfVNkmtHQLJ56kCJAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bGAVu/x9nls8AgBE8ZfpZaGhTh+EKuo8AXPGMUaqhnU=;
 b=YQGg0A7BWGrJP3kv3cP+roftoHdThG/Az0T+QT+OvU890lrUGrmf6hUGzNS60lv7GHBihHLGUCHbNiKBBWIDo3ntPnN2v3AJDXMYQU5tUROKxUDrbDC8hTXntfUWCrmAU7OgDafdGKfh92yc6oZq8ixjXmdK0JoR9p/B7bu992g=
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PAXPR04MB8671.eurprd04.prod.outlook.com (2603:10a6:102:21e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Wed, 10 Jul
 2024 02:09:21 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 02:09:21 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Peng Fan <peng.fan@nxp.com>, "mturquette@baylibre.com"
	<mturquette@baylibre.com>, "sboyd@kernel.org" <sboyd@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, "abelvesa@kernel.org" <abelvesa@kernel.org>, Clark Wang
	<xiaoning.wang@nxp.com>
CC: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/3] clk: imx95: enable the clock of NETCMIX block control
Thread-Topic: [PATCH 2/3] clk: imx95: enable the clock of NETCMIX block
 control
Thread-Index: AQHa0dSlmJsiuMOg1UmEpR/J2kHl/LHucI+AgADGRlA=
Date: Wed, 10 Jul 2024 02:09:21 +0000
Message-ID:
 <PAXPR04MB85108ED62C1178D9D0BED9F388A42@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20240709073603.1967609-1-wei.fang@nxp.com>
 <20240709073603.1967609-3-wei.fang@nxp.com>
 <PAXPR04MB8459C43A1D11FA8A9F4AD0FC88DB2@PAXPR04MB8459.eurprd04.prod.outlook.com>
In-Reply-To:
 <PAXPR04MB8459C43A1D11FA8A9F4AD0FC88DB2@PAXPR04MB8459.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|PAXPR04MB8671:EE_
x-ms-office365-filtering-correlation-id: 12c77ed6-7f0e-47cc-7495-08dca0855044
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018|921020;
x-microsoft-antispam-message-info:
 =?gb2312?B?SHJYdnZmWmNVWkFwSGliUE9CUE9WUVUwaWYxSEhmTVNxeDZ4R1h1MGFoQUgz?=
 =?gb2312?B?WVk4aUp5c2J4YkxKZTVHYUpJZlgwTXVHb1Fmc3Evckd6clFVMnAyQjVIOEJV?=
 =?gb2312?B?V3RjaGRQdVdRY09oTmdpNVdObFAxK3J4NmVQaHIrWE42OC9MTVBEMVNtSUNK?=
 =?gb2312?B?N01JYWsyekp4Q2FNd2FERk1Ta1FCNlcveC9YNnJtWXpVYnZsVENLSHM3OXJL?=
 =?gb2312?B?K1ZpcU9tTU9yd2NjUEQzUXloQmxjR1FoU1RJYUpnTkF3Q3lLaDBSL29lbmtj?=
 =?gb2312?B?RXRxTUpHWFBJUWpwZ0tvRmc2QmtxYld4RFZzTDZGL3E4cjlKUzhEekltZnVw?=
 =?gb2312?B?eFlPem5XZUZKSUZhV2pkdGdsblJZdjlZeFNjQ05xZTVVcFlnbkJQa3lmWjJQ?=
 =?gb2312?B?cVZGL1J0VHdFc2s1VGxKRjVObGtKVHRkcEp4RzlCWHZ1UklLdVpMSGxlaFlS?=
 =?gb2312?B?eTRkMjJHUEo2SGI2VVVueXhNYU9WTFdCSXAyQmF4cVJQNGRJb2ZQelFCQ21P?=
 =?gb2312?B?cXlqNkRwaVlibVFSVDZXZXhkTUhUZG9uUzNKUHcwaEJWWnprOE1sbnNVMGJ2?=
 =?gb2312?B?WVlrVkVVNDM5eVpWb0RtZVM2N2hBaXhhYVZIKytaeE9Pd2NsWjU1TjB2YndY?=
 =?gb2312?B?eHpTY2FjU09HNFVHWmlENVYyeDQvYm9HN1N3WnFQdmNnQVZCbkd1UTN6YXJw?=
 =?gb2312?B?OHhUM2VTdEdwRkJkT0JaSnNuNXI2bDZZd0kydUZIbzh4WjJBaS9UekNFN3FK?=
 =?gb2312?B?MENQRVo1b2pkWXRqSEpCRHFEM2JSUkE3RS94S291U2VjdlhObUlZcFByZGRQ?=
 =?gb2312?B?SlVkUlNEczdrR2poak0rb0ptUnBBZWRHWXNzRUlMVEMvT2Z0VGpVNU53ZlBO?=
 =?gb2312?B?cDFDVTdnYjRXVWQrK3h3YzBZK1Z1SHJuMjZBazA1RFo5a1NnZDEvV1ovZVMx?=
 =?gb2312?B?LzJiMDVTNlpRdEREWUVZWXdaM09PaFB5ZElUaDZjc3ovNmZ4N0Y3SVlZUWdr?=
 =?gb2312?B?dE1RQTBmZ0JRSkh0V2Q4cHpTeFZyMy9DZlFrcVZQVjRzUWdOMExVNXI3T2wz?=
 =?gb2312?B?ekhtMEJxd0RBSVlwV3lrQzFramxOWDVOcXFxQ1RGczgrVURGcjVuYjJRSzJt?=
 =?gb2312?B?bGl4UG9ReUJBWUxGalRpUDBDV0kydUVrNWVRYVQxV3hSaGl2bGlBQzJPRnVI?=
 =?gb2312?B?ZkZKRU13WU00OUxObjdpQXZUaXNPZnRxR3BVaHl4aXAwM00xQ1h3RUZNOHJ0?=
 =?gb2312?B?WVdhR3B1N29IUU85ODFnY2JBRG81cXhaSGFsNzhHU293bGhuTmUxOVNUcUFw?=
 =?gb2312?B?Y2UvZGtEajljL1ZXbnFiUStiRGV6MmZtcVFvWGVMYklhY2sycFVvKzJzbE8w?=
 =?gb2312?B?TnJVUmV1bTRwVU1va0s2TUxOK3prWjJCQVV5OHVremg3bzJBQllOdkpBcktY?=
 =?gb2312?B?TFQyS1dWY2R4cU95cGpJV1ZTbE0rZkd3RlFRSk5YTXJLR29wN0JpdjF1S01G?=
 =?gb2312?B?MDFha1l0NzZqUmlhajdBMER1ckFCVWxkU0M5UGJ3NWtaR3Z1YnZRT3FhbHZW?=
 =?gb2312?B?NW95YTZGU3hNNUtEd21pcWdLZ2RRdWVWa3BDZVBrWGFJaXFRUk5NM1Vxb3ZP?=
 =?gb2312?B?TFpqL0srN1VtVGRUYkxOalFSOFd6a3J1OWJUTnpJTFJaT3dia1pZenc4enhR?=
 =?gb2312?B?ODNabHp4QkorSjEwVlFQazgwc1Z2akM3T29CSGF4V0dFQkVyWHdsRHJIbXQy?=
 =?gb2312?B?S0xhRjlMcVdab0RiR0dJVkRFWDhLN2hoZmxQMTVXZWtNTWFXL2dYUFZGd0lu?=
 =?gb2312?B?dUgvQVJNdHp4ZTR2KzhXaTZ0c29QZFd4QkdpWFFxRWVPRGNaakMzdFgxNFN4?=
 =?gb2312?B?SVJLbXltcnJlOUswblJqSkFTZThhbkJGL0NyU1JKY0RIenBMQnhveG1uWWdG?=
 =?gb2312?Q?ptA/CPeIQkM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?Rmx0bGVSNVBQWUh0UllRKzNXZTREZUNCUzRxSHZjNkJpb2RwelQ3MElwWE5j?=
 =?gb2312?B?dWM3U1BzRjY0R1p6a3pGbXRlWUR6eEc3ZkZMbFZ5WWJpUGFTVUxxVVlVanpq?=
 =?gb2312?B?eitlcWtvbXNsL0xFRmZQUDg4ZXFSelBmOC8rSHhMS0JWRkg3WjdCTnJjVitN?=
 =?gb2312?B?U1ZSN0d2TllRbG5XM1ppQUtqV2JNdW9aQ2JMSDN0azJQOWtBR05PUW1tQlhz?=
 =?gb2312?B?cTFvaWNvUTFRT01ndWRxeVBWTU1WOWFKUWpOa0dLYWJONU9rd2tZS2V2NVRa?=
 =?gb2312?B?cGhKcit1S3FkWDYzYnBWcTV1WS84ak5UaFlmQm43VkIxWFRDcTllRE45T2hl?=
 =?gb2312?B?Tk5XZk45cWFIZTBuTDZQNUNuNkVZL0dqeGNjc2pFWDlBSE5oMnB0MWJsLy9l?=
 =?gb2312?B?eGNyTEFuZ2J4YWFNeDZ6S2NxdE41NTlNbUZSNHBodGFtbVk5dE9DNVJ3aVdO?=
 =?gb2312?B?V0FuODV0Wm8rMVE1VTZsTVJVeGJsZTNVY2s3SnE3Y0RncEg2QVNwYWRsUTFE?=
 =?gb2312?B?OUtPQzM1bGZTVk44eWdNaFRXZ3dhT1RLTSt5eUZMRHVUekZ3RUc2TXNobmd4?=
 =?gb2312?B?aHJJRVB1NGVYUVpSV3I4bG9WdEU5RlQ1eEM0SmlGUldGcEJyVkxhUkp5NE4w?=
 =?gb2312?B?OW5zNjdyOHJOOEN2Wi9RVnBaclo4L0ZLNjlWbVpKY21EdWZHWVAzaDZKOGtD?=
 =?gb2312?B?WGxDU3FxemZ3RnhpZnBiT3VncDN4U0taSmp2VktJTVZCUVA0U0dPK21yTFlh?=
 =?gb2312?B?VUtKZjBHYXVpOFYvdmkvUHZQRzhmUWV5dEl3L1haTzhZeFhQMkFod3d6Qko4?=
 =?gb2312?B?bWtmSVNSbUhLWHJqRjR3NWdKZVMxbG5QRUtjZjc2YWwwbjFHU3ZRRCtYSGRX?=
 =?gb2312?B?VlIzRENwTFFLbnluS0ZkT3VqNVZuYXczSmZhcTQzdk9RU0lkeS9EWHNBUDQy?=
 =?gb2312?B?bTc1dkVwZnNYOHNpUnhIT09YdVVkYkczU0ZrU2xkWi9JQWZtMGNRUVo3bjV0?=
 =?gb2312?B?SDhsejdvU0kyMmNiM3dqbzZVYTh2MXFLWDRLQm5EZEYyclovWHFHZ0R3RkNU?=
 =?gb2312?B?ek9CUEw5VnRuNUZGbUUvNjU3SUtoY0VrYjF6d0VzUlhlS21WUm15alFFVmdH?=
 =?gb2312?B?U0paaFFaRW03ZW1peDZ6WW1rZ0tIVU11K0hXcm5vd2ZMZm9GUnBHUDdRVUE2?=
 =?gb2312?B?TmtkeStvVUtVeFozVnBVSm5sWXlXTVd5UjFhdGFlbXYrejFua3FIQUd5T2lD?=
 =?gb2312?B?ZTVjd3B5a2JoaGpqaVFOWkxrc3J3YlozUlBwSnFYL0JxNnNBbVdoeDRibFYv?=
 =?gb2312?B?K0x0YklTMW5Cb0NPWHI1dXhKL1d2eUFXbDhVSkxsa3JJNUFTMFI4NCtZOFA1?=
 =?gb2312?B?OEJVQ2tJMS81TUM2MDE3dWx5Zzl3ZTBPSmZqbnNnTGVTYTBKTHgvMVBjdWpm?=
 =?gb2312?B?R3Z1Um1TWHZ1bnhJMzdKd0x2QmZHWWg3THo5dmVPTGk5NzJORGQ3NlJUUWJF?=
 =?gb2312?B?Y0ZDcnFwakF0T05Ea1VCV29zYXFOdGd5MW14aHRlWjBISWtUMFNXUVk3eHBo?=
 =?gb2312?B?bzB4ZUwxNUQxb3JyT0xvdmtYSTNkWXhUbHpRandhTEl3QmQzQ0FLSXNrY3Ex?=
 =?gb2312?B?V2pIeG1GM3F3N0xkZ0pwYnBCZFVGYXpubjlLVDdrcG1IamxiWDhiU3o0bDVP?=
 =?gb2312?B?UnJCd212SlZoa05mWjBaL3VrYlNvaENTVHphbnB0cm5salk3Skk4RFh6eFVu?=
 =?gb2312?B?QmtYdFE2YzcybEl0WFhyTWM1TDdqWkdxaFdXakc0dWhabW0rTU1EOG54L3hl?=
 =?gb2312?B?VHZ1K2k5QmJpVlRYTzRLbU9aRVlWTmJnaXRwMDZBc1AxZGZ2b1FtYUtwcUgy?=
 =?gb2312?B?d2tlbkpSVXZYZ3VsWHJjMnR4UXI2V0xXL2FLRlRlbnM3RXVZdU5LWURUcHpW?=
 =?gb2312?B?K0N6TTZzOFhndFAyS01nSWluSEFBbWJVSUswT3JNQURJbFpQcGRiMDhNL0JP?=
 =?gb2312?B?c1FtMjZlN2pkTTk2MCtOWE8xTDY1YW5JcE8wcW1KRVFoa004Snlsd2VxaFQr?=
 =?gb2312?B?eWNuVXhWZnNxZGY5clNiS2F0Yk1FT1hBY2c4VXUzTjJBR3YwTG1LZnhPaGc4?=
 =?gb2312?Q?NyHc=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 12c77ed6-7f0e-47cc-7495-08dca0855044
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2024 02:09:21.7163
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q1cSUvTg2RqQo/kyyqUegFM10AGgTsrXT/O/yTe0Yhh4VE3QjST2jpv7ZD4ADjbtiYQbhyk2x2zJO+jy8tjd9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8671

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQZW5nIEZhbiA8cGVuZy5mYW5A
bnhwLmNvbT4NCj4gU2VudDogMjAyNMTqN9TCOcjVIDIyOjEzDQo+IFRvOiBXZWkgRmFuZyA8d2Vp
LmZhbmdAbnhwLmNvbT47IG10dXJxdWV0dGVAYmF5bGlicmUuY29tOw0KPiBzYm95ZEBrZXJuZWwu
b3JnOyByb2JoQGtlcm5lbC5vcmc7IGNvbm9yK2R0QGtlcm5lbC5vcmc7DQo+IHNoYXduZ3VvQGtl
cm5lbC5vcmc7IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7IGZlc3RldmFtQGdtYWlsLmNvbTsNCj4g
YWJlbHZlc2FAa2VybmVsLm9yZw0KPiBDYzogbGludXgtY2xrQHZnZXIua2VybmVsLm9yZzsgZGV2
aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGlteEBsaXN0cy5saW51eC5kZXY7IGxpbnV4LWFy
bS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZw0KPiBTdWJqZWN0OiBSRTogW1BBVENIIDIvM10gY2xrOiBpbXg5NTogZW5hYmxlIHRoZSBj
bG9jayBvZiBORVRDTUlYIGJsb2NrDQo+IGNvbnRyb2wNCj4gDQo+ID4gU3ViamVjdDogW1BBVENI
IDIvM10gY2xrOiBpbXg5NTogZW5hYmxlIHRoZSBjbG9jayBvZiBORVRDTUlYIGJsb2NrDQo+ID4g
Y29udHJvbA0KPiA+DQo+ID4gVGhlIE5FVENNSVggYmxvY2sgY29udHJvbCBjb25zaXN0cyBvZiBy
ZWdpc3RlcnMgZm9yIGNvbmZpZ3VyYXRpb24gb2YNCj4gPiBwZXJpcGhlcmFscyBpbiB0aGUgTkVU
QyBkb21haW4sIHNvIGVuYWJsZSB0aGUgY2xvY2sgb2YgTkVUQ01JWCB0bw0KPiA+IHN1cHBvcnQg
dGhlIGNvbmZpZ3VyYXRpb24uDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBXZWkgRmFuZyA8d2Vp
LmZhbmdAbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9jbGsvaW14L2Nsay1pbXg5NS1i
bGstY3RsLmMgfCAxICsNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+ID4N
Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbGsvaW14L2Nsay1pbXg5NS1ibGstY3RsLmMNCj4g
PiBiL2RyaXZlcnMvY2xrL2lteC9jbGstIGlteDk1LWJsay1jdGwuYyBpbmRleA0KPiA+IDc0ZjU5
NWY5ZTVlMy4uMDdjNzBjMGE1M2Q0IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvY2xrL2lteC9j
bGstaW14OTUtYmxrLWN0bC5jDQo+ID4gKysrIGIvZHJpdmVycy9jbGsvaW14L2Nsay1pbXg5NS1i
bGstY3RsLmMNCj4gPiBAQCAtNDE5LDYgKzQxOSw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2Zf
ZGV2aWNlX2lkDQo+ID4gaW14OTVfYmNfb2ZfbWF0Y2hbXSA9IHsNCj4gPiAgCXsgLmNvbXBhdGli
bGUgPSAibnhwLGlteDk1LWx2ZHMtY3NyIiwgLmRhdGEgPSAmbHZkc19jc3JfZGV2X2RhdGEgfSwN
Cj4gPiAgCXsgLmNvbXBhdGlibGUgPSAibnhwLGlteDk1LWRpc3BsYXktY3NyIiwgLmRhdGEgPQ0K
PiA+ICZkaXNwbWl4X2Nzcl9kZXZfZGF0YSB9LA0KPiA+ICAJeyAuY29tcGF0aWJsZSA9ICJueHAs
aW14OTUtdnB1LWNzciIsIC5kYXRhID0gJnZwdWJsa19kZXZfZGF0YSB9LA0KPiA+ICsJeyAuY29t
cGF0aWJsZSA9ICJueHAsaW14OTUtbmV0Y21peC1ibGstY3RybCIsIH0sDQo+IA0KPiBUaGlzIHNo
b3VsZCBub3QgYmUgYWRkZWQgaGVyZSBpZiBubyByZWFsIGNsb2NrcyBhcmUgaW5jbHVkZWQuDQo+
IA0KVGhpcyBpcyB0aGUgZmlyc3QgcGhhc2UsIGFuZCB3ZSBhcmUgY3VycmVudGx5IHByaW9yaXRp
emluZyBzdXBwb3J0aW5nIHRoZSBSR01JSQ0KaW50ZXJmYWNlIG9mIEVORVRDIG9uIHVwc3RyZWFt
LiBXZSB3aWxsIGFkZCBzdXBwb3J0IGZvciBtdWx0aXBsZXhpbmcgb2YgdGhlDQpSTUlJIHJlZmVy
ZW5jZSBjbG9jayBsYXRlci4NCg0KPiANCj4gPiAgCXsgLyogU2VudGluZWwgKi8gfSwNCj4gPiAg
fTsNCj4gPiAgTU9EVUxFX0RFVklDRV9UQUJMRShvZiwgaW14OTVfYmNfb2ZfbWF0Y2gpOw0KPiA+
IC0tDQo+ID4gMi4zNC4xDQoNCg==

