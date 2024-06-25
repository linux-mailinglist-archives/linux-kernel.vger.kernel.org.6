Return-Path: <linux-kernel+bounces-228182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9048D915C01
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 04:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C250D1C214AE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 02:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373A731A60;
	Tue, 25 Jun 2024 02:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Xkev5/tt"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2082.outbound.protection.outlook.com [40.107.21.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7489F21A1C;
	Tue, 25 Jun 2024 02:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719281203; cv=fail; b=aYEFFY2XySKkaAIn76PgL+WqGaLiQSxophXcHd0Vi4vPwPPwF35t/o+xtY5Lnf1tkW5U8sorkYB11r/CVXGQZ1KD9XW6HSy0CLo7iAtwGpjQlwbNFO1M9xTs36RULI2ljiXUk96mml3LoDDRb8GLP+BYp6Ybnx1ABi2iw7rlszo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719281203; c=relaxed/simple;
	bh=Laxq8TT6pckX7nmdZKMzZ2dwSTbuGEzvmog3/jhaq5E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AD9nEsaF90M2i8YfE1lBJfNmYbDtgt3AM13Rs74pFbyoGjNlhxfQFIV5Ke/hibpC3X7zX2y62SPDv4llXJU36jsdms8YyS7DHryCoSnC+DwhjpQXhLDWIda0GhqFHYoh7ki+AawwVvz/UzXptiALcQTwuwjbJPuxotD6AcS+IDQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Xkev5/tt; arc=fail smtp.client-ip=40.107.21.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TIGz58num2XvcbkCxXCmDO9RMEPkZyOsl2lxlHz/AxWCLGWsCKA6jLHtQ8+VHGUMvEtC8vX0QKogH0qRK1sr8t/rAqcJ5yhBX0UhHmS9ZJJ17SmlONOQq9PTV6ittv01L3p6BoHrRImayNa6YxDe1ie5bDOybY4/9aZb36yFFB3+u0Hgshdwe7SdPxSEh/3fKwOU90r1r6jYjlBnwbz62K+4uptu5iwCJ2nixP7rcDR5qPOlq5NchVPnOdS3jwJ3ly9bRRHIA/sXF7ujQHXJXB9pLoEPco0+x7BLH0mBScWl0SVT3Me/moVAu5J+oGt4fWhq2nMgLGgealSeVmahbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Laxq8TT6pckX7nmdZKMzZ2dwSTbuGEzvmog3/jhaq5E=;
 b=gV+9XZf2vJLsMdiSfwUB+1lmkcHpxkVovai1VftAbxwVO1jLjiNREc9/+oNVYYj/74IBCGqGr/70iozK+6CZQR3ByD98GYKafDRUyOgcKiUre69YoTjhmDFO833huLwp4TWWmxj0Tp+1pweArPRGOuXtygZCGBAmQG8FRqZ8zjf6i0hZ4x1Pf32nxj0Pq4hpjXHQl1NmEf0rhBJaf0erEogmiBFvpPnnHDB0+ofc5DrqHgVB9n6/NIDfcZWX4Nqaep5ZE/7GTgh+6z+hF1ini6uZwD1WyttEk1M9HqdDszmm2NYh5HI+w9jNz/H2blIkoTLPUcT7Q16QDRN67biYWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Laxq8TT6pckX7nmdZKMzZ2dwSTbuGEzvmog3/jhaq5E=;
 b=Xkev5/ttpn+xEASxWDmlSOrMJMkmOveEPerJFaJ3ULNuJX73iLZNjOTPgySbRTyo7efDxk7qJGgkm0M3LTfYKB1KgmkVc5vo0zShQE8hnGYWb/Q9QtGJIU9vyuCTlPdED6di0xYV80vyXPu8xROF1+MpeFpVV/zLjIXdwIpP2S4=
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
 by PAXPR04MB8426.eurprd04.prod.outlook.com (2603:10a6:102:1ca::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Tue, 25 Jun
 2024 02:06:38 +0000
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256]) by AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256%4]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 02:06:37 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Pengfei Li <pengfei.li_1@nxp.com>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"abelvesa@kernel.org" <abelvesa@kernel.org>, "mturquette@baylibre.com"
	<mturquette@baylibre.com>, "sboyd@kernel.org" <sboyd@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	Jacky Bai <ping.bai@nxp.com>, Ye Li <ye.li@nxp.com>, Aisheng Dong
	<aisheng.dong@nxp.com>, Frank Li <frank.li@nxp.com>
CC: "kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] clk: imx93: Drop macro IMX93_CLK_END
Thread-Topic: [PATCH 1/2] clk: imx93: Drop macro IMX93_CLK_END
Thread-Index: AQHaxqICs0HdElmggEaM9UqDqnF2eLHXusAA
Date: Tue, 25 Jun 2024 02:06:37 +0000
Message-ID:
 <AM6PR04MB5941E4E7DD69D321BB45B65E88D52@AM6PR04MB5941.eurprd04.prod.outlook.com>
References: <20240625175147.94985-1-pengfei.li_1@nxp.com>
 <20240625175147.94985-2-pengfei.li_1@nxp.com>
In-Reply-To: <20240625175147.94985-2-pengfei.li_1@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB5941:EE_|PAXPR04MB8426:EE_
x-ms-office365-filtering-correlation-id: 7b4efb55-b1f4-4189-4c4a-08dc94bb7265
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230037|366013|1800799021|7416011|376011|921017|38070700015;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?JC+ZTxRaxHykh5SypLwrQsf01CvyfyebH89GtYrHwhlnWFk058yOnucg3TCo?=
 =?us-ascii?Q?cPzNa2weWCiQoKzd+2+6/3YOkYCaJxZ5nHsnWGIi55jh5WZat6s+FPT5C4Sw?=
 =?us-ascii?Q?RSBhzmkI8BmR0X0xna4wfLLdPebG/1xf04fpybTjP5NzkKrcb+D3sJt+7v5U?=
 =?us-ascii?Q?SBhJbunw7M3s68IUoGdtIbP2ndMjUVIGbAS22djN5sKPKwwU6JiKeri5/C6/?=
 =?us-ascii?Q?yMc1HBZueoEW+pI6MDQYllc/zR8QPH2BjyeOiaHJaU1bfDunNN1f0cogOYIh?=
 =?us-ascii?Q?7N+2b6nfQQc/orzX1JnxhyU35/zMo3ZscnwIIjjoTs74meyUprNTaoCHlU3x?=
 =?us-ascii?Q?iNh27TXQ00wR276gObGGy9oAGHXJTGd9pACGDokPYHxOWUaXxx2S29zl76jx?=
 =?us-ascii?Q?+Bp5jKHekKUvqX2EZqpc9gPKdja/9iH+g0M0OoChK/I2WSzdDCoLo/+k+G0d?=
 =?us-ascii?Q?TNt7ixt4+olXZZrngy0nNEnJm6uNsg5hiHSS2HtctnXReaOgz24PLtKABMxj?=
 =?us-ascii?Q?e0DTU088dYfCGal15yZco2nmaQI/OnUJpW+lVCw4st6zhRpWwD5Bq94BpVo+?=
 =?us-ascii?Q?XsLhQKG3XkG7M815onr63wDQLsPkflFLMH1Mbk1fixLdmaaF/J4I4cdJa062?=
 =?us-ascii?Q?TmxW5jwMJjQbZ00qYe6OLFUU1+Onu1E0Lwzcl+7OzWrMakRVlPUGXcteRO8I?=
 =?us-ascii?Q?FGOaRJgv1s79RRVPqV7/EYkU9W6n6uVKsuyjXeYKPzQsSS40FWQoP105eJOa?=
 =?us-ascii?Q?UCn2hiABy3P4/XpHlIVr0b8PJwx1rlukAdTNfiYul/ljBViQf8xg9zfxRLH0?=
 =?us-ascii?Q?gxG3s0UVg0Goaf+HZg4NrYiMyxof3ltdUq/1t4fOV5qEtVwWJW8J0oaDhykJ?=
 =?us-ascii?Q?lEwwxxB9y2QNSigkDxdmqTjrfTSXT9kBlD+sWSIucjIQrBtqF/IxnUi6VNWc?=
 =?us-ascii?Q?+k6SRXL29pOt+u4GNIOF/a0X99Rod0WoNbyplqgplSjyMVLgRuPUIoslrJgV?=
 =?us-ascii?Q?AZj15NheJqkk/QO3Kbbj75SuohbzM0auK+90Dgn+qLKk3ukPVSWVc9wbSs5R?=
 =?us-ascii?Q?MlE+blTuwPvty+yY/WjacJ6FnHU7uOGMTTgEC3AvGkTx/VgnGYJLIK7x9Op8?=
 =?us-ascii?Q?cT6lJKuNh7j+vx0lDoDaUnvOULW8LTyJT373tpe0DVAxc4MB55SDOMu+pqSX?=
 =?us-ascii?Q?nB5AW80BB7q5vUXk+TLVm1JYhOugtCYI5y5l3QaZqcAh/w7FnA3ziDN6oo0O?=
 =?us-ascii?Q?+pgWzmn2DMaV7SXMS/Joe75hAQxkZOwrEAEuhv3LeBuR5OMqKM3TwsSF5VUi?=
 =?us-ascii?Q?KsGZLumDGG94Q9Uv4YFGCdCp+mGPLzy+JMh7kiuGIW+EG5liYK6S+ApYDRZ2?=
 =?us-ascii?Q?HEUQdSW52D8tbkU35Elo+qQ+WQg4?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(1800799021)(7416011)(376011)(921017)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?8HdjljAfSPvPAdl/MiJAqDcMPEgBpiJaR2IllDtSQ0wzhmeoD2GHdWYCX4Av?=
 =?us-ascii?Q?GXQZtLdl23jB5kNpn8Hsz0Lkbo2IjLSfoiKIhaisATFBaCIBJaBdi71ega1u?=
 =?us-ascii?Q?jWh7BTI70BnJg90bsbSnpIFU84zpTumJXVCosrTznzz+KCskLhkGjlwRbHZN?=
 =?us-ascii?Q?g3PcQmcFvDJYSH+VC/aVAB9gES9XaWvi3H2ctRhwWiNwFu8DrjSdBdYcqIit?=
 =?us-ascii?Q?SbD/DQLowiJLOR6NBUKzn/EUv7jH4AEOuNf2cMLgL9urT5U5GZf4p0/+tpmF?=
 =?us-ascii?Q?yuTPVlDCcsIbrgGyfsUPMX/arGXxRyS1VpkrYuESBn0XZ3wrgfxSgur74B1p?=
 =?us-ascii?Q?xTTDpAwLsZ39FVHw+zjm6bOaYQqLisEcc4oxGTMkvAH6LRCkVCvIowE3XiJ8?=
 =?us-ascii?Q?1DoLASw8Eo8En8Gz/wzU9JLLU2XqFFqt+810OdAXmeuzBU8RUITHfuyK4Lln?=
 =?us-ascii?Q?vs5N5zTh7Tma9C8HWboY/l+ZWpC5PZ4CfW8q+7uQDG85rHYWbstsSZuRGv48?=
 =?us-ascii?Q?sIZsdyabqiCzFgeeNtB5w1ZZViX8GFhsUdl6my8V+Sv1igin24SVIrO05tcs?=
 =?us-ascii?Q?Q5XdUR9WfFkSwiwsrtYgtQ7U3nWsUbFqVIWDZ5NVmeuUNynNc3VTRosAS/mS?=
 =?us-ascii?Q?UUeKP7KNLY+hDvrts/8x0SmWLxP8QItxhFeq3XdXu4a6K8OIUIZtj8Pk4BVv?=
 =?us-ascii?Q?wfgcMcxaALlMqhiG7LHa0YH8Zl6sESxVWsYMJuvV+WVRAtH3zOky50YSebqw?=
 =?us-ascii?Q?EKCBMgrFDBq/oQqoxet7QKF/tB0vPMeWNe+zGARp3XPnoqzCJnGZuvrtFvKd?=
 =?us-ascii?Q?bQSATmM63BFIeLLMMORWzvLiS2IfKmDcPqePBWZdPlLog+5J8HZIuiPXjbQM?=
 =?us-ascii?Q?oE3tabn0aidosu1jNQV00zJirNcq4QYCL9EpeOQGwGJkVuxmaCT2RgKSfEoz?=
 =?us-ascii?Q?sysOBl2Uv/aXSs/3G1BM9Dj99s63YeHl/0is32ojup36eSO8iVSgXXiUM3BZ?=
 =?us-ascii?Q?wsliudcOYfrac+C15T7hSWuJXSOsSpm4lE3ZAtujW2JnyOi5n+pXEkANHZic?=
 =?us-ascii?Q?7QpkG5iUDFhGc4O8VqjteMhaMCM84cbos7plA/Td5CMfzWeecEHC7yPhSxY0?=
 =?us-ascii?Q?AHrStDVO+/3cMPvtd/ptxTKE7ONssupiftAuSbSR1soRl/w0tEaqoMbSIBkU?=
 =?us-ascii?Q?ZwTxMPJmkOEhqWqGdqJEaILzuUpqX5p+GWYWeO22cMBBVLwKlvBB0lMvt4Tq?=
 =?us-ascii?Q?NG9x/LeLKPeyPCyczUFwpm6kvOqti3VSzXZC5lxWohe9Nq59uLX8MBnfRlNB?=
 =?us-ascii?Q?2AET2jhMuNeJiY90ouevOChX6zxCase235jIoQw6zAXLEnwtmehXlpKksdod?=
 =?us-ascii?Q?B3hxB0uDjbVsI+9Ze8RCUfRjH9wiSYHCzOIM86HLJX/pViNOUo9vftrhd4sI?=
 =?us-ascii?Q?R0Pnpk9+H7XjQ+R5Egm+Cvt1mp15ev2z9tFURbjNh7EvQcC86F2anDdkK59H?=
 =?us-ascii?Q?+1sPUdLa33iiP5/9QaLyXP+1s/9xPd3pIf45GeWPgYYsh0kUP/R648Nft2Ye?=
 =?us-ascii?Q?fnqxEQ/OfAcsJJBMwhU=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5941.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b4efb55-b1f4-4189-4c4a-08dc94bb7265
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2024 02:06:37.8747
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W8h8fRvX1hRzfdE0usrm6n2gm5PMB34rMQBfYyhwqejj0CVpleW8vZajh3h+120SBDZK86fqYRpezrJnAybxbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8426

> Subject: [PATCH 1/2] clk: imx93: Drop macro IMX93_CLK_END
>=20
> IMX93_CLK_END was previously defined in imx93-clock.h to indicate
> the number of clocks, but it is not part of the ABI, so it should be
> dropped.
>=20
> Now, the driver gets the number of clks by querying the maximum
> index in the clk array. Due to the discontinuity in the definition of clk
> index, with some gaps present, the total count cannot be obtained by
> summing the array size.
>=20
> Signed-off-by: Pengfei Li <pengfei.li_1@nxp.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>

