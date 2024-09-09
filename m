Return-Path: <linux-kernel+bounces-320513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75DC1970B6D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 03:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D912284861
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 01:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973B612E4A;
	Mon,  9 Sep 2024 01:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BjCjHqf6"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013004.outbound.protection.outlook.com [52.101.67.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEFE1097B;
	Mon,  9 Sep 2024 01:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725845953; cv=fail; b=jzmCsrU2n8CZZv0wMKbHcyDEhNxfmoxPfxeXYP8T7G6QNLDQX5Py84P9bkMqAhGJCjJDi1jKOr814RJtW8GD2+BSMZxQTtqz86G1l22M2XXUaXj/3c1yAntg55lyp06U7ImfQ2F7KBkuEceEUpPNJSsZOahnY8IVTeP/YkeQFgw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725845953; c=relaxed/simple;
	bh=I+qJBZt98xE7R2r758KFVu+/Se829mtEnB9zGU3qXwk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=twCMiXomqmMxL+GUNPbOLcfMwQEDKV5goVbOORdzV8JFx3vbuyUww18fm0hk8NBTNBz7VBoCNH0y0VEsGA41quzS/99NNTrqp+/I7gjdVyr4fY4n6ae2yeVP9uk54jsaL7412j1gKPlqNpF8egj985jKlDR0fUUfmahHyrzykds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BjCjHqf6; arc=fail smtp.client-ip=52.101.67.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KJa9QfaOw/Q+8TbkvX3X4qqSsh0qKhGMJs6buwD/iFWpKG+nnx5POaExc3lLNusi/NsUC4+1G9YBkALNtA0C9Cv/KQObPXal3Q+H80hpqmeKXjIFo37AV59FCFSYmptEbnjcLK32aAd3L4sGYrMsnNgHIAUYDTm7pjtPTxgeP7V6MgmkmAhuDLYFjwTkVw88Ql9Ub6QTsKZPhujx6tkyK/JMVtGpf0j5I1g+RayASccsYlkqtQx3Lv6a6kw6Xv8r67jVKDemcqp5YXBi4OcfU8s8B5Y6RFU8bzOCpRXXd029w4m6asRX4FY9RIpskQLzpEWFXRhPguUJbuHMcrkNrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I+qJBZt98xE7R2r758KFVu+/Se829mtEnB9zGU3qXwk=;
 b=ejDMVLFxqfgnlXix6ziyQ49dGE2LSxzWsPdtZPy5vYUGciR8EBtRcuqlYXRnOeCS7hNzyasrAOEGSb1gbXcu6t3D7tShWfCa/C4Ku4YWaAth5EzwsMYlykqCEZUZ01bEcgqRRDBy+9qZxVtA/LPB51cfbqfOU89UdXMImOtPNAy3IvjTgQ6327dqI51QfhmbJLIPlY4od/lQGqV4I6vGFdt0o9Kh/NOFCjAhS2YGqdFK8LQWsMkW8UG0CMTyUln26jzRUPu9mlWgh6puBtikXFefpXpUoTRATa5JG5TgV31/4z93WqryK4irZ0YYpjeKjiFaBqdylcc3Ayn57YyhdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I+qJBZt98xE7R2r758KFVu+/Se829mtEnB9zGU3qXwk=;
 b=BjCjHqf6u/NlSM4n5sSalkGihEhYCI202Qof8Es+uxxoHv1WP43ioSW76hk1ZUZ2NJZe+BqxfuZZvUU17ACUo91n1Z8YBSUURaeykctAhTjx9HPvhQedM62gH/za/QBnx76ohXO2YDQlLGhiMftAhKscfHy37UTUPzU4+AixWkxYdbldaaMPbuCTkhV9zR7WZWnXxXFPpK9CN1M3UL5M3/SIzV8Cf3TSw8zuDvJ5KoZbKb1TiqW5AsGNKsFUwqWx5ho1Ksa52nlBlL7TbkLAIjCXj1fjZZWYbBC+vW5rfHkApHHnocK1sYWbehULyHJEEN/ASjrDYpCN+SNr1PWI2w==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB8078.eurprd04.prod.outlook.com (2603:10a6:102:1c1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23; Mon, 9 Sep
 2024 01:39:08 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7939.022; Mon, 9 Sep 2024
 01:39:08 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Frank Li <frank.li@nxp.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>
CC: "conor+dt@kernel.org" <conor+dt@kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "festevam@gmail.com" <festevam@gmail.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
Subject: RE: [PATCH v2 1/1] arm64: dts: imx93-9x9-qsb: add I3C overlay file
Thread-Topic: [PATCH v2 1/1] arm64: dts: imx93-9x9-qsb: add I3C overlay file
Thread-Index: AQHbAJl+3fRDl3ICMU6YjAR5B7ugTLJOsMtg
Date: Mon, 9 Sep 2024 01:39:07 +0000
Message-ID:
 <PAXPR04MB84591813A9947DF63696061D88992@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240906201501.2249242-1-Frank.Li@nxp.com>
In-Reply-To: <20240906201501.2249242-1-Frank.Li@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|PAXPR04MB8078:EE_
x-ms-office365-filtering-correlation-id: 2919756b-1a04-4818-8540-08dcd070326b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?s5oLJQS37xBdZDFGih3e+j1Snfck6744lKl3fb7nSC/+po9vy72oEvOm23pY?=
 =?us-ascii?Q?nBa9j9fEiEaRI23lEewW0GCHXj0/dKWpo662pYqbu8SR+j+fvx95lD7EUHLi?=
 =?us-ascii?Q?AsP4Am/MIiCRsKFDraxOx4h2ndsWJ9PM7JTxcX6G5xRq939GOa4mV/RvEMhw?=
 =?us-ascii?Q?bfeQdXz+Q43wOUEe2Mbke+V6FKzJJ1uipHngiwjlPjRO9FuCLK+Ixy6vNaCe?=
 =?us-ascii?Q?7ru8Kfx9fP2z9fYEFM8rFdNdBqF5jjTpw/XQdkMeLxRfO5mdg73pOz0NOshn?=
 =?us-ascii?Q?akbgOI5FvGPfQTrHbNmCQBuB+UTJB3DVfvH+5iVv628dChVi5dzYNGa5Fr47?=
 =?us-ascii?Q?iEEhIZCy+AMRI3I6D2R8m6kyB7HV7uRnIR829ruAh3zHVOviSXAveF6sZYQg?=
 =?us-ascii?Q?gtfIJQapTTHxcjMHwA0wRCnfetV7ZNe7eB24CYcTK0MSjMMUxviqZ6DeRg7n?=
 =?us-ascii?Q?A4xZKLBcmFtKSwaH201qbybXjDshbEe/1X2woiwB57HVUlVp8dKxAoL5lRQk?=
 =?us-ascii?Q?+ApoZOG7HYSfVsr6h4N10dB8Ppr9+LUFT/F3WJ6ppGRYXvk3GCdGo+K20SUR?=
 =?us-ascii?Q?Ulg3Wdj6mmg2+5+lpSKhY8ieV/mRRDBUA2MAG0rXdmvl0aHHT1u0HQsMhDcU?=
 =?us-ascii?Q?5FxJmVi0DdvN01xkUHsWuBHo2GiJk3Wz1YUST9jBLE4xLgaW5D5oktrbOqPa?=
 =?us-ascii?Q?fyma+g5P/LpB+X/R/MZJs909BfGNA2f2FsgZ+R1HoaTZWhbPr0a9/dzn5Swe?=
 =?us-ascii?Q?XEs4unDy6m3qlRMtudtKeazqEtBIOHdCBftbSqg8LXU88w7ynwE/PmKDspYc?=
 =?us-ascii?Q?5mP4dKuMMvGYzi7M7ZgcPmgLdRuXGKfnOxobKq1dXwpJHtkgFrg9IftnC+8a?=
 =?us-ascii?Q?ntq0UZbM51/qaOnt154cKsZqJ4fEx7jd+Dy3VvYlwPLrBkerNribqGstxb6M?=
 =?us-ascii?Q?K+gTUd7zBL+7E2vatZdYxAcqVaoefMGMAkG7q+rL3BEnCYOZ7SO7bpgJ0JMp?=
 =?us-ascii?Q?R1BrLl1OdqH2icO+KrgUOnkryNc7SEI3WmSGuDQ4cAk9CLy9Q6U6v8I9TfU9?=
 =?us-ascii?Q?rNwvHW4yXQ6z6/tat+Sd8mH0a7BO2Ppa8cB/hjgPQNi45/f4K2VIiB7G7cts?=
 =?us-ascii?Q?lUC4iEkQ8d+Mdy106yvCHHf4sGIiHqQmJr1bpez0vPfXevy9KRxeZQME8l+N?=
 =?us-ascii?Q?c8i/EOfvLGfC+9wBYgcITm8fg9VR8laBYKFR161i8awJP7pqSazJW3WDWDoO?=
 =?us-ascii?Q?9J/8WMLRlgwHfV76mcdl7M6vrN/cZR9SqtMexcHiyJfa+OALmlV4j4qgJIS1?=
 =?us-ascii?Q?SL+Ltv6sOqOvudgs87+PW6PSWQ6tomKyhD2OjCFYUlXp/+buo3zQkIbWrEAz?=
 =?us-ascii?Q?go/gyLiwGFV1ZL0pcQh+5THPbLhLKFjBUZ+qYWVXBZsItPNSKA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?48HTZUeDwyWvt8JNlTfld5xBKNE1imXPntpJFZocj3ySTCfPn9PwLbLnglHf?=
 =?us-ascii?Q?e61A2n+ngHyUoD+WGKYnh5PYy8PLbigBga00hmPaWnutRyn7470MrQrTizIN?=
 =?us-ascii?Q?cJwvf0lrs+Yabu3YwYni713IudA/5VXvHOzGNHcKTRc9qiEWluG6iaCdBuKS?=
 =?us-ascii?Q?ro8DxNQ7zhTibdw161bjB7EktzDEsT53+3E1IOIv+5FQPEBThPmZHVpmDwCj?=
 =?us-ascii?Q?oDIhjuVMVA6yObnb1urLgzsDls8Rr7JotHfCGoMOUOlrmvTymHC77qfpyuny?=
 =?us-ascii?Q?/O4U+iDKRrX5Qof1Kh24Za0iGQy0p2pax5CSUBLaYoUW4EHpOSVV9q0Soq7J?=
 =?us-ascii?Q?GbNwPvAPTtOFJD0NoEWL4f9Romlj5u0ErVv+8soSz1/vmNjit8BTEIIMVhyS?=
 =?us-ascii?Q?AdamqtKKgMLZ3J9AspcB2lGik9bYQnLhYJd5oomOgbXuHwlYPW67iIMK/moz?=
 =?us-ascii?Q?Zql7xI3QnkH/RSE2iq+mztb1YLkkekniiXwWB72KTDyjSP5uSBfujcBh1xGI?=
 =?us-ascii?Q?74Mbfi9eGj29wKg1Qg/QfZ5KqH/XX2xtaC2CPcqhbwRaz/0dy3G7wnvclF+w?=
 =?us-ascii?Q?D+jYs0+HpfSkTeBKp7mlaEJ1ZiHXIyY0it2RBqXE0/yPY8CfYsj0jfTgT7C6?=
 =?us-ascii?Q?0vomA/oCggC19bOTGFelf20iZdJfQ1+0yXcymc1gD6yD55MRfR7hP42HpacD?=
 =?us-ascii?Q?QBN+izonsyYT8Ayb0ctN9dosJVYz9fC5e6gMkuRRKL7XilFHVs/ETOZkJRNG?=
 =?us-ascii?Q?Ozl0JvWis1Y4l0e8u/XYEVKwxUbYNREW+CdNBpRQ0/dQQp+COUCwUNTLwj2X?=
 =?us-ascii?Q?bFGZKRS4Bce1hrfPI4h1sKB7g7AYA9fnQuyOxO8gfS3s2lpjzIEbiU1FkTub?=
 =?us-ascii?Q?1RKfVm4Xe0HZoC/vEixw2jvOlo4pXCcSfKYvfA3IROSEtaMm/7a0Ysqn8xYh?=
 =?us-ascii?Q?yQwoG72U+rHPHcvKQHebBwifWswX/sYs16ZZZILiih6lv3cjEepO1YkEH/UN?=
 =?us-ascii?Q?F1dN5C6fc/9tHunrF7ZvqBKwd2MUPtiZ6Oz0ZXUIiuXSMhCNqi2UxnvKkjUb?=
 =?us-ascii?Q?KOwCoBp45Gh48uke7e3IO8XEifxn0IExTNEONtPKWKS+aaDtSMN92k5keNJi?=
 =?us-ascii?Q?QdBA+knReGZsZVtoUWg+eyn12tW+NsX+eVRX/0qpHe89TDFifLZ4MjXxPzOx?=
 =?us-ascii?Q?8xDXOeWGIT/01bA88WNSOLU5JgwU+oG085ygyWcsqy8gaYsykWeZ6ZpPC0tW?=
 =?us-ascii?Q?dFPPT4LMRrTlsijomQmMNd7U6BJE9vxn+09MUuBcVIAsvLV7kiZlFbNS1tE+?=
 =?us-ascii?Q?kOSuV9dmC2OzawUeD81ZUF/9BeXOcKinOL0zFoPBcdkHsvyRxeXSy5aSeRxN?=
 =?us-ascii?Q?XWqjuXjV4R7ZGiZvjnmKqEdLcEzRMp/Cjp5fFNrJPr3toKu4f1r3OqfdXeaz?=
 =?us-ascii?Q?E1quvVJyMzzKBZSWTUTTJKZd4avwk0rbH1hxWD0RuoWjnca4ds3IK5a2e2lS?=
 =?us-ascii?Q?2Q0QtpQ6Y7TBT6mJ7DOKjCHuYEzuQeUlrzq6pfpwBy7fMQQi3BkGqarivxps?=
 =?us-ascii?Q?IxomeKQBljeIIqScNSQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2919756b-1a04-4818-8540-08dcd070326b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2024 01:39:08.0226
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m1p7/82OBBtY7sEC741E0ELzuNFiqZIYZ59Wm5ZbBcdWMu+hx944PbEPE0sFTQL5eNyGU/8zPlEvSwqdg+5L1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8078

> Subject: [PATCH v2 1/1] arm64: dts: imx93-9x9-qsb: add I3C overlay
> file
>=20
> Add an overlay file to enable I3C support on the i.MX93, replacing I2C1
> with I3C. I3C is compatible with I2C, but it has not yet been enabled in
> arm64's defconfig. This overlay allows users to conveniently utilize I3C
> on the imx93-9x9-qsb platform until I3C and its driver become more
> mature and ready for full switch to I3C.
>=20
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---

Reviewed-by: Peng Fan <peng.fan@nxp.com>

