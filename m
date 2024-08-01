Return-Path: <linux-kernel+bounces-270920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C980944716
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 10:53:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96931B232E8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 08:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63CDA4503A;
	Thu,  1 Aug 2024 08:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="L0kq0p77"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013040.outbound.protection.outlook.com [52.101.67.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B200157469;
	Thu,  1 Aug 2024 08:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722502380; cv=fail; b=QiA8Q6rPg53bCcHBRudr7Z06P2vQAOXMRR5DiiP8j89VBqzLnYpgwWfPuVHBouDq2saHwBdWtD1MAhdupqGVBENY2f5A6NJzB7viGHWlFphoMqUt2Emwz+wbbhiJotRqfr1I7/jdgyP3SGL3No9tiJqL4tUk/XBR3UFByDWfOH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722502380; c=relaxed/simple;
	bh=R3Pezq4ABxmx+xxzvPTXSJpuN9jy7viWMIyhsqZiMzk=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iyglOnkLgeBpEg8OCaK0TyMkq5UXqUrjfuyMDsNDkJwpOT3QwOV/aKdQLVN0L0XVKTUlTZFAlmT8FI43jcfBPc/AlQ/mFwkKGVF+8OFbFvdGIaP7Ubm3hTBAG+gqfD1OxAtbZBx5mJ5l47rszbBR+IzddXbk82BAONEBVlfRF9M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=L0kq0p77; arc=fail smtp.client-ip=52.101.67.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a4NY7pd0SyxDWdflyeYGgJhNRcv4TGNrcYLrpKcNmUi641Lxor7zhhwkXQwQSKfFirj6J4LrlXFMrYCuPOPa1VEb8/gCBOauSmX5yptU2PQDJH317ob2n2O+wXgvHYIVrgXO8nYwU4n2Jl7i9QNXpJreNk13pjNE9AeTfCooV63fX5YvSelvZqRiXjgFOVf3EIc+u6a74iW6XnBNoIzP+VRiAsyNlgLqvw1etGtggEEqWReSReNNYYTHdqdjf1ju0LmToU1hZmwmVkhPqyeuiTvKgmm87C29mt+4daqJEMphan2aWMZZrYIGwzT7DLtZDT+9I7CilWmFGj1Swxz8iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tMfNYxgtSb30xw5b1xOHvJs2OQthkywyIBw+/BK1mT8=;
 b=hcx8Gk2MIhOa+LU4fLJl7W17UjdR5Y9N7C+1qb3JKDVP6ylhF3rIkKpl7dxYnJinKuSYWzMorX80gID3yYdFsfpFG96IPW8/XOUj0JPGrKH8ftzHsEXc34IQI6FlMXdNsbdLboiJo/cP4sXb4NbSh4/TdNuubuc74z4vvysbRbMmPsaQUGfS+s7iCiT97Ilx1vWauuJ9zqHiUmd8ax1Ls+4cc5ncIeKxHqZM2gpWZ2vrq4X3oA3Owcc01KdnfxZbBPJ9jujz2s2kBjxqksBBqcPm+JSiHbCUgAe1lnpyTvs6ku9IZB6JjRmkUDeP6u/+XhaOaUA1s65fK42ttMJvFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tMfNYxgtSb30xw5b1xOHvJs2OQthkywyIBw+/BK1mT8=;
 b=L0kq0p77+Z00p6VsdvnClUSPY7ClgKYKVw+swSU8PHAbO4DUQ7UD2N3CyjLbzVlwQI7z/rJrrXF7zarIP8NmliRu4u9tPf1lZdz4sC0ztLyZ/iJqDIqHwBJAfY2H13b7ZFVjv1BIscx5x0/pkJrtfXSBVDgSyLGRY7hESkrHo45BaWf+33KdDcSOp5ewnth2Ib+d9/mfYuWLjbmNf2cwlHsc/TkmeFsEm2gymSeIUY0uLu2kywxMVNyr8T1/L0PiRfTApVBU9m38reM71Dx+Nq1yAce0D2uW0+vCGwjkLpAn+erpAKLcRP1b1BtTrZo/nDCmd9XjCiXM6MSkV4gINg==
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by AM8PR04MB7298.eurprd04.prod.outlook.com (2603:10a6:20b:1df::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Thu, 1 Aug
 2024 08:52:54 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%4]) with mapi id 15.20.7784.020; Thu, 1 Aug 2024
 08:52:48 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
To: Conor Dooley <conor@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Rob Herring <robh+dt@kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [PATCH v6 2/5] dt-bindings: arm: fsl: add imx-se-fw
 binding doc
Thread-Topic: [EXT] Re: [PATCH v6 2/5] dt-bindings: arm: fsl: add imx-se-fw
 binding doc
Thread-Index:
 AQHa2/NU1sJztJxAoEWO7LSlO6AOebIC9paAgADLMzCAAJnWAIABTu8QgABaVYCAAPz18IAAhwuAgAFte+CACTDVIA==
Date: Thu, 1 Aug 2024 08:52:48 +0000
Message-ID:
 <AM9PR04MB8604087289C777F0F0C7597B95B22@AM9PR04MB8604.eurprd04.prod.outlook.com>
References: <20240722-imx-se-if-v6-0-ee26a87b824a@nxp.com>
 <20240722-imx-se-if-v6-2-ee26a87b824a@nxp.com>
 <20240722-popper-comfort-7538ea70c77b@spud>
 <AM9PR04MB8604123E065315093347F66C95A92@AM9PR04MB8604.eurprd04.prod.outlook.com>
 <20240723-smitten-shower-1d15c0f3cf97@spud>
 <AM9PR04MB86043E4B4B2FB206BF9223C695AA2@AM9PR04MB8604.eurprd04.prod.outlook.com>
 <20240724-huddling-neatly-88813c0b1f1d@spud>
 <DU2PR04MB85990A0AB8AF8ABFCDA4CBD995AB2@DU2PR04MB8599.eurprd04.prod.outlook.com>
 <20240725-filled-outscore-24149588d958@spud>
 <AM9PR04MB8604E23D34326C32B76D6F2995B42@AM9PR04MB8604.eurprd04.prod.outlook.com>
In-Reply-To:
 <AM9PR04MB8604E23D34326C32B76D6F2995B42@AM9PR04MB8604.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8604:EE_|AM8PR04MB7298:EE_
x-ms-office365-filtering-correlation-id: d6b983ef-eba1-4392-7812-08dcb20751ba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Nwo/mC6E7QkAs/wGESyJ7vffDlWHkCrBBC/unYV+njDQQhyIB3cD72GvfmPf?=
 =?us-ascii?Q?2zrDKcT3tFR9Y43+s3D0z5SGUP293gGaCd2k2ToMANeYHk8OKzXJJWnu3QNJ?=
 =?us-ascii?Q?JtEJf/npDOXSJg0IJh541/m6fW5broSZmhZnBUQDMuBrsdYwkQqC/jptBXxd?=
 =?us-ascii?Q?WSN4QMNYTSnbdC7Gq4GTPdvpvdea42CiPGjJpbzRsbJflhyXdhadTZ20Q4HL?=
 =?us-ascii?Q?o0IjCAX4nzBkveFffzSee6VSzzNEI/BT7ChCufiCiUHjnQd4KqDiqZfZHqxm?=
 =?us-ascii?Q?WMVY5Dldlo6KiW6a9SAdTc9niT6GQMcdOYUiPWcy0u+qDfckTmO5YO61Qfns?=
 =?us-ascii?Q?9aU5X6/jDKLNW5KsPYH4JSOi/LUgSsqzDJhP9gQtKggU8h03GW3OKxAcSl6g?=
 =?us-ascii?Q?7q1QlDqAOsyIy2CGREaI/Ghcl5zCORoMezClXKY/N20H7b/IspEcRQe2BHrf?=
 =?us-ascii?Q?Ymafc/sVyntIvqvIVxH2BIHeK5n2MsvTRDGV3lg1KJcOd8AGAEHm91WsJEBs?=
 =?us-ascii?Q?8lIwmLV0UnL0op/3EsHGXFtDpyQmkIAXiJHhoX79gePanmvw0ZdbgpmIbCcB?=
 =?us-ascii?Q?2A+3ssGpuCNGUBUsIsVIOuk9skP8+H4ZP07vsnfFqmA42GMesSIyCdRuopvM?=
 =?us-ascii?Q?maQpW9OiZug7tsKHGkGytOBAMuiMdy0bEyRg7zICPz0llQyQV3+LXveNk+r2?=
 =?us-ascii?Q?G7LwPIirwUW7NDoecH2fqktd1fSsnPfXqD6J97HRaS5SDxXB/WxMCG8qoYQG?=
 =?us-ascii?Q?poKkBoL1YENgJHD3X/H+ZHIawrluCQgEM/nftho/sF9DfaNYdSiTJ9AvO7dT?=
 =?us-ascii?Q?y5XQ+gUS0sbYUxJQ+HrMA3VJ9IZK1WQej4jXdLTyylFRgfpMKXcZESwtbGeb?=
 =?us-ascii?Q?i57dHEtCsgVFOV+No7VptAD7dSSLRRzFzAYduDVpwEAfxSMUeav3QPznbg/w?=
 =?us-ascii?Q?bBVMCL5aQnluh9iAcUc8BihFlo66nsr3Ta9cJdqvYy+DfFKtonx+UcIHjimP?=
 =?us-ascii?Q?wijl3f6VLHCDOuvPKK2Pk+oFTScpJfyuzROzPF2i+DpgrrqXlr6B42uN1TOL?=
 =?us-ascii?Q?XLTikxij2Ly2qR4+dwI7Qf3fiAhgqBVIDVIkRlOjVp5AbDaZnP3QHw7cWd8o?=
 =?us-ascii?Q?gdkaLok47WdFtGSzNO6rlpahDSVAn8UpJY09Kc7U6XtlI4yUCar7gaGQNCU/?=
 =?us-ascii?Q?l3yLFsw8EgrpTf2xjTerZmnoKijLDcE5+zLgK7DDNExoA1foyrPWpw+4WODO?=
 =?us-ascii?Q?0du3gSN7jA4fFFc496y2y0JhPGWf1CxWLCz86irMtfdWaTqD5xO6JE43kN8z?=
 =?us-ascii?Q?Kh/ShDptbTDbpgMNgyQQ7cPyzWcMelex6pKj6Heo0tdL6W2bWONzpXnCylar?=
 =?us-ascii?Q?MlEycPltIF8HiSMVflVs1kbYbkiiGVnmH3Kd5Ti0XcHhH531pegWBJ7Sqx1w?=
 =?us-ascii?Q?fQxsKByXcRY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?3WVoDiguUJTTj4kXZcVY7aLEWvLZ9W1GJXJ3jXE5vVU9bV4LYFsAe3su4gnf?=
 =?us-ascii?Q?osxlT/Wr4BdWQ6MpGIkd8JUyk+W+Q/W9sK4qPw5N0IaMF4Q9toCsAxchjUj3?=
 =?us-ascii?Q?hHgTYR6/L2+sfWMenhAr5LBYedWKuRMATXotSFkVyfGC8TmJ8Uydsb/8XIzW?=
 =?us-ascii?Q?nYhixRujTxnw6NlHWyixhKEdYJgLogl9MN9wjojcmwBaF42LYA/FJJ/cJxFB?=
 =?us-ascii?Q?JoeZRUB8YTu7vSMxl0EyPC26f3Eaonz/ZQsPLKWMUfYqKMq/LE/OslWbV8h5?=
 =?us-ascii?Q?OBsBerPLQgq/jmEcS7BEF/K22lwqiBTb5/FRMPHuxk4RvWuaKyP8sYvGpwTw?=
 =?us-ascii?Q?9Z0rUal9f/OH2K6JHE9wPPx7ZKeOJBWwPwfDA2Q89PK+oWENGdO/HVyxM1EC?=
 =?us-ascii?Q?+UpRAHYJVdtXH56wTWevuhZ3taN5NSAU0rJ6AfdZ0OiHmvOWaYJZGNOsvRSz?=
 =?us-ascii?Q?+4BpLXBymeYeDDX8bz0hIhzrDd2sb8YJMACMWGooBaBbGORKYiuZrxnpuEmE?=
 =?us-ascii?Q?H02gOQuGqERgt2lAwyBRtkpJNqn2CDEFe6NwgFznTfHvRfMFiUIGi2bFBulG?=
 =?us-ascii?Q?oGlBf0qprFIzjzz2oaMfXzPlzcpr0gg/5NIyenUp3ci47WSMiouRyb2IwSSJ?=
 =?us-ascii?Q?YHzY6dn+mqfPlPkBD26STZhvRGQToRka8ffsFJqYT1AjhFZvpU1apyw1aR60?=
 =?us-ascii?Q?xlRGKGpUU1C1oAgim9Ux9PV2apKBSfEMa+SML4S6RHNu5EzN3qZfXRi/YavW?=
 =?us-ascii?Q?5pfDEu5lDoT4Atat3R5hb0j0rIS5p9tes8K0RpSqQh6pZ62htMh5G/oQYQxA?=
 =?us-ascii?Q?l7SB887n/eO9IYENwnpDhViBk4Zgsivg3GyyCl19anZljUN/qVyb9BAn/GCW?=
 =?us-ascii?Q?XmAv55LTHHsfOMoJ/fEseQrHm+MLOXXXPNaHmZXyXx7Jn0TFn/ZiZlllVBmX?=
 =?us-ascii?Q?BzNOV/jfZBHQ1XuZGzJU1lXQbwpKkIbTi/eGNU+6LhmbPoPi7SVnas8Taz1G?=
 =?us-ascii?Q?VEgULBEZfALzNkoHPuVThJb4WcdPu7kYW9DJvNiSivkBdUQt7xGMsv9cLQbd?=
 =?us-ascii?Q?4UKn0SYB8i6Vll3cymS8CRF7slysbTzqgnWiUiQzU3IlSAmZcWS6L3tHg06u?=
 =?us-ascii?Q?B7Pubmt57Jf3zBBnjKpT73vOAb5OAypDxq+P+5c7ZvpzIjWlH4o25TKbUbeY?=
 =?us-ascii?Q?tbIQW2iqqpG9ZtMapgUhbkYKCWHWrfYM7H8h3mNJ7swsS5J1JS+NHF9Dy9S/?=
 =?us-ascii?Q?O5UnEp28z0pzeRH3LvLAIXvllI/OP5nO9dr6mE27yPVzyPD62pPvBRRYFsH1?=
 =?us-ascii?Q?7y9eMmbg3bbFnjkiovEDMHZOoV0B6ua61+zXmNmlqqlu8DLyG/5+7p5A71hl?=
 =?us-ascii?Q?QJra9MTBHX+RS/WigGhXHe3l8MVTPfyIoPWVdx6CpYjVPwHpSWb6k3LRPTQO?=
 =?us-ascii?Q?Ul58aJsGPiWzzSfag56+b3UGgaVI2polGXU2A46I1rtkxV24XU5WP1JtrGHI?=
 =?us-ascii?Q?ZFAMR+6wQKQT379Qy+RnRgx5aKJ78WpSVRa/tu0dsXdrsPn1dMgURlMo6OtB?=
 =?us-ascii?Q?TT/FWc3YJ7OjpnlMyocbB2MKaaHvYcthK8ab4e6D?=
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
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8604.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6b983ef-eba1-4392-7812-08dcb20751ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2024 08:52:48.4936
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +ybTKj7Tdu6tcbnwQGZ3UgMVzFilzHXMv8Zdp1woaAG1Rb0nT3lZ7RaKccxgZycNqQ28HuJX69fhZ0BmvRYWHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7298



> -----Original Message-----
> From: Pankaj Gupta
> Sent: Friday, July 26, 2024 6:06 PM
> To: Conor Dooley <conor@kernel.org>
> Cc: Jonathan Corbet <corbet@lwn.net>; Rob Herring <robh@kernel.org>;
> Krzysztof Kozlowski <krzk+dt@kernel.org>; Conor Dooley
> <conor+dt@kernel.org>; Shawn Guo <shawnguo@kernel.org>; Sascha Hauer
> <s.hauer@pengutronix.de>; Pengutronix Kernel Team
> <kernel@pengutronix.de>; Fabio Estevam <festevam@gmail.com>; Rob
> Herring <robh+dt@kernel.org>; linux-doc@vger.kernel.org; linux-
> kernel@vger.kernel.org; devicetree@vger.kernel.org; imx@lists.linux.dev;
> linux-arm-kernel@lists.infradead.org
> Subject: RE: [EXT] Re: [PATCH v6 2/5] dt-bindings: arm: fsl: add imx-se-f=
w
> binding doc
>=20
>=20
>=20
> > -----Original Message-----
> > From: Conor Dooley <conor@kernel.org>
> > Sent: Thursday, July 25, 2024 8:09 PM
> > To: Pankaj Gupta <pankaj.gupta@nxp.com>
> > Cc: Jonathan Corbet <corbet@lwn.net>; Rob Herring <robh@kernel.org>;
> > Krzysztof Kozlowski <krzk+dt@kernel.org>; Conor Dooley
> > <conor+dt@kernel.org>; Shawn Guo <shawnguo@kernel.org>; Sascha Hauer
> > <s.hauer@pengutronix.de>; Pengutronix Kernel Team
> > <kernel@pengutronix.de>; Fabio Estevam <festevam@gmail.com>; Rob
> > Herring <robh+dt@kernel.org>; linux-doc@vger.kernel.org; linux-
> > kernel@vger.kernel.org; devicetree@vger.kernel.org;
> > imx@lists.linux.dev; linux-arm-kernel@lists.infradead.org
> > Subject: Re: [EXT] Re: [PATCH v6 2/5] dt-bindings: arm: fsl: add
> > imx-se-fw binding doc
> >
> > On Thu, Jul 25, 2024 at 07:06:30AM +0000, Pankaj Gupta wrote:
> > >
> > >
> > > > -----Original Message-----
> > > > From: Conor Dooley <conor@kernel.org>
> > > > Sent: Wednesday, July 24, 2024 9:00 PM
> > > > To: Pankaj Gupta <pankaj.gupta@nxp.com>
> > > > Cc: Jonathan Corbet <corbet@lwn.net>; Rob Herring
> > > > <robh@kernel.org>; Krzysztof Kozlowski <krzk+dt@kernel.org>; Conor
> > > > Dooley <conor+dt@kernel.org>; Shawn Guo <shawnguo@kernel.org>;
> > > > Sascha
> > Hauer
> > > > <s.hauer@pengutronix.de>; Pengutronix Kernel Team
> > > > <kernel@pengutronix.de>; Fabio Estevam <festevam@gmail.com>; Rob
> > > > Herring <robh+dt@kernel.org>; linux-doc@vger.kernel.org; linux-
> > > > kernel@vger.kernel.org; devicetree@vger.kernel.org;
> > > > imx@lists.linux.dev; linux-arm-kernel@lists.infradead.org
> > > > Subject: Re: [EXT] Re: [PATCH v6 2/5] dt-bindings: arm: fsl: add
> > > > imx-se-fw binding doc
> >
> > For the third time, please fix your mail client so it stops inserting t=
his garbage.
> >
> > > >
> > > > On Wed, Jul 24, 2024 at 11:02:21AM +0000, Pankaj Gupta wrote:
> > > > >
> > > > >
> > > > > > -----Original Message-----
> > > > > > From: Conor Dooley <conor@kernel.org>
> > > > > > Sent: Tuesday, July 23, 2024 7:38 PM
> > > > > > To: Pankaj Gupta <pankaj.gupta@nxp.com>
> > > > > > Cc: Jonathan Corbet <corbet@lwn.net>; Rob Herring
> > > > > > <robh@kernel.org>; Krzysztof Kozlowski <krzk+dt@kernel.org>;
> > > > > > Conor Dooley <conor+dt@kernel.org>; Shawn Guo
> > > > > > <shawnguo@kernel.org>; Sascha
> > > > Hauer
> > > > > > <s.hauer@pengutronix.de>; Pengutronix Kernel Team
> > > > > > <kernel@pengutronix.de>; Fabio Estevam <festevam@gmail.com>;
> > Rob
> > > > > > Herring <robh+dt@kernel.org>; linux-doc@vger.kernel.org;
> > > > > > linux- kernel@vger.kernel.org; devicetree@vger.kernel.org;
> > > > > > imx@lists.linux.dev; linux-arm-kernel@lists.infradead.org
> > > > > > Subject: Re: [EXT] Re: [PATCH v6 2/5] dt-bindings: arm: fsl:
> > > > > > add imx-se-fw binding doc
> > > >
> > > > Please fix this ^
> > > >
> > > > > > On Tue, Jul 23, 2024 at 09:28:31AM +0000, Pankaj Gupta wrote:
> > > > > > >
> > > > > > > > -----Original Message-----
> > > > > > > > From: Conor Dooley <conor@kernel.org>
> > > > > > > > Sent: Monday, July 22, 2024 10:20 PM
> > > > > > > > To: Pankaj Gupta <pankaj.gupta@nxp.com>
> > > > > > > > Cc: Jonathan Corbet <corbet@lwn.net>; Rob Herring
> > > > > > > > <robh@kernel.org>; Krzysztof Kozlowski
> > > > > > > > <krzk+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>;
> > > > > > > > Shawn Guo <shawnguo@kernel.org>; Sascha
> > > > > > Hauer
> > > > > > > > <s.hauer@pengutronix.de>; Pengutronix Kernel Team
> > > > > > > > <kernel@pengutronix.de>; Fabio Estevam
> > > > > > > > <festevam@gmail.com>; Rob Herring <robh+dt@kernel.org>;
> > > > > > > > linux-doc@vger.kernel.org;
> > > > > > > > linux- kernel@vger.kernel.org; devicetree@vger.kernel.org;
> > > > > > > > imx@lists.linux.dev; linux-arm-kernel@lists.infradead.org
> > > > > > > > Subject: [EXT] Re: [PATCH v6 2/5] dt-bindings: arm: fsl:
> > > > > > > > add imx-se-fw binding doc
> > > > > >
> > > > > > Please fix this ^
> > > > > >
> > > > > > > >
> > > > > > > > On Mon, Jul 22, 2024 at 10:21:37AM +0530, Pankaj Gupta wrot=
e:
> > > > > In case of imx8ulp, there is a single node.
> > > > > Having a same node name for both parent and child, is bit strange=
.
> > > > > firmware {
> > > > > 	firmware {
> > > > > 	};
> > > > > };
> > > > >
> > > > > Request you to allow to re-evaluate this point.
> > > >
> > > > I dunno, it's all firmware so I don't really get why it is so stran=
ge!
> > > > Can you remind me again why it is inside a parent node to begin wit=
h?
> > >
> > > Three type of security firmware(s): HSM, V2X-SHE, V2X-HSM, are
> > > running at
> > the cores dedicated to the each different secure-enclave hardware IP(s)=
.
> > > Each firmware receives the message to act and response back with the
> > completed act.
> > > This message exchanges happens through the Message-Unit hardware
> > interface.
> > > There could be multiple MU for multiple security firmware, that
> > > would be
> > used for respective message exchanges.
> > >
> > > This node defines the details of each such MU interface.
> > >
> > > Reason to put under firmware:
> > > 	Since this node specifies interface details between kernel and
> > firmware, it was put under parent "firmware {".
> > > 	I am not sure if this reason is correct enough to begin with.
> > >
> > > Thanks for allowing to revisit.
> > >
> > > I will make the change to whatever you finalize now. Thanks.
> >
> > I'm sorry, I still don't understand why you have the parent node. It
> > seems pointless to me, and this new node could be added at the top leve=
l.
> Lately, I got this feedback in NXP internal as well.
>=20
> Accepted. Will add it at the top level.
> Thanks.
>=20
> Help with the suggestion for the node name:
> 1. enclave-interface
> 	For multiple nodes, it will be:
> 	enclave-interface-0
> 	enclave-interface-1
> 	enclave-interface-2
> 2. secure-enclave
> 	For multiple nodes, it will be:
> 	secure-enclave-0
> 	secure-enclave-1
> 	secure-enclave-3
>=20
> Or share any other suggested word(s).
> Thanks.

Will use "secure-enclave" as the node name, in the v7 patch.
Will post the V7 patch-set, by end of the next week.

Please reply if anyone think otherwise.

Thanks.

