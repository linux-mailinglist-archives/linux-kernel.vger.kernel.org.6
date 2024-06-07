Return-Path: <linux-kernel+bounces-205409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E5168FFB1E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 07:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DA7E287BDB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 05:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC461BC4F;
	Fri,  7 Jun 2024 05:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="N9PEJAk3"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2061.outbound.protection.outlook.com [40.107.249.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD375482EF;
	Fri,  7 Jun 2024 05:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717736407; cv=fail; b=txnM/7bSYZUm87vm1CLhuO1GnrXbXr4z6yzmt+V/0P4EOIo9X3xkDWS5XoJ042Bxp36RmKECIN4NJB50NJ/yOurphwfUUFqlDaGpRkoJwg8iHundf572GdyB2xMcmWhkE+xQ2avRGtwJcOfrMlrhMEXXY97+M8HsNRh/HpbtvLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717736407; c=relaxed/simple;
	bh=QdRg9wodwTrBc8STnj67XdiarQUgLmfFoO/jRGZXqlU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=paS1y0nWdyMIgCPNPkKqYChFr00DJaBDBrpY4T9kLNJaNTrhqOjmvXKuUV8EeyDfZwhX/9mVyUj8tL2xlaDRZ7tg2++A0UKy8Xp5ePytB6iKjMkLt5T2WcCaXFRKKLm2FQAgyJQNJq0eGkMF5mpjVCt4lgVTghrIlSOlluQTLE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=N9PEJAk3; arc=fail smtp.client-ip=40.107.249.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j4f7rhyf2Iq22abk5vRA0Q5Ev6vj5fmUoMi+roVYGPQChic82bAG3hd3VgNZelJNrHBoVZ7fhVj0uFX0FkKTgqUjYL3fXiaMTHK9Dk4Ib9jlpcYOFGvRG5BLj0I2ivMaRbhosBDCLfcLxE/2/1j8Ps+IYaCR8d9gvfP3W3yHJELHQSfvYwP+cDnLm5N/cQJ9DclAUHg7BgGmR9WRZb+u03iHXTlfDJSGJ7Eaiw6Q6Nvo3gA4ZR1F5gagxFa30+McwngD58h2Nz89aqddi/7i5jE/YZ6dDJ1LFC4wrbUuzSZXGks5MzMtsUouvRvY+fH6INtH71xg96fodp6cHzjIEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jWYPzo2EoKDxlJtM+R+O18Sr8h+QMPetiaIR/FvSdcc=;
 b=hvDaEobvGAHdie/RXkpnAkDkFvZ+nx/4oMBL0KSqm/GNU+izeb2Fj28e8KJ25W/JnOtlS8RDe+mxGg4zvFZZYZevdtLhjkKJotgF1FzsRz6HyLDqCOY8GAzAi2kHRx0LNirT850i66+XsR8P96G4JgVQvLg8LtKTTZ5QdApEK9QAZyEeQCEbId75lc6W0TuNUTDAR4ZBD/BRKPDVHlUfEQOow7Le2DQ9EJABU//ebCgUj3Iw6j/11BWjassgt2Rr19NzC+VvrZwDPexumYad0Az3RF1CDrSC/kK6SaL8A2+fKXsvIbA2rrTVdQcuyMUY+wtzwzKrEqu3C2pUOOwIEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jWYPzo2EoKDxlJtM+R+O18Sr8h+QMPetiaIR/FvSdcc=;
 b=N9PEJAk3Ghu9nAhoaFXk4eN0dFELCNMl4urmi61OgxrD3nbIEnjkmESN06ZbmAj/cJhHY5baCwZigLB8vzBlEo3OPdJb23dt0qSRN93MvHr+HaEDrW+y5fKhGCnrWlgLuuDd3dXfyBhjMDaSyKnR2YGHrOkmL1smb/4zLZIExlQ=
Received: from AS1PR04MB9358.eurprd04.prod.outlook.com (2603:10a6:20b:4dc::19)
 by DB9PR04MB9283.eurprd04.prod.outlook.com (2603:10a6:10:36d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Fri, 7 Jun
 2024 05:00:02 +0000
Received: from AS1PR04MB9358.eurprd04.prod.outlook.com
 ([fe80::d74b:21b6:d315:cb84]) by AS1PR04MB9358.eurprd04.prod.outlook.com
 ([fe80::d74b:21b6:d315:cb84%6]) with mapi id 15.20.7633.033; Fri, 7 Jun 2024
 05:00:02 +0000
From: Vabhav Sharma <vabhav.sharma@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Frank Li <frank.li@nxp.com>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Franck Lenormand
	<franck.lenormand@nxp.com>, Aisheng Dong <aisheng.dong@nxp.com>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Peng
 Fan <peng.fan@nxp.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Varun Sethi <V.Sethi@nxp.com>,
	Silvano Di Ninno <silvano.dininno@nxp.com>, Pankaj Gupta
	<pankaj.gupta@nxp.com>, Daniel Baluta <daniel.baluta@nxp.com>
Subject: RE: [EXT] Re: [PATCH 1/4] dt-bindings: firmware: secvio: Add device
 tree bindings
Thread-Topic: [EXT] Re: [PATCH 1/4] dt-bindings: firmware: secvio: Add device
 tree bindings
Thread-Index: AQHaoao2jC57TZpcF0ePF6O5Tvr8yrGOOJWAgAAusQCALYQ9YA==
Date: Fri, 7 Jun 2024 05:00:01 +0000
Message-ID:
 <AS1PR04MB9358029DB6E685ED7693047DF3FB2@AS1PR04MB9358.eurprd04.prod.outlook.com>
References: <20240509-secvio-v1-0-90fbe2baeda2@nxp.com>
 <20240509-secvio-v1-1-90fbe2baeda2@nxp.com>
 <Zjw9044yBRn9+adW@lizhi-Precision-Tower-5810>
 <52deb076-f2d0-4c61-9dac-079e3ae881b6@kernel.org>
In-Reply-To: <52deb076-f2d0-4c61-9dac-079e3ae881b6@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS1PR04MB9358:EE_|DB9PR04MB9283:EE_
x-ms-office365-filtering-correlation-id: db2ea682-57f0-48d1-b70a-08dc86aeb042
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|366007|7416005|1800799015|376005|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?sk5VAIYFjV17TyFs4SYrwch2rRC9pyDMfOUO11bcHjZNFFXfPcl+1SLf3jCE?=
 =?us-ascii?Q?V2tyJVNYDSefQDDsFxf0Iru4pA2eaVJ2P/pmmeCk7yJezgy3yhJuBkwT9Fx7?=
 =?us-ascii?Q?zES7BItn/XyED3Rf6UvalTF9VQwvFxZEoe/U9IyWq0w7vI7nB79EgAqYf+7+?=
 =?us-ascii?Q?ZnTSz7lUuYeMzAr5d2bmED1XDVbijmczocWRThzoUXtNMfd9ySnkkSnlWrKK?=
 =?us-ascii?Q?khFyYwdQjPGrUXtQFBzlDj+cV9u8tVukfclZVXmMM8k++68qZyy4wbQYx8M6?=
 =?us-ascii?Q?SCatbKJsJBMglYAOJSGZta5UH1lHtqj2qXA0CJJiTFWEosg/PMwKMuaVd2Pg?=
 =?us-ascii?Q?/rqahRHsV3akf1at+lF19bQGnVQqujoeNNQTalrey4pHFFiYhuEHMyvPPC3f?=
 =?us-ascii?Q?rvQcSdtYoVIEz/uOrN6JOePmpdTIpj4kYpw1GtpAkJ5hNUmP4FjSv1ivniSf?=
 =?us-ascii?Q?jb+Dt6YJxYZ1FEP80M1mnexsKJSjV1Uvn8kjYt6iN7WnirUUWW51FBNves9q?=
 =?us-ascii?Q?0ncfBQz0nU/3DeXYffQhpJKwuiVa6HKluhp1jAPEbm58mXijshx40BtXNZ+7?=
 =?us-ascii?Q?evYObsQxDVj/btW23HBXqOtLz/zOR4mF9IXrbj3T19Q0GBAShV9kCdRfzNxW?=
 =?us-ascii?Q?ZdA6GpKKDCQRwUK5SyM6YxQv9WXhUooqQkO8nA+LnmPfjEvwvxBLjgZIWAa4?=
 =?us-ascii?Q?gOP9/HSZBzUapkdQ5gqV49im2FWfJLMj4fgi086+zCCTUvOQbiC2UqjDKbPa?=
 =?us-ascii?Q?m4TSU6+JjiGdon1VS6wQDTLlrSQkoakhjQxOkk04JsoX6c12Bjn50oHoJF8m?=
 =?us-ascii?Q?HgrxQ9zPr+Bq62KqYwuWoN0scOwAoYYQuHF1z3W6hf9dTuBpUiMF3URY9tsA?=
 =?us-ascii?Q?24ZgWqFIPHxPfCoeVLAaN9CCGiLKNFM8L9KE+tDgqRGhyU2ziLej8emTlJq8?=
 =?us-ascii?Q?MQ3x0VquFGEskvbnUkw/heGtVC9VvqdwBzOlpc/T3qrBdyqFFL37YNyoT6Y4?=
 =?us-ascii?Q?xd6MetRlT5ODOvCabPz8VSvv34CYcsW52sLDPsHn2HwtOMgHcUPcttNhF6Bn?=
 =?us-ascii?Q?QFuje/UPZq1LKF6dgYT/j4idYf5p8pmuz15SmNmkdmSzhnmliYLKgydot7Tl?=
 =?us-ascii?Q?gE35XW7BnIgFlg+lyDQK8sDNdZrkVY+WJUAYZC2V/R0xslfaDZmI3l8lVXOu?=
 =?us-ascii?Q?dOHC4BjRJSqgwnZqxeMxHxb9evjmml/50Fx2wGakqnPrkjK9wui+uoo2uMRz?=
 =?us-ascii?Q?IdYOyaIyBlxEVjOK70s/WtQiazS9qjm2oBafmhtbFqMZWg317IwcskrF3YRd?=
 =?us-ascii?Q?WrFTOH1aWNEH/A+qBN6d65mtr4ColeaRCxJnZ5HF/D9my2wGPLt//zPOIBQr?=
 =?us-ascii?Q?WDPk6vY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR04MB9358.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?0hBhVcAkyMEJiH1zZnA8eqsBl9FBqoE22XiyaJain0O85Em8VIuh0OuoMOXx?=
 =?us-ascii?Q?hkC+cA8b32iAlzqPwD1OoiGC5wfV/k3sF+GBxFjm2sGwGD2/eXuc06y+6XL9?=
 =?us-ascii?Q?i7prPc9cgcidf5oVfsvsvR9br0rIgDefVv6MQkMQxlxfDa6xFmyRTqCGC7ZQ?=
 =?us-ascii?Q?DfD49YetTnYNzHDLs2ymoiMdJBDCQOsuEbMYQWID6n/psVWu6XB5QYUqp3aY?=
 =?us-ascii?Q?AF5PCX5ZFhfCGXGo5FiaZ+Alhvqm7B+DV1R3X40tQecYqrNb9KZFS0yXnMqL?=
 =?us-ascii?Q?raUlp5l/3cL8UqVsEFzMGFTAVW4N24c4mQsZix2BSYyZiHWc3WtNg3IgZHTr?=
 =?us-ascii?Q?GNIFarWq/bx1a60nzZA4XpkohQoMDOj6LRWLbTk8T9UyIGuOcYnG9IdvIVYj?=
 =?us-ascii?Q?tcIFa9vZxlmmJXlVzhZLBtDGxfro2tAoy9c6BmYIEjChJ/au75FHUmLMM8uP?=
 =?us-ascii?Q?cRAamFtmmxBmIj+ph3rAAK8keUSX5s8jjytDsRGOn3DvNcE001Sqt6Y00WU2?=
 =?us-ascii?Q?parEjdhf4owKtX20r37yGBkxqBk2VRgXwmSX+7l5CgLxqrVzoY3cco+3aQGy?=
 =?us-ascii?Q?fVos4MrW2HH/X+vR6FiDq7bTXdRPF7JwpJPCjXxak9lahPkj/jCL9HVknblz?=
 =?us-ascii?Q?MpsBUZvUHjj32l9JDAz9i9Nqapi68/mv9QBkWwW/SB3NdHO/OivlivAOBpqv?=
 =?us-ascii?Q?RiKgvr4J1FuLtZemX6664GcbRdQqRkx6x7hXIGutTbmq3Fo+GaKyGR7xPkP2?=
 =?us-ascii?Q?QgWDP3K1cKEB79o1zvkWOfnDg2440tB7ntjTg9ePN59/TxnNyEINnKdTCKuk?=
 =?us-ascii?Q?wU/7u7Y3DJm6Ok3/OJP+mBwt5qd05q8LEfJKtKRkkTPOdpByLjlIaXdxCQyX?=
 =?us-ascii?Q?mWpUXX7Z2KUbQwc3XqOyAxUaHpCOx50m/jKr5QtXs+UyUMBN7PaQaG2kFb7y?=
 =?us-ascii?Q?jl1p0aRfsgXSeiyES16TFoTNU7F9pJNPwe7U7G2d2KE9TeIFEYi8Yuo353So?=
 =?us-ascii?Q?e9OS/UziizT/2rfWHEwzvvj82YiXFxzXL67lgrQ+XaN2622vwLysmK8ClVpG?=
 =?us-ascii?Q?UcAnF01bJ7qOxxBiZUBuQF/QLdiTod3wQVXJZEcTWXvV9qC3+Nns0Bk62wC0?=
 =?us-ascii?Q?+yQ1fYGi2Uf7JF+sNsZzRZcvHscbSjnvFD+ZUrI459FQ6zKTHJJx18Ud2Xng?=
 =?us-ascii?Q?X+aXFfOnfWzVndFf1ubR392BirFvKotC3JY1fDWiuW4fpOuuvLJIRmSYfkjy?=
 =?us-ascii?Q?wpyQlM6j3NZn+Pegt6V8USfTwgOVvZTl4UgRSSDmA3Rjs005l3WnHInwAow/?=
 =?us-ascii?Q?zVXlrpjyqO1g2fgQWb/pNzbLq3rwUtISuCyCzKFpw0jPm83+tmi/O97SW0gJ?=
 =?us-ascii?Q?KMLmo/XVxKpLBT/+8wfAHU+MmT7gyUZ5T6iQ4lSuOj4g2LBY9GPpo95TjAdE?=
 =?us-ascii?Q?3BNTNxHs8H4jh/IRXl9RcB15wXlVpYl6gKU+qA89z9XgckLRv7YMACALavtW?=
 =?us-ascii?Q?nkvNWxwHj59dvN8JBAZ/xw0nC0nv0H1POMq4LhuJccRguVtJVhzRcz6kespn?=
 =?us-ascii?Q?59XNH1I4SQT1VlZWhtPB1VtHkL9Dz+iuUojAtCSy?=
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
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9358.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db2ea682-57f0-48d1-b70a-08dc86aeb042
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2024 05:00:01.9163
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pnguPAiDNpbgfmDL3+Tga6OIHRKgK1N34X3d0UG0wbqcJ4gFIzCZiKgoe5jUJlKQeqvdtk8QSu5bb4R8EjjiAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9283



> -----Original Message-----
> From: Krzysztof Kozlowski <krzk@kernel.org>
> Sent: Thursday, May 9, 2024 11:24 AM
> To: Frank Li <frank.li@nxp.com>; Vabhav Sharma <vabhav.sharma@nxp.com>
> Cc: Rob Herring <robh@kernel.org>; Krzysztof Kozlowski
> <krzk+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>; Franck
> Lenormand <franck.lenormand@nxp.com>; Aisheng Dong
> <aisheng.dong@nxp.com>; Shawn Guo <shawnguo@kernel.org>; Sascha
> Hauer <s.hauer@pengutronix.de>; Pengutronix Kernel Team
> <kernel@pengutronix.de>; Fabio Estevam <festevam@gmail.com>; Peng Fan
> <peng.fan@nxp.com>; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; imx@lists.linux.dev; linux-arm-
> kernel@lists.infradead.org; Varun Sethi <V.Sethi@nxp.com>; Silvano Di Nin=
no
> <silvano.dininno@nxp.com>; Pankaj Gupta <pankaj.gupta@nxp.com>; Daniel
> Baluta <daniel.baluta@nxp.com>
> Subject: [EXT] Re: [PATCH 1/4] dt-bindings: firmware: secvio: Add device =
tree
> bindings
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>=20
>=20
> On 09/05/2024 05:06, Frank Li wrote:
> > On Thu, May 09, 2024 at 02:45:32AM +0200, Vabhav Sharma wrote:
> >> Document the secvio device tree bindings.
> >
> > reduntant sentence.
> >>
> >> The tampers are security feature available on i.MX products and
> >> managed by SNVS block.The tamper goal is to detect the variation
> >                         ^^ space here
> >
> >> of hardware or physical parameters, which can indicate an attack.
> >>
> >> The SNVS, which provides secure non-volatile storage, allows to
> >> detect some hardware attacks against the SoC.They are connected
> >                                                ^^ space here
> >> to the security-violation ports, which send an alert when an
> >> out-of-range value is detected.
> >>
> >> The "imx-secvio-sc" module is designed to report security violations
> >> and tamper triggering via SCU firmware to the user.
> >>
> >> Add the imx-scu secvio sub node and secvio sub node description.
> >>
> >> Signed-off-by: Franck LENORMAND <franck.lenormand@nxp.com>
> >> Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
> >> ---
> >>  .../bindings/arm/freescale/fsl,scu-secvio.yaml     | 35
> ++++++++++++++++++++++
> >>  .../devicetree/bindings/firmware/fsl,scu.yaml      | 10 +++++++
> >>  2 files changed, 45 insertions(+)
> >>
> >> diff --git
> >> a/Documentation/devicetree/bindings/arm/freescale/fsl,scu-secvio.yaml
> >> b/Documentation/devicetree/bindings/arm/freescale/fsl,scu-secvio.yaml
> >> new file mode 100644
> >> index 000000000000..30dc1e21f903
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu-secvio.
> >> +++ yaml
> >> @@ -0,0 +1,35 @@
> >> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause) %YAML 1.2
> >> +---
> >> +$id:
> >> +https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fde=
v
> >> +icetree.org%2Fschemas%2Farm%2Ffreescale%2Ffsl%2Cscu-
> secvio.yaml%23&d
> >>
> +ata=3D05%7C02%7Cvabhav.sharma%40nxp.com%7C16a07379ee384ddc18f908
> dc6fec
> >>
> +75e7%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63850830857
> 3434788
> >>
> +%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIi
> LCJBTiI
> >>
> +6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3DMBhqXwhXIQjDb3A
> RdYJ4U5EXM
> >> +ryEy%2F9m5X6jGuNhHxo%3D&reserved=3D0
> >> +$schema:
> >> +https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fde=
v
> >> +icetree.org%2Fmeta-
> schemas%2Fcore.yaml%23&data=3D05%7C02%7Cvabhav.shar
> >>
> +ma%40nxp.com%7C16a07379ee384ddc18f908dc6fec75e7%7C686ea1d3bc2
> b4c6fa9
> >>
> +2cd99c5c301635%7C0%7C0%7C638508308573446476%7CUnknown%7CTWF
> pbGZsb3d8
> >>
> +eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3
> D%7
> >>
> +C0%7C%7C%7C&sdata=3Dm0RzUoVfr%2F2HkLlSOjhTq%2FQX3EM6ZAW7h5hQ
> Eidnc1g%3D
> >> +&reserved=3D0
> >> +
> >> +title: NXP i.MX Security Violation driver
> >
> > Violation detect driver
>=20
> Bindings are not for drivers.
This is security violation detection hardware exported through SCU firmware=
. I will detail the HW in the binding
>=20
> Best regards,
> Krzysztof


