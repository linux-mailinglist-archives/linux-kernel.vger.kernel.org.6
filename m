Return-Path: <linux-kernel+bounces-184935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F018CAE09
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 14:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF9C528234B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 12:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71EB4763F7;
	Tue, 21 May 2024 12:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="e5f2zmrJ"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2047.outbound.protection.outlook.com [40.107.8.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891EF1CD20;
	Tue, 21 May 2024 12:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716293851; cv=fail; b=Cggs7dRSMp6opewrv1B4hstVECkCkXwaOxmqz/f84+mHT0WWkm8mSucP+jtRWKIfB1HHmlVUWbxLZVz1ye5A7zn6IcQ6/drhDzKf4vCXJp0p2oyAdpRIxqFNMB2mgxs3L1qbGxu323gNZbvdWZOrbjXDH0KqLHyyu0fWUPx5iUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716293851; c=relaxed/simple;
	bh=m5bYF/IaqVcualdGtnBaUOvicgL+2H+XEMqYrUbteg4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FoIiG2cYgfgwXcgyQ6NSdUGPviJREH3XZ5OQ0gt/dWvDwd57ABTN4ykGB0UVIvsfMeuCTLlUqa+Hjy1b+6o+29TO69IkJi/Msl7kSDbyxIHrt41ZqkSBGVGErLDkNeBgFEoCbH19+1KBx0o8HGL+Dp4br40Zc3PatABhHCX9wWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=e5f2zmrJ; arc=fail smtp.client-ip=40.107.8.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IU3ksDrPmO6AWAWC8W/RPLp+sM5+xuvsgTP39CnnBmhDsuCZ8UEwRv9ty7AuzLyWt+VBvTT+X/zJyczFfCyOAFm+lV07dnmpR3tXB/z8n1MID3wcGrzOWDdtYhBpwTkkdrwJZMtIR6rdf1zi6hN9OsPacXufO4o9two9JFYP4UXiVcuRwV/Oxs0WxXx37lvbUBhSKcqv4dgvUoFpyPOHi8x93OoFCvVZw/3eckcriBPk77MwjWVmI7LNw/LNYDKP+mDr1IsxpO+dN4j0CLknkeDX6okNfhUPJ8Rag5SCBIrJDxz87YnZrnuCOpf6/6+rnk1vYExlKXppBrgW+qtHKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dtuezbG3gFn5alwpCGI0WL65+B1hYBbJ5/GBDU/2knw=;
 b=nBIdsnQvL1foWea9dpWuimsKR8d39cEgsM3Gs192UvXlCvWre8boZWeQ1PMeR2TX3vR/nLTF91YUUe/y7nKXBGTCoU5sgBCEMqbkr/85lFdshytYX2hz0aYwkN3If4+OIQ//0iyuKcVvnlryFw8CH8V+z5z2a6P78z7m88pIKDKvMos3mfDBuzNcuNBr9X+hUQAy6ntr53OERPPGLSPLjKr10MHgGRnsqzzPYdKiWatAkdMhX4V5wAXDPyM1DdZtJjIgCjmBCfCdHh2k5fHaBv/AA4tusysmG7KEn/poD7Yl0rf7yGRF0lbSmNpLLMZffUQ1H2Wz4BufDjKp9U6P6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dtuezbG3gFn5alwpCGI0WL65+B1hYBbJ5/GBDU/2knw=;
 b=e5f2zmrJbokwJbKGNKnJq7kCVfmH1+MyNG92Em/QilDzrajk8VPAhsNhCK3xWFEiZGuViCMPkVAjOcaDFWXUoaSP8R1BEiarW0gsjC6YJc9OxaSwRKKhM9RuNMPvnEyt8kRkYPM639OE4YUIC0BIwd8PKtDKKEnsg0g1RiP+0/s=
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by PAXPR04MB8830.eurprd04.prod.outlook.com (2603:10a6:102:20d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 21 May
 2024 12:17:25 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%4]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 12:17:25 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
To: Rob Herring <robh@kernel.org>
CC: Jonathan Corbet <corbet@lwn.net>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
	<festevam@gmail.com>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [PATCH 2/4] dt-bindings: arm: fsl: add imx-se-fw
 binding doc
Thread-Topic: [EXT] Re: [PATCH 2/4] dt-bindings: arm: fsl: add imx-se-fw
 binding doc
Thread-Index: AQHaot4r694Tqoi2OkK/Xnn0LWMP+LGQ5hKAgAQVonCADK8+YA==
Date: Tue, 21 May 2024 12:17:25 +0000
Message-ID:
 <AM9PR04MB8604ED4A84CADEC17130347E95EA2@AM9PR04MB8604.eurprd04.prod.outlook.com>
References: <20240510-imx-se-if-v1-0-27c5a674916d@nxp.com>
 <20240510-imx-se-if-v1-2-27c5a674916d@nxp.com>
 <20240510200903.GA628922-robh@kernel.org>
 <AM9PR04MB8604479439A3723792B865EE95E22@AM9PR04MB8604.eurprd04.prod.outlook.com>
In-Reply-To:
 <AM9PR04MB8604479439A3723792B865EE95E22@AM9PR04MB8604.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8604:EE_|PAXPR04MB8830:EE_
x-ms-office365-filtering-correlation-id: c85e5d9d-5f22-45af-9265-08dc798ff959
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|7416005|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?CdMperPAi374BLj7iPzKKl7oa9Saveum3EmAhcCEqw7vzx4uObzdVskckY89?=
 =?us-ascii?Q?MAJEXj055kvAlmvViAcoSQPUSOfGeRuKXGODWbTlhwgIZG+zSNEmm/97+jIY?=
 =?us-ascii?Q?gNY6ccwyXrNsI3mO86Yd6lC7jxinB51dG5UoMcB1+TnulDvTtNlyAiKvXf73?=
 =?us-ascii?Q?bTH5vk3j8Yji9DGZrODjkbP403OKaCWv/zrvabIVNo9I6dOqC/Q555lks54e?=
 =?us-ascii?Q?mf2iWdrVDChee3X2z4ynvy/n8OQNgyF/676l4bIpVnWrl+zqjVLKH4NJ2vEU?=
 =?us-ascii?Q?qEcTzms0e9iGvAh5BE1+9tAvCVkpEUtQHgeHcrbWlLKBraTj+++JtcgKf0U6?=
 =?us-ascii?Q?3N5vXsW11SmJCzXU6Qiy+imvT2aSbXGJmwJ7xPrjB8yBVT7TW4F93sVry4OQ?=
 =?us-ascii?Q?FGs4pK96sfU8dZLNJ3Ao+Xvu2cc4u1bDxnJSmgdr+eoAfqho7MU9yKKyLXOf?=
 =?us-ascii?Q?KfT3iZx6DM7otelcWXXJNcgc/fWnuyctmoCRhUQ6gkmMF404SqcDjYuN9mVq?=
 =?us-ascii?Q?ikDmBVn8xajQga7H7sNljCcl7svrrpbuyzK6tOmw1exz/MfWb28zBqpqS+p2?=
 =?us-ascii?Q?nnG3xtLybTw8psM0sb8w4SAU6JUPkVXUgfnV4Jyydgw+Buqm49fordzqJ/xR?=
 =?us-ascii?Q?xeMrt+KcesqP/2725Fh2YZK2ISQRrODkFzXjAZGzKa3a9K4Cv+ON3Yvo2/c7?=
 =?us-ascii?Q?Og2Gl+IWMQHvBZzFSwcB4o0UQFOxkcD/GHJ6IOxoyyMpG7AEvlwV7j7dnVss?=
 =?us-ascii?Q?JoKcw2R0kniWpSQQyF/D5I68nx5unZeiJzB2Yi0LezIRRCNOfRURvMyfobwA?=
 =?us-ascii?Q?VBlStKgKXOhOYFliJPrO5C3zbHSWXsbTuFs3YisWk3bVpgrrNOT1ICHIOTvc?=
 =?us-ascii?Q?mj+WHodxA9nV/UOcMciSVieWOhiRsxpNxvTWCZRTY8BfocePQCKPhQfmiq0I?=
 =?us-ascii?Q?YQ5rZ1t2iKOIpbKwmdpM+JRlfTm80KUHCh7lPXtYwgyMAbNwV8EQ/D9l+rdQ?=
 =?us-ascii?Q?UtJGdGHLTiwGpztCn4JgqMaVQkqDlrejMizKmZXWISOUh8tTWKwmN/sm7/pI?=
 =?us-ascii?Q?KqbQWmNB4q3SW3otGVAGAyomtOLApFe2FUccP1Exy6s9qGtOS+RGX/cFdf+k?=
 =?us-ascii?Q?rqLNq6PfRNHNrCpjRXUcnlP/Iv9Q9s979busNABVIV5Pwc7kbSVEozSy5SmS?=
 =?us-ascii?Q?EFZzDUsePNM2f2pJ5+7dSqvyAmYbR5OhkUmZ0ZqYX/UFp52rPO6udtTGZErN?=
 =?us-ascii?Q?NZbCcXYB0/Bi1UOZ0l0iJ/ugdB6wKKLEY4w2hU5gsBK4VcvLsg06i/Gm3V+u?=
 =?us-ascii?Q?n32UMvx24dX9sr9btZjcLOMu5R44kOLPpKdMnEpRocwggg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?TOUHS91a/K2zUejlz+TKwgAGyyqFwLP1loTE7sRF1KK2YtBMPMGUAK9Zl0Zh?=
 =?us-ascii?Q?w4eKhj+sR1ipOGn/xWEjdQRGl7fzgDAzSrL8b1FLiQcymgThcDSxNqZssMWW?=
 =?us-ascii?Q?BoktoAujEo/tmhqALGRtiJ1o+aBNVg7mhn7LUJ6dGyrMX7CVcdN4ddSumk/U?=
 =?us-ascii?Q?KM80X+sJ4wHjsvjmX7kxIu3WGUTXHPstXtPDj09DJg93m/QFHHPSZASi5T0O?=
 =?us-ascii?Q?z4qK9+5wg/FugBrhS57YoU4uKcgjDewOtdiv6FirOtF+vuHQgFP2JTuSn0oT?=
 =?us-ascii?Q?lvEgRjgnnucyvCaaCeHTf2jYMXSvyqsdjrBDDmilPnQ1kPXAI1zThwVpd7Z+?=
 =?us-ascii?Q?bmYJGHnDL95l/CNeS3EMqRzCRd84tRkEfDMwuTiFEQVV/l2YI0/62+DOY2nl?=
 =?us-ascii?Q?yLVbGCErsQPSIy6VfJV+sLSB6R0yWj8ecnotRhH0o71Ankss2IaXwxE8NLgi?=
 =?us-ascii?Q?70lG22PWhlJcQJRgL7awxuKfASmBbokjBcRisp9rfTWu9YhIeyd5ZHwB3Qgz?=
 =?us-ascii?Q?TZHsDX/D5cNeACL2Z2u9moKdvH/LCbLIlxs1ByKYKpNjhh0mlynCXXol/dah?=
 =?us-ascii?Q?yMUtnpEWhEPjrGZpfMEHJOEkFxF7M7MWNtgf+oQiFgjflSTOFlt7huqJSbQq?=
 =?us-ascii?Q?9logvpEencc2p6NG4UwDeYD7GXpX7xd+bsZ/AJEBRO9msoitnPw0K8Veu/rd?=
 =?us-ascii?Q?z9HYyb3QvoxU27cD6g07SgjaIER1MSLWiVxS8IWIvnZS6ECcKY3KyEaa1QY0?=
 =?us-ascii?Q?SHxtK2yGvlCEO5lHvfrqBdukovazLSwHdDMDQNoMtcD5vigkpIwLnAaBwSnL?=
 =?us-ascii?Q?0nEh7HDmQjhiXgN81X3ExxP4VI/4fBrt9k/eVvrxu+nPk1feebxfASpZsVEl?=
 =?us-ascii?Q?gfAQ4HiPyxGk+YCh0pGQbuKdjpN7LdfD2I1mXr60Y1vI5bYLL2aKuL+GZXag?=
 =?us-ascii?Q?ZBZGbEWzNysmZNmoI2UQHcboTzyfUgovr01Ubj3T5r+z145Fkb/ztvlZBxjG?=
 =?us-ascii?Q?UTePembPSRyg4CTCit+Xlm9Jm2ChmuIcsRSzcw5TxZmqlwyptOYo0dXa6Qgn?=
 =?us-ascii?Q?HAowTIxVFQtOHPyY8NO28MIFbVUrJC/0Wf77a8wB7GMhEJGwPpR9oqq2PjZ2?=
 =?us-ascii?Q?q/MdUku5Bs1JrwdmsFb0vdKr4gMqmgHm4utemabToU3fMvQrIlSoMqQsYIBK?=
 =?us-ascii?Q?WEfwk0P2yCGkrc53/Fm9GB09/6+jxlcY1ItLL141zh+IllIbLh0nm4SgoAEF?=
 =?us-ascii?Q?dQM3FGRVJwPaS/bZ2qC/4s6OcZlgp5qDc09mKVJBIPgAULwSk7dMTqYuN8Em?=
 =?us-ascii?Q?wW++Pwg45CL1+5sRExGdFE58pJYBlEdWJW8WbYM+KqVx2TYfZA8Ma7VHDH/B?=
 =?us-ascii?Q?6E3DNneUBefJZHurBG0H4fRw5j62W1EHSLJ0QCniOizhFYuAPcNGZ4VzE4W8?=
 =?us-ascii?Q?iHImjFlWxPfE2u4kmHIWVEyVMROJYYurzFhLBjsFbeTey+H5kQ18yJ7IGz5K?=
 =?us-ascii?Q?Yjgsa+mXhoa1GyKucQCt9AhI4E3UkpQ8en7aICEjis1D+509exaxXFdQB7Xn?=
 =?us-ascii?Q?WBDQEsp7KUDpckophUa/8UhKAe6t8K5PvBhJdH3E?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c85e5d9d-5f22-45af-9265-08dc798ff959
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2024 12:17:25.0288
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8YP4u8+AtCk8RXIUIVSN0q44n8nV5kcAz21Z9pKhtC4M7VQ2kun0J/3rIy8UCFX1+/x32VCCFT7M1J7XC6WJ0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8830



> -----Original Message-----
> From: Pankaj Gupta
> Sent: Monday, May 13, 2024 9:07 PM
> To: Rob Herring <robh@kernel.org>
> Cc: Jonathan Corbet <corbet@lwn.net>; Krzysztof Kozlowski
> <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley <conor+dt@kernel.org>;
> Shawn Guo <shawnguo@kernel.org>; Sascha Hauer
> <s.hauer@pengutronix.de>; Pengutronix Kernel Team
> <kernel@pengutronix.de>; Fabio Estevam <festevam@gmail.com>; linux-
> doc@vger.kernel.org; linux-kernel@vger.kernel.org;
> devicetree@vger.kernel.org; imx@lists.linux.dev; linux-arm-
> kernel@lists.infradead.org
> Subject: RE: [EXT] Re: [PATCH 2/4] dt-bindings: arm: fsl: add imx-se-fw b=
inding
> doc
>=20
>=20
>=20
> > -----Original Message-----
> > From: Rob Herring <robh@kernel.org>
> > Sent: Saturday, May 11, 2024 1:39 AM
> > To: Pankaj Gupta <pankaj.gupta@nxp.com>
> > Cc: Jonathan Corbet <corbet@lwn.net>; Krzysztof Kozlowski
> > <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley
> > <conor+dt@kernel.org>; Shawn Guo <shawnguo@kernel.org>; Sascha Hauer
> > <s.hauer@pengutronix.de>; Pengutronix Kernel Team
> > <kernel@pengutronix.de>; Fabio Estevam <festevam@gmail.com>; linux-
> > doc@vger.kernel.org; linux-kernel@vger.kernel.org;
> > devicetree@vger.kernel.org; imx@lists.linux.dev; linux-arm-
> > kernel@lists.infradead.org
> > Subject: [EXT] Re: [PATCH 2/4] dt-bindings: arm: fsl: add imx-se-fw
> > binding doc
> >
> > Caution: This is an external email. Please take care when clicking
> > links or opening attachments. When in doubt, report the message using
> > the 'Report this email' button
> >
> >
> > On Fri, May 10, 2024 at 06:57:28PM +0530, Pankaj Gupta wrote:
> > > The NXP security hardware IP(s) like: i.MX EdgeLock Enclave, V2X
> > > etc., creates an embedded secure enclave within the SoC boundary to
> > > enable features like:
> > > - HSM
> > > - SHE
> > > - V2X
> > >
> > > Secure-Enclave(s) communication interface are typically via message
> > > unit, i.e., based on mailbox linux kernel driver. This driver
> > > enables communication ensuring well defined message sequence
> > > protocol between Application Core and enclave's firmware.
> > >
> > > Driver configures multiple misc-device on the MU, for multiple
> > > user-space applications, to be able to communicate over single MU.
> > >
> > > It exists on some i.MX processors. e.g. i.MX8ULP, i.MX93 etc.
> > >
> > > Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> > > ---
> > >  .../devicetree/bindings/firmware/fsl,imx-se.yaml   | 186
> > +++++++++++++++++++++
> > >  1 file changed, 186 insertions(+)
> > >
> > > diff --git
> > > a/Documentation/devicetree/bindings/firmware/fsl,imx-se.yaml
> > > b/Documentation/devicetree/bindings/firmware/fsl,imx-se.yaml
> > > new file mode 100644
> > > index 000000000000..a858ef6965cb
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/firmware/fsl,imx-se.yaml
> > > @@ -0,0 +1,186 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> > > +---
> > > +$id:
> > > +https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fd=
e
> > > +vi
> > > +cetree.org%2Fschemas%2Ffirmware%2Ffsl%2Cimx-
> > se.yaml%23&data=3D05%7C02%7
> > >
> >
> +Cpankaj.gupta%40nxp.com%7C2c17789530e9431069b308dc712d0e47%7C
> > 686ea1d3
> > >
> >
> +bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638509685520936926%7CUnkn
> > own%7CTWF
> > >
> >
> +pbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJX
> > VCI6
> > >
> >
> +Mn0%3D%7C0%7C%7C%7C&sdata=3DRwof3k3K1OWimcI5ApRMiyvD%2FPXgk
> > b%2BRWrvx76J
> > > +YBtw%3D&reserved=3D0
> > > +$schema:
> > > +https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fd=
e
> > > +vi
> > > +cetree.org%2Fmeta-
> > schemas%2Fcore.yaml%23&data=3D05%7C02%7Cpankaj.gupta%
> > >
> >
> +40nxp.com%7C2c17789530e9431069b308dc712d0e47%7C686ea1d3bc2b4c
> > 6fa92cd9
> > >
> >
> +9c5c301635%7C0%7C0%7C638509685520944809%7CUnknown%7CTWFpb
> > GZsb3d8eyJWI
> > >
> >
> +joiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7
> > C0%7C%
> > >
> >
> +7C%7C&sdata=3Daile3WnYE69fuJHvAOXQARlqLV9roZDuDK63fCj2ZTE%3D&res
> > erved=3D0
> > > +
> > > +title: NXP i.MX HW Secure Enclave(s) EdgeLock Enclave
> > > +
> > > +maintainers:
> > > +  - Pankaj Gupta <pankaj.gupta@nxp.com>
> > > +
> > > +description: |
> > > +  NXP's SoC may contain one or multiple embedded secure-enclave HW
> > > +  IP(s) like i.MX EdgeLock Enclave, V2X etc. These NXP's HW IP(s)
> > > +  enables features like
> > > +    - Hardware Security Module (HSM),
> > > +    - Security Hardware Extension (SHE), and
> > > +    - Vehicular to Anything (V2X)
> > > +
> > > +  Communication interface to the secure-enclaves is based on the
> > > + messaging unit(s).
> > > +
> > > +properties:
> > > +  '#address-cells':
> > > +    const: 1
> > > +
> > > +  '#size-cells':
> > > +    const: 0
> > > +
> > > +  compatible:
> > > +    enum:
> > > +      - fsl,imx8ulp-ele
> > > +      - fsl,imx93-ele
> >
> > You basically have 0 properties in the parent node. What's the point of=
 it?
> > Either just get rid of it and define the child nodes independently or
> > make the parent contain all the resources.
> >

Making the parent contains all the properties:

+               ele-if@0 {
+                        compatible =3D "fsl,imx8ulp-ele";
+                        reg =3D <0x0>;
+                        mbox-names =3D "tx", "rx";
+                        mboxes =3D <&s4muap 0 0>, <&s4muap 1 0>;
+                        sram =3D <&sram0>;
+                };

Will this be fine? Kindly suggest.
Thanks.

> > > +
> > > +patternProperties:
> > > +  "^[0-9a-z]*-if@[0-9]+$":
> >
> > unit-addresses are hex.
> Accepted=20


>=20
> >
> > > +    type: object
> > > +    description:
> > > +      Communication interface to secure-enclave node, that defines
> > hardware
> > > +      properties to required to establish the communication. There c=
an be
> > > +      multiple interfaces to the same secure-enclave. Each interface=
 is
> > > +      enumerated with reg property. It optionally defines properties
> > > +      depending on the compatible string and interface enum identifi=
er.
> > > +
> > > +    properties:
> > > +      reg:
> > > +        maxItems: 1
> > > +        description: Identifier of the communication interface to
> > > + secure-
> > enclave.
> >
> > What are the identifiers based on?
> Identifier is used to identify a particular secure enclave interface, wit=
hin the
> multiple secure enclave interfaces under same compatible string.
>=20
> Secure enclave interface is the combination of:
> - messaging unit (hardware), and
> - memory constraint applicable to a particular interface.
>=20
> > Is the value significant to s/w? Kind of looks like you just made up in=
dices.
>=20
> For the below example:
>     v2x {
>       compatible =3D "fsl,imx95-v2x";
>       #address-cells =3D <1>;
>       #size-cells =3D <0>;
>=20
>       v2x-if@0 { // if it is not @0, then what identifier to be used to i=
dentify a
> particular node.
>         reg =3D <0x0>;
>         mboxes =3D <&v2x_mu 0 0>, <&v2x_mu 1 0>;
>         mbox-names =3D "tx", "rx";
>       };
>       v2x-if@1 {
>         reg =3D <0x1>;
>         mboxes =3D <&v2x_mu6 0 0>, <&v2x_mu6 1 0>;
>         mbox-names =3D "txdb", "rxdb";
>       };
>       v2x-if@2 {
>         reg =3D <0x2>;
>         mboxes =3D <&v2x_mu7 0 0>, <&v2x_mu7 1 0>;
>         mbox-names =3D "tx", "rx";
>       };
>     };
> s/w needs to differentiate one node from another node, for the same
> compatible string for the SoC.
>=20
> >
> > How many child nodes do you have? Is it fixed per SoC?
> It is fixed for a particular SoC.
> While number of child nodes varies from one SoC to another SoC.
>=20
> >
> > > +
> > > +      mboxes:
> > > +        description: contain a list of phandles to mailboxes.
> > > +        items:
> > > +          - description: Specify the mailbox used to send message
> > > + to se
> > firmware
> > > +          - description: Specify the mailbox used to receive
> > > + message from se firmware
> > > +
> > > +      mbox-names:
> > > +        items:
> > > +          - const: tx
> > > +          - const: rx
> > > +          - const: txdb
> > > +          - const: rxdb
> > > +        minItems: 2
> > > +
> > > +      memory-region:
> > > +        description: contains a list of phandles to reserved externa=
l memory.
> > > +        items:
> > > +          - description: It is used by secure-enclave firmware. It i=
s an optional
> > > +              property based on compatible and identifier to
> > > + communication
> > interface.
> > > +              (see bindings/reserved-memory/reserved-memory.txt)
> > > +
> > > +      sram:
> > > +        description: contains a list of phandles to sram.
> > > +        $ref: /schemas/types.yaml#/definitions/phandle-array
> > > +        items:
> > > +          - description: Phandle to the device SRAM. It is an option=
al property
> > > +              based on compatible and identifier to communication in=
terface.
> > > +
> > > +    required:
> > > +      - reg
> > > +      - mboxes
> > > +      - mbox-names
> > > +
> > > +allOf:
> > > +  # memory-region
> > > +  - if:
> > > +      properties:
> > > +        compatible:
> > > +          contains:
> > > +            enum:
> > > +              - fsl,imx8ulp-ele
> > > +              - fsl,imx93-ele
> >
> > What else would they contain? Those are the only compatibles defined he=
re.
>=20
> It will have multiple child nodes, but fixed number of child node for a
> particular SoC.
>=20
> >
> > > +    then:
> > > +      patternProperties:
> > > +        "^[0-9a-z]*-if@[0-9]+$":
> > > +          allOf:
> > > +            - if:
> >
> > These conditionals are hard to follow. Probably a sign some of this
> > needs to be separate or simplified.
> I am ready to separate and simplify.
> Please help by sharing an example on how to go about this change.
> Probably an example that helps me understand your point and then will sta=
rt
> to work on this comment.
> It is highly appreciated. Thanks.
>=20
> >
> > > +                properties:
> > > +                  reg:
> > > +                    items:
> > > +                      - enum:
> > > +                          - 0
> > > +              then:
> > > +                required:
> > > +                  - memory-region
> > > +              else:
> > > +                not:
> > > +                  required:
> > > +                    - memory-region  # sram
> > > +  - if:
> > > +      properties:
> > > +        compatible:
> > > +          contains:
> > > +            enum:
> > > +              - fsl,imx8ulp-ele
> > > +    then:
> > > +      patternProperties:
> > > +        "^[0-9a-z]*-if@[0-9]+$":
> > > +          allOf:
> > > +            - if:
> > > +                properties:
> > > +                  reg:
> > > +                    items:
> > > +                      - enum:
> > > +                          - 0
> > > +              then:
> > > +                required:
> > > +                  - sram
> > > +              else:
> > > +                not:
> > > +                  required:
> > > +                    - sram
> > > +
> > > +additionalProperties: false

