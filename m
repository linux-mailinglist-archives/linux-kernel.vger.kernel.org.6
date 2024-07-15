Return-Path: <linux-kernel+bounces-252157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB17930F35
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 09:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E71B0280F5A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 07:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D22911836E4;
	Mon, 15 Jul 2024 07:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bqxid+ki"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011045.outbound.protection.outlook.com [52.101.70.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0B11836C6;
	Mon, 15 Jul 2024 07:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721030176; cv=fail; b=V4pLMliEflqN0kU+GurW1NYS7sGC2gYoLJBSodBFZ6oct0NMAAdhY6w4RWKV6DIYSVl0NFvfHo8IQzAEpiTmuRX0vVqI2c14FYcWkccGti5t+QVRdFwiWWKKw0yZwijW2lc1aBRexXxNy3V2q1CS82Kb+FQSJ7N2Ft7rCFdh/sg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721030176; c=relaxed/simple;
	bh=Qra1yiSO7F4yB0avBCaCgypMxxfFbDmlBewV8UbDq4w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IT+D7ZA2Jw/WViNR7npIrztguRuM345P9lyGkm2F27YPZLrit+0afWT3hf/qxWPGnCnQeOfXnzhqDboyVSEPlpngiKQLPhnwO9olcmQAg7P5vx36MqQUjGXa9gZOCg/upU5xSfS7wi0ULmC1mHRDSTAhNyoWtMmMx0uTISaQCtU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=bqxid+ki; arc=fail smtp.client-ip=52.101.70.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=inHY9w4yj5SgNu3xCsbWL+JQvRu78fk13/S53b2elUmKxFqmBqmEq96MvpR9MdwXg7bbXozEf95LGzme/aeKGQS5PBdT8GlnGA2ACY4XIS7c536e5e+0QwBwPT1cZ0LX89fvxlecQU9pWo+dgY8NhgZjPRVna5eyH6A9cHFbGoTSmX9QfRJy7v0Z7SNb/mEkLCJbBizX68x4HjoP5NCM5UaxbhiOk8mCXMrUakYtD5w6Y47ODv9RuYgrE19stQeqf5y+aahFhTCZ4L1b0vTU6YXeQebhHBbVOKF496U9gRKEB/CkrZaCmvRJLqSsD/M+0J1aUEzlOwcmQNjaID0lqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZcFg8NINmj4h5Ed167jGfN32qVZGb3aiKH7os4oAczQ=;
 b=LezapjSAqNfxZJBmy6FJifetoHXPHraDrR053wKMmWPbrIqizlYuljKSesSHN3iL3kYfceRp6MklbmrDQoIR1BD9eltW7ZuQuggC9tU0wrgk7sH0coxm/y0CUW5/t70a2tHOPo1+nrP44aPsL7DymBYDcP12DQbz8pIF5H2CIPThlDdCRX2ORZpKvwBpeZhlC0FDGsura7xpKiRDJlO3WcD7xkPWoL5ZLbOmJw4rvjASwQnfqmSRMgHETyf5WHQ5ysquesFgcn+7Ue7WewRV1C3xsOzzXIMsKqFOU2d+N8G26oZNKXyyVuYpllJongCIKebh7SfPkzIvvwdwarJ4nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZcFg8NINmj4h5Ed167jGfN32qVZGb3aiKH7os4oAczQ=;
 b=bqxid+kiu6609V2HHrIPxfvInPY3amph6ywMCJbdk1HZ6B5UP58txudkTlmZEpojXg3Crymp+j+C6AXY9JuPciUehLMtp6a2PciieWS6nYsjOaL5KD2rE1u2tlYmjobXdcOL7NfAS22tyYbFaz1RsAqyTJ7cPQqPN0s5GXlNQvw=
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by PAXPR04MB9138.eurprd04.prod.outlook.com (2603:10a6:102:22d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Mon, 15 Jul
 2024 07:56:10 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%3]) with mapi id 15.20.7762.027; Mon, 15 Jul 2024
 07:56:10 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
To: Rob Herring <robh@kernel.org>
CC: Jonathan Corbet <corbet@lwn.net>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [PATCH v5 2/5] dt-bindings: arm: fsl: add imx-se-fw
 binding doc
Thread-Topic: [EXT] Re: [PATCH v5 2/5] dt-bindings: arm: fsl: add imx-se-fw
 binding doc
Thread-Index: AQHa1CP/sfbwKvfpdE6YN2bMfeC3aLHzY3MAgAPbVAA=
Date: Mon, 15 Jul 2024 07:56:10 +0000
Message-ID:
 <AM9PR04MB8604BA0B01612B38D9282CF795A12@AM9PR04MB8604.eurprd04.prod.outlook.com>
References: <20240712-imx-se-if-v5-0-66a79903a872@nxp.com>
 <20240712-imx-se-if-v5-2-66a79903a872@nxp.com>
 <20240712180358.GA1286437-robh@kernel.org>
In-Reply-To: <20240712180358.GA1286437-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8604:EE_|PAXPR04MB9138:EE_
x-ms-office365-filtering-correlation-id: b8650948-838f-4621-4145-08dca4a3978a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?yqZ9w3btrI9fYfrk9dSUxQgSGBUjxVzUYZCUTeeZ3X3T+WaTpCiObML7pvQD?=
 =?us-ascii?Q?GAQ1250H3B47ScJ73HAStaEAEPjE9v+bXEPjIX28Ok0mUFajjM+/ahwa1OEe?=
 =?us-ascii?Q?bAGvBQoAXrNMczuSsc3eOaiMBzrCxQOPgTNfPQUe6IAPyMb3ayKL6sv8Vhel?=
 =?us-ascii?Q?f0bKP5pB+WX6/Nf0VfAjShCt/4kLFsFkiOiAPaxBhEKXt7mrI/d9LIteCPL0?=
 =?us-ascii?Q?OmoMbWeo5RVe/jyk94+0euYI7Z0W4hsQjZmBcMQUB0P0hqf9f9DeKT1+mjFn?=
 =?us-ascii?Q?PCnkqmg+XZMiiguuVp+zYuhSw2Wl0FpZoMec9oOp60tVUEhKoOxrtiTlNVfd?=
 =?us-ascii?Q?Q6Y6H1YhbKXib0o/KwqRoVWwXympYn4XSMat3DFWRr2l52u3M8kTGvnZGATu?=
 =?us-ascii?Q?zO02qV8xIYsTJqQt1C2raBkw8/EpLN93vTopKvWh1hhFzRZbbddlx5JGwamS?=
 =?us-ascii?Q?E7Te/lDzBzUACb78XOjPj9gkC/mekljC5kCHV0x+E4JulB1HtiLzcSsD6L3Q?=
 =?us-ascii?Q?tVgt5Nc0qf4DvWC98Eg56Pb7DT1A2tSed3aLKeR/ylqpdGYLbqYw7B+fRDU3?=
 =?us-ascii?Q?Bl1sPIk0zKcAggI1HC93K1c4N4/FaIouDr2d6YoPf4Su9hpsNHNkfbtfdw7B?=
 =?us-ascii?Q?P3DFCbFtT/t0lrOPAi21QjxuW81iO2jRmphZuj+MMNVhAYkDQQmBQ8rpgvz7?=
 =?us-ascii?Q?Htm3ngb62Ml7zekkKZOnwoF0dX4CYc7rnN6GjNciaMPOowhahUeD7NVF4LVw?=
 =?us-ascii?Q?AWpzIYEUAwI+wDa8jcEI1jGJAxIwA9mz+PyeUAlzYfoaVboWwarrt6ZeVpS6?=
 =?us-ascii?Q?nuLNXbrfofZDIcxIWmkecGaVQSYVwITWpQdm9sdfxqw2ZPy2Iz7dj4JqtQfI?=
 =?us-ascii?Q?yY0b92EKaVl7/HgU/6LJ5LEB1xan9GZg85WBJp7SFi2U3Z0GpfvCargzQy80?=
 =?us-ascii?Q?1y/EChNB+1bHXSXi3x0DCtsojBq8c6jhCAby68athumN+hobt68H6ZN224P+?=
 =?us-ascii?Q?oZtSFBFJpLEcmqoRHi9VenAbWKJACgg/v3x4xtfRQMYZkOVWCWM0lFFeo8ha?=
 =?us-ascii?Q?N7MnMuuI32CtI1lT5CcW16NNHDeLiZpWVmtjiemsW9D7aVH+QCgPW45eghFW?=
 =?us-ascii?Q?G0oUgwg4Rnvf2Bd6I1+vbBcaoPyZAec/k60PxHmsJMXusVrTYacwjVIkvwBS?=
 =?us-ascii?Q?AXr5LwEdi1ulUXPE5/t2T0HKbOGNAGwgUPk4s1j2+2nmBbXhz801Z6XqXEbA?=
 =?us-ascii?Q?FoiD2w5oQLdGwCV3Vc07mCiKMSxIpObLsxMdYHqfkf0mhMCEseTQElKNRpu1?=
 =?us-ascii?Q?DEe6UIwLdiERjUgxbnRqmW33jRhu+hvWVRWJRJ/q7cj4xZyv/SuGLZTPfcAq?=
 =?us-ascii?Q?xog1et5PcxKxBMrEbtJID1snLkjfKOW7PkFt/ITvIP4WVAfGng=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?/zBh09UvMu4lltL2ZVU8HmMjkeATQwQwjJM+8effyWxLUb/DbQZExlsXEpE3?=
 =?us-ascii?Q?hCgg4dYfUY5ntr2Di04Zc20kn+1r2HTz7C8Xspx3awnTf17bdUlCmy9K9H2k?=
 =?us-ascii?Q?djcxaMSkZKfvOhmuJHhjiR+BBX+tWtl6N+PvsVghNGCixXiMDT3qvpSbbYOR?=
 =?us-ascii?Q?u/oQ29imvBfuPod4g1sIac+bmEdgtsQr28LyhCTRKR/38+bctjo9ZO/C5E9U?=
 =?us-ascii?Q?EN2EzvwJ45BNF63GleioL3TJPTVjanzGgV/EcXVszn3Xzni7tDsvXkmGTzwW?=
 =?us-ascii?Q?7/3Cj5Ldx/Ndh5qqctwkLgQAfKc8x5Jbj1x7lORrezcnVf8hZffjU3lLgKx/?=
 =?us-ascii?Q?UxzsTp8RDTe8UMfcQBgcF0ddge15dj4/o7sJmL97EOyQs/4cJn8i0Pi6VIcc?=
 =?us-ascii?Q?8JHMpeJcPbgGjcuw8vv/BeDHpr62FyrDw9v4KQI+MOGu4EdVVWLw/t75PBGn?=
 =?us-ascii?Q?LDYMQoCyOhKoviP1nuqlCudyERdL0uV3cNMT2D2zyHZlkEMJ0HMJcTz6mSyd?=
 =?us-ascii?Q?QWF66PnyZNVh4BYKWJNxqTPcKHV9T/Aw4VZlLZSXBcTHD2RHK0MhIPBD+Sl4?=
 =?us-ascii?Q?PmgfkcK3kQ8pwpicxMI1EpY/l6jV7b98w1Gx+WEltI214dXAH8rJE+ZDEzfg?=
 =?us-ascii?Q?1FjubLaHqHcnP+6CalP/HOJOYWEMYsmDdHc9KllcetShR80uYe5C+1u+Tc4x?=
 =?us-ascii?Q?uQSdV0DrawhKFBGNjc9FCmh7CwUPfoxynqv89Jc4ZPewKuLpfoQ28tcJE8uN?=
 =?us-ascii?Q?rYSIGu/GHkGqaBptNikLX0lJbVZ6db3gJsYl8TncN3CT08ly/jUKvq2KYjwp?=
 =?us-ascii?Q?vcNp5/EnqGhLNAuxihrECkcV9K7Mwj0nHugFrkaZJ7xlW8Acrvw+2PXD+yi9?=
 =?us-ascii?Q?cKWD65yCKZifnVY9/W7Ov6IZ9Em5HgpytxBy26SbI+ccthJWtjwhS2Mn2M74?=
 =?us-ascii?Q?VNj/F/TbNQsu+/DZMR+xugc5Wu2jkzGzootMU1lC4XXeMFHISbXHFrN+k4WI?=
 =?us-ascii?Q?pbGScBFp706//WPUmRPaPQxI4InstKog5JZOTeOLCcDis3MEA7vlyZxD7Vff?=
 =?us-ascii?Q?jBgl7Jbd795UUjx5UjqE1vBvtPgfH87FJvbRH5ho5TMRQM6y+8VBaThrUvpj?=
 =?us-ascii?Q?K2TxZB+0smJ8OFasSI5R0RmimZuZDkiSZYAhZaufXhTIJ5wX/M66s/8dGbOz?=
 =?us-ascii?Q?EjDuQ4zHwUP7HkSSAQ4V+9NTTkhz90lPHvl5Hls/pR2jlJgn3r1y8+4NEc6/?=
 =?us-ascii?Q?etsgRCiB/hb51iwJ6MXZFIE/tFfGznHWqA0Zr5r7dZLvQvl7XJBJuhmpeAEO?=
 =?us-ascii?Q?Elfcai4ljVoZAoE9IB1VCvPvow2wDOQcJ6eK+uRZPeBIQuZTieHZIhcxWReI?=
 =?us-ascii?Q?GqXKW1xjcRaQuBOm8r6EWx6EA2sk+r7NlMQo7iZ2mJWDMteaFy43VG78hXUe?=
 =?us-ascii?Q?99xtd9aBGboDUEe7J7PoglQE+L+r4FaIprJx52gNFfp0/nQx0s/ECNcR3r9q?=
 =?us-ascii?Q?uNm+VD2DAl6efQETVqmCFy+v6G3+TsSh1qdzowUxnWIW61DoRxKNRSWWG0FA?=
 =?us-ascii?Q?USz2XyLwmC6v5K9AY2DXOhO/a9+jiSZPWsstqOG0?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b8650948-838f-4621-4145-08dca4a3978a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2024 07:56:10.8389
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RFXdktkF6NAQ+sdizHcRI5kUiysLpA9INeLG9Q/7Pj0iOm+4KauOUgHUkBl0r+Z+ZzbFbsT54JHmvv0ABcYCAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9138



> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Friday, July 12, 2024 11:34 PM
> To: Pankaj Gupta <pankaj.gupta@nxp.com>
> Cc: Jonathan Corbet <corbet@lwn.net>; Krzysztof Kozlowski
> <krzk+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>; Shawn Guo
> <shawnguo@kernel.org>; Sascha Hauer <s.hauer@pengutronix.de>;
> Pengutronix Kernel Team <kernel@pengutronix.de>; Fabio Estevam
> <festevam@gmail.com>; linux-doc@vger.kernel.org; linux-
> kernel@vger.kernel.org; devicetree@vger.kernel.org; imx@lists.linux.dev;
> linux-arm-kernel@lists.infradead.org
> Subject: [EXT] Re: [PATCH v5 2/5] dt-bindings: arm: fsl: add imx-se-fw bi=
nding
> doc
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>=20
>=20
> On Fri, Jul 12, 2024 at 11:49:57AM +0530, Pankaj Gupta wrote:
> > The NXP security hardware IP(s) like: i.MX EdgeLock Enclave, V2X etc.,
> > creates an embedded secure enclave within the SoC boundary to enable
> > features like:
> > - HSM
> > - SHE
> > - V2X
> >
> > Secure-Enclave(s) communication interface are typically via message
> > unit, i.e., based on mailbox linux kernel driver. This driver enables
> > communication ensuring well defined message sequence protocol between
> > Application Core and enclave's firmware.
> >
> > Driver configures multiple misc-device on the MU, for multiple
> > user-space applications, to be able to communicate over single MU.
> >
> > It exists on some i.MX processors. e.g. i.MX8ULP, i.MX93 etc.
> >
> > Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> > ---
> >  .../devicetree/bindings/firmware/fsl,imx-se.yaml   | 111
> +++++++++++++++++++++
> >  1 file changed, 111 insertions(+)
> >
> > diff --git
> > a/Documentation/devicetree/bindings/firmware/fsl,imx-se.yaml
> > b/Documentation/devicetree/bindings/firmware/fsl,imx-se.yaml
> > new file mode 100644
> > index 000000000000..bd99505de6e6
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/firmware/fsl,imx-se.yaml
> > @@ -0,0 +1,111 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> > +---
> > +$id:
> >
> +https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdevi
> > +cetree.org%2Fschemas%2Ffirmware%2Ffsl%2Cimx-
> se.yaml%23&data=3D05%7C02%7
> >
> +Cpankaj.gupta%40nxp.com%7Cf1bfd437edfe4dcc6c0b08dca29d0434%7C6
> 86ea1d3
> >
> +bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638564042462565488%7CUn
> known%7CTWF
> >
> +pbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJ
> XVCI6
> >
> +Mn0%3D%7C0%7C%7C%7C&sdata=3DUxa8Cb3W5imjH%2FZGUEaGGO4VYFO
> oeVwzJmeFd6SbJ
> > +TU%3D&reserved=3D0
> > +$schema:
> >
> +https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fdevi
> > +cetree.org%2Fmeta-
> schemas%2Fcore.yaml%23&data=3D05%7C02%7Cpankaj.gupta%
> >
> +40nxp.com%7Cf1bfd437edfe4dcc6c0b08dca29d0434%7C686ea1d3bc2b4c
> 6fa92cd9
> >
> +9c5c301635%7C0%7C0%7C638564042462575447%7CUnknown%7CTWF
> pbGZsb3d8eyJWI
> >
> +joiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7
> C0%7C%
> >
> +7C%7C&sdata=3DbhF5HZ655JjWQCaTu3BP5rd1kXZLSb8PKNsle7aWRq4%3D&
> reserved=3D0
> > +
> > +title: NXP i.MX HW Secure Enclave(s) EdgeLock Enclave
> > +
> > +maintainers:
> > +  - Pankaj Gupta <pankaj.gupta@nxp.com>
> > +
> > +description: |
> > +  NXP's SoC may contain one or multiple embedded secure-enclave HW
> > +  IP(s) like i.MX EdgeLock Enclave, V2X etc. These NXP's HW IP(s)
> > +  enables features like
> > +    - Hardware Security Module (HSM),
> > +    - Security Hardware Extension (SHE), and
> > +    - Vehicular to Anything (V2X)
> > +
> > +  Communication interface to the secure-enclaves is based on the
> > + messaging unit(s).
> > +
> > +properties:
> > +  $nodename:
> > +    pattern: "firmware@[0-9a-f]+$"
> > +
> > +  compatible:
> > +    enum:
> > +      - fsl,imx8ulp-se
> > +      - fsl,imx93-se
> > +      - fsl,imx95-se
> > +
> > +  reg:
> > +    maxItems: 1
> > +    description: Identifier of the communication interface to secure-e=
nclave.
>=20
> I don't understand what this is. How does someone determine what the valu=
e
> should be? Are there constraints on the values?

I will remove this. This was added to differentiate between multiple firmwa=
re nodes.

In case of the i.MX95 SoC, which has multiple firmware nodes, I proposed to=
 make the following changes in .dtsi file:
        firmware@0 {
                compatible =3D "fsl,imx95-se-fw";
                mbox-names =3D "tx", "rx";
                mboxes =3D <&elemu3 0 0>,
                         <&elemu3 1 0>;
        };

        firmware@1 {
                compatible =3D "fsl,imx95-se-fw";
                mbox-names =3D "tx", "rx";
                mboxes =3D <&elemu4 0 0>,
                         <&elemu4 1 0>;
        };

>=20
> > +
> > +  mboxes:
> > +    items:
> > +      - description: mailbox phandle to send message to se firmware
>=20
> "mailbox phandle to " is redundant. Drop.
>=20
Accepted.

> > +      - description: mailbox phandle to receive message from se
> > + firmware
> > +
> > +  mbox-names:
> > +    description: two names are to be listed, one for rx and other one =
for tx.
> > +      The name can be any of the below list.
>=20
> I think this can be dropped. The schema says all this.
>=20
Accepted.
Complete description will be removed"

> > +    items:
> > +      - const: tx
> > +      - const: rx
> > +
> > +  memory-region:
> > +    items:
> > +      - description: The phandle to the reserved external memory, the =
only
> > +          accessible memoryregion to secure enclave(SE) firmware. It i=
s an
> > +          optional property based on compatible.
> > +          (see bindings/reserved-memory/reserved-memory.txt)
>=20
> Drop. 'maxItems: 1' is sufficient.
Accepted.
>=20
> > +
> > +  sram:
> > +    items:
> > +      - description: It is an optional property based on compatible.
>=20
> Drop. 'maxItems: 1' is sufficient.
>=20
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - mboxes
> > +  - mbox-names
> > +
> > +allOf:
> > +  # memory-region
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - fsl,imx8ulp-se
> > +              - fsl,imx93-se
> > +    then:
> > +      required:
> > +        - memory-region
> > +    else:
> > +      properties:
> > +        memory-region: false
> > +
> > +  # sram
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            enum:
> > +              - fsl,imx8ulp-se
> > +    then:
> > +      required:
> > +        - sram
> > +
> > +    else:
> > +      properties:
> > +        sram: false
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    firmware {
> > +      #address-cells =3D <1>;
> > +      #size-cells =3D <0>;
> > +      firmware@0 {
> > +        compatible =3D "fsl,imx95-se";
> > +        reg =3D <0x0>;
> > +        mboxes =3D <&ele_mu0 0 0>, <&ele_mu0 1 0>;
> > +        mbox-names =3D "tx", "rx";
> > +      };
> > +    };
> > +...
> >
> > --
> > 2.34.1
> >

