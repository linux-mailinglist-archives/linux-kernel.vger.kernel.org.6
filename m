Return-Path: <linux-kernel+bounces-263237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B01693D311
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 14:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D9AE1C23087
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 12:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E96C23775;
	Fri, 26 Jul 2024 12:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Gi/IirAT"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012041.outbound.protection.outlook.com [52.101.66.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5233225D4;
	Fri, 26 Jul 2024 12:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721997354; cv=fail; b=SKGfSvy8aXI10t0IXjS7qLMNOWvCQPTs5kHMXrSnS1j7sBCjtjkHpKiTGZ6weA2uBiEiF1zcnUvYXVEXQlyA0Fv6CBG74Ky9D7IeUGFRpv5INn5kWegaUQnZHrzcgav3in/TCTo//Bv94Yf2r41nS40tHEOOVPPlLGvOFTJfYCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721997354; c=relaxed/simple;
	bh=SCqP+L+nfHoZasmv1kfH1FyeXUSh9EQP5xyBh1D6yQg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mZQzK4kwWGNN1vJ8xgqQkJJyYzUGHfgkKg17CZYdlq58Wd9N9vCum9mSLKh+QOGIjf1bCJm87u3KR8nhC44FvA5OVNZNcLlsVOIQMFUMagS+wI4hLr+XK9DlwEv5tHP+pcoFIH0i2HCw/Bi36TFaim03zUoGLjfSW9HhOZcLNOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Gi/IirAT; arc=fail smtp.client-ip=52.101.66.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kI54wuE+R87tqamOCMXdKyPsWTOHcDUelWGfp2XQnM4deq3v8GOk9nXiZlpKWTUPTErMaG3v8va8FAXh6z4CKCVbNwRL1xnFvHGJXAYT3/cJR7UX12g8/GiiP/BSgTbWoLC/R83RH6fsZYBdvXspk7/bZ9JLHEsQePc84rIuKpQlhd9+L1/F+M2xX2mheZCD/rws5zlPdK5TMEM2yKfs+QDE01ViYJjF1uKLmtl8SG54YK0TMVakCeSLdGWiQuUi0J1Gvd65rm0EeFT62ZOf7f/9Q9HD+6WAWDzdkSqz0EKLB1EXEsXCUmcTYMDIKqm25cUCNWxz5aefMFixKuPFqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RXXg4WexB6izfFwC+aK4H6UrMb7qqcup5KxAywC+z44=;
 b=GUbrabaGg4eTUI0DGlU711PGmZGgi+i3ylC63DWnJpxev60DDLiLKEbU3SInWa3gtJM/KhC+vDi1b3v220eOzKRpiC4C9pw9JAWFCoChfcgse9Np7na40wjlF1cylbRCOeXq2wEGsv4i7I7zENo74K1uSSrorCunqNkcfQ3WbpbVxBzHADCzdHctBqq2TXGUYB3VJuozeGwx5Sjm8lHNUWCC5P5OZDGkTp4Yf+LWI4qwWC6DHXl8YYTLC0+gDlWndhvBxvcBDjhQVFWDJAsKfHoJMyxX/EsZ7uSCUfPRXKFapbxHam0Z9ghvUEC/Movkkghzl5RpYQHGluG38hmjIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RXXg4WexB6izfFwC+aK4H6UrMb7qqcup5KxAywC+z44=;
 b=Gi/IirATTP4Wd978TgSem2ZgQ+KRF6nKpD0yghcQCNfFX6Z9NE1w+SpFYc88rJwrdN6YoMbKWIRrjw7svX6zGDAsN2FQdbuZmJQKw817bMqhQWRFmwlpXdQd99Jdva9AIwpL6j97Wkzs5Owsd7PcGOv+CUs2/6qszXa9wnjgpOnXZpEFHVW067cJyYkZdj8wwojQ1Jgs5YzFzhmMLz5wky+zcrD7dgZzcFOp/JJ/WjPrVtBIntRC8Ulpm8Xm4WX9MTA/lJ2bhLKaZVnChSAU62WwHWj1QEA9T8s5gzkhLv5nUiOlNa6KteXtQEKu6ZgdSgexny7LI6WW6MBPe29RdA==
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by PA2PR04MB10424.eurprd04.prod.outlook.com (2603:10a6:102:419::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.28; Fri, 26 Jul
 2024 12:35:48 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%4]) with mapi id 15.20.7784.020; Fri, 26 Jul 2024
 12:35:48 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
To: Conor Dooley <conor@kernel.org>
CC: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Rob
 Herring <robh+dt@kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [PATCH v6 2/5] dt-bindings: arm: fsl: add imx-se-fw
 binding doc
Thread-Topic: [EXT] Re: [PATCH v6 2/5] dt-bindings: arm: fsl: add imx-se-fw
 binding doc
Thread-Index:
 AQHa2/NU1sJztJxAoEWO7LSlO6AOebIC9paAgADLMzCAAJnWAIABTu8QgABaVYCAAPz18IAAhwuAgAFte+A=
Date: Fri, 26 Jul 2024 12:35:48 +0000
Message-ID:
 <AM9PR04MB8604E23D34326C32B76D6F2995B42@AM9PR04MB8604.eurprd04.prod.outlook.com>
References: <20240722-imx-se-if-v6-0-ee26a87b824a@nxp.com>
 <20240722-imx-se-if-v6-2-ee26a87b824a@nxp.com>
 <20240722-popper-comfort-7538ea70c77b@spud>
 <AM9PR04MB8604123E065315093347F66C95A92@AM9PR04MB8604.eurprd04.prod.outlook.com>
 <20240723-smitten-shower-1d15c0f3cf97@spud>
 <AM9PR04MB86043E4B4B2FB206BF9223C695AA2@AM9PR04MB8604.eurprd04.prod.outlook.com>
 <20240724-huddling-neatly-88813c0b1f1d@spud>
 <DU2PR04MB85990A0AB8AF8ABFCDA4CBD995AB2@DU2PR04MB8599.eurprd04.prod.outlook.com>
 <20240725-filled-outscore-24149588d958@spud>
In-Reply-To: <20240725-filled-outscore-24149588d958@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8604:EE_|PA2PR04MB10424:EE_
x-ms-office365-filtering-correlation-id: ef4430bb-c655-4b01-2d66-08dcad6f7a6b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?NDF66eH8B164gwVX2ychYB1EvaX0D8p4OnikycZkt+FfaAEQbnLNQIUMX72N?=
 =?us-ascii?Q?cXhSX1L/W0h2Eqa7JafhVJmfkoG6PxizjJt0M+iQ4woD6b2A3d8nmG4ZhKY3?=
 =?us-ascii?Q?NBRGw5Mri76rC86VJZJHPPwRa1EaG7FB1Ogpfpsn/1vKKPUxPkoCThgtxkrw?=
 =?us-ascii?Q?0yACfblaIlTtA4LX7t6Qa3e1sbHZ3wHoO+GGxrZtc813X+iVhPyuBvDAT20B?=
 =?us-ascii?Q?zz3vlgvhd/+r9ptrjFdR++ojJNs+andWQYLRTgBxnRQTbAH5Qc6Wj1F9sSAd?=
 =?us-ascii?Q?LdxJV8I1chfuyMzEz3H/7jTTvPhEeVLXtL8FgBVaMpV+v154YIA4MviLNry+?=
 =?us-ascii?Q?dww/r3Cg/yQfcuUPJkg2CEv2Yp8lGIvzFGm9eUFJqG3Xgbn4bWp6MaGsq5TM?=
 =?us-ascii?Q?atMarsaF8rHJQweLNtvKpOlQuZCtAb3cnIHP1vjXLoYLNA9szKnVG35b1wsx?=
 =?us-ascii?Q?4FKJpGyzwJ2Yne5bUMwg1F7wLLkFRzbolAI823c+IByaPYUBj2G0DdVMhonX?=
 =?us-ascii?Q?CInbJ3A/eF0cjyX46qwspKHWGGSfeXAMoo5a2jPHhUrAehbs25a2QX4EWn7L?=
 =?us-ascii?Q?7xvbeoJ3gj1GnjaF2cUFcq/zNtFUGGv/OoVM7hgfLwMemNdEZqQsF1VDc73W?=
 =?us-ascii?Q?/rXP1lxpcqYO3nO7ARNCqajwYsU9JYRJsKhekT3fwjvqvLkaWs6zwp8l2Ouh?=
 =?us-ascii?Q?f66wtsYZHYQech73GHP+TpPZ/jTgjj6mQxY1QVT//xuDd9LMD9lAK6/kralc?=
 =?us-ascii?Q?TgDzW+1WTSAFGG6GgU3MY3VnldgFhaIfiaEdhcF7CdGlzBn//gLbAt3iVZX2?=
 =?us-ascii?Q?HY3p1qQBiezvqFFB9x6+qf/NJ0u17Nn83ylo9pZjyPMmv5GmgUmCVgFk9c2F?=
 =?us-ascii?Q?7crWiY/hArMWwCOIhNEHcpIVms9arnvfu6zKGiHMKg7qTKTWDHkuHSApwYZm?=
 =?us-ascii?Q?v8S0Ub8IlaC2bT7aw3EV8medT62EIOcWlrhOunMxytdR+hIZ0cRYLCXNcO9i?=
 =?us-ascii?Q?+qByzICSPpoRkhDHS2dH1jIgBat5mPdZCglOTTsbqhb+6aQ9fwxe9Y3Z82h2?=
 =?us-ascii?Q?qGGqsajqOfn2sjB/nKvFhulM2I6GDNCd05P5FFAzaMMl9jhbWQxjSPJCItjM?=
 =?us-ascii?Q?f21g/rQc4DgofDwiQx/eToqeMtwvmV9p5eaOm/DIAGeSTfAZukA7vUpbCSF0?=
 =?us-ascii?Q?ylUPs68Oy7lon0ra/deUGHhc9rktn7XoCZ6Qeo3oMOPeq749TKNeWkwC6Z3Z?=
 =?us-ascii?Q?Qwe4CQ1k/ihSvjwkQWr12aFOeku9F7gHDPPIArKCNwjI7oT5pdogGA5D5Usm?=
 =?us-ascii?Q?PblHSib2oz0aFyUjLrR65iVa8FlWDxZqZsLuAL3ua17C0LZ2SOGAhqdhzXac?=
 =?us-ascii?Q?b9itPutFPTxDgjCe3BN3fPPKR5sIWuxhc7xT6Lam2wuPGPSWIA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?WXxR5Ck/lxswCVILxX+arPsUDfNOw7B2E3GV0nBtDpeSKKzDgxL+WP0qXJST?=
 =?us-ascii?Q?DrODWL1/g541Spg6UgiRD9FMBULYw3cZK/CvTVJDiTASQM56DiQqgwbb6+gg?=
 =?us-ascii?Q?EcuC25IrlCw7/UkHJvhl8KZT9Ua21+4bzmvoy5/dgaodaBmsyToOdT3w7qWr?=
 =?us-ascii?Q?s/hWvhEFlHaHKcn4VI5dw6Tmda3cdpXXZZnSpqgtVlXsHl90lcc+JqiQjJYl?=
 =?us-ascii?Q?aTAXJMEAJsHZC/bPaAYnlvOjoqrqDv+G1c9ZF86P60c9r4W8IQ5zV+lbFDpq?=
 =?us-ascii?Q?S7tnI99OtIIRAehdJiJUAL1NL+uUQWNCGhG+venmtor2NvHu2hWts/mzr0Uy?=
 =?us-ascii?Q?8Ys6wcuktF8B7OL8ZsPmZJJvEnbsLdUs5NAMQ4Oq8VuaZ7vlRk2DYxLooOKv?=
 =?us-ascii?Q?81xqWhUlHSsBaBbogXDoEuqIWCbCOMD6aSuwVk5ZCylxo60zkBxSGl48L3TS?=
 =?us-ascii?Q?SPbCPuOVgytbUv1rix9fcPIoXy13JnA5V4oQ5kEZIJ42HFEr0WXVjzEOZJor?=
 =?us-ascii?Q?6Q8Fny/x2Ot4PAJMtbW+iffalDiTR6XnRDSax6T7AyvRzDemg1G+tgleIbM1?=
 =?us-ascii?Q?/4UW/vyG9rGO25lZN7Cy/JsXQQDLC5dMc0cnKwFVrmR9bZoxRBtrLo7SwKSa?=
 =?us-ascii?Q?6OWUieZNGwcF7jXlsfvOu/CHkcKkIY0Qeb/fvochGPX2H8YSHKduS52nH6G1?=
 =?us-ascii?Q?qIJhlpkneSEuhPx45fwQrp8MXuit5xpeFtee623hCTxexoo4jBej3wWPZgsz?=
 =?us-ascii?Q?TVg9X2Zu51lQf1rlNWHECE4qGjzoirea8dDZJr42VDFyKpjr/86tPDSwQRe5?=
 =?us-ascii?Q?+Oy/5Pq6i+KGdjpRdhrsEBIBuT4juYSz0Ik4vKFq72VAXsRhUFjfq6JZ5Htv?=
 =?us-ascii?Q?iT9KiMFqZo4nUnjuw0PofXU4VFHjox54gp/YysARUFsxkd7MEZKeljTL9GLv?=
 =?us-ascii?Q?wi//9NDvNbGDP8dHHilr6c2KtymC4RqkXUPyti64+7MF9xYIz8oujQ7OHjvN?=
 =?us-ascii?Q?6tCNWScobbfVbzfJv8spsPESgJs4t4UE/2RmHOnaNjaUqoWxgsy4e1/YAXct?=
 =?us-ascii?Q?iV+fLev36A5UUeJE2TcuXbyEF4Y0rco9NVSkydYkp38WZvPyd2qG4Dc9CJC3?=
 =?us-ascii?Q?EousDAw14+W75p6jBp0MHkaQWcM3TVKSNg3y/GthEZgp8MXXGrRM1NT4jU79?=
 =?us-ascii?Q?48z8YDPYaC3iRTH8NqNtT5yuA3FLo61saybN6BLZPuRggB7JZz8XYtjaFoKM?=
 =?us-ascii?Q?84Lu3rxJDfca/AMCJgT1F9r4XFWGE4fxqE0qJCyyAMw+raYnlbpglCb67GH7?=
 =?us-ascii?Q?dL8I8RHhrtDc4ldNopb92YY8uXztlkgAEIZz9TcEBRS1gGZcr2ahu7kQCkoR?=
 =?us-ascii?Q?7BQwkTMFPm6+DuK04hj35l6BmV8gosaRp28NhqjsXBI3DrebMuKrzuviB+Qq?=
 =?us-ascii?Q?hxiCkcnt0rPkWwp+M09thk5sLsPhZI0OH/rPf8BpuUtjGXhfNPv5dY3rfUr1?=
 =?us-ascii?Q?m7H9/ySxghh0SyYf2HeFnKIKFQyOK4clt0kq0MdKrEGTg02tG12ODRxGWZBH?=
 =?us-ascii?Q?3BUpmLACwCo6WcujKvo6Q1yfUAeiRLqECAtrpT0T?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ef4430bb-c655-4b01-2d66-08dcad6f7a6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2024 12:35:48.6089
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7beM9a5p4eiAidWbTdKL0F5VaOG8KRH9f6tUSUxY5DRhv1qFYOkcL+UBdSm/Sb74fjq4Qbbtsrs0E99b9EUj7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10424



> -----Original Message-----
> From: Conor Dooley <conor@kernel.org>
> Sent: Thursday, July 25, 2024 8:09 PM
> To: Pankaj Gupta <pankaj.gupta@nxp.com>
> Cc: Jonathan Corbet <corbet@lwn.net>; Rob Herring <robh@kernel.org>;
> Krzysztof Kozlowski <krzk+dt@kernel.org>; Conor Dooley
> <conor+dt@kernel.org>; Shawn Guo <shawnguo@kernel.org>; Sascha Hauer
> <s.hauer@pengutronix.de>; Pengutronix Kernel Team
> <kernel@pengutronix.de>; Fabio Estevam <festevam@gmail.com>; Rob
> Herring <robh+dt@kernel.org>; linux-doc@vger.kernel.org; linux-
> kernel@vger.kernel.org; devicetree@vger.kernel.org; imx@lists.linux.dev;
> linux-arm-kernel@lists.infradead.org
> Subject: Re: [EXT] Re: [PATCH v6 2/5] dt-bindings: arm: fsl: add imx-se-f=
w
> binding doc
>=20
> On Thu, Jul 25, 2024 at 07:06:30AM +0000, Pankaj Gupta wrote:
> >
> >
> > > -----Original Message-----
> > > From: Conor Dooley <conor@kernel.org>
> > > Sent: Wednesday, July 24, 2024 9:00 PM
> > > To: Pankaj Gupta <pankaj.gupta@nxp.com>
> > > Cc: Jonathan Corbet <corbet@lwn.net>; Rob Herring <robh@kernel.org>;
> > > Krzysztof Kozlowski <krzk+dt@kernel.org>; Conor Dooley
> > > <conor+dt@kernel.org>; Shawn Guo <shawnguo@kernel.org>; Sascha
> Hauer
> > > <s.hauer@pengutronix.de>; Pengutronix Kernel Team
> > > <kernel@pengutronix.de>; Fabio Estevam <festevam@gmail.com>; Rob
> > > Herring <robh+dt@kernel.org>; linux-doc@vger.kernel.org; linux-
> > > kernel@vger.kernel.org; devicetree@vger.kernel.org;
> > > imx@lists.linux.dev; linux-arm-kernel@lists.infradead.org
> > > Subject: Re: [EXT] Re: [PATCH v6 2/5] dt-bindings: arm: fsl: add
> > > imx-se-fw binding doc
>=20
> For the third time, please fix your mail client so it stops inserting thi=
s garbage.
>=20
> > >
> > > On Wed, Jul 24, 2024 at 11:02:21AM +0000, Pankaj Gupta wrote:
> > > >
> > > >
> > > > > -----Original Message-----
> > > > > From: Conor Dooley <conor@kernel.org>
> > > > > Sent: Tuesday, July 23, 2024 7:38 PM
> > > > > To: Pankaj Gupta <pankaj.gupta@nxp.com>
> > > > > Cc: Jonathan Corbet <corbet@lwn.net>; Rob Herring
> > > > > <robh@kernel.org>; Krzysztof Kozlowski <krzk+dt@kernel.org>;
> > > > > Conor Dooley <conor+dt@kernel.org>; Shawn Guo
> > > > > <shawnguo@kernel.org>; Sascha
> > > Hauer
> > > > > <s.hauer@pengutronix.de>; Pengutronix Kernel Team
> > > > > <kernel@pengutronix.de>; Fabio Estevam <festevam@gmail.com>;
> Rob
> > > > > Herring <robh+dt@kernel.org>; linux-doc@vger.kernel.org; linux-
> > > > > kernel@vger.kernel.org; devicetree@vger.kernel.org;
> > > > > imx@lists.linux.dev; linux-arm-kernel@lists.infradead.org
> > > > > Subject: Re: [EXT] Re: [PATCH v6 2/5] dt-bindings: arm: fsl: add
> > > > > imx-se-fw binding doc
> > >
> > > Please fix this ^
> > >
> > > > > On Tue, Jul 23, 2024 at 09:28:31AM +0000, Pankaj Gupta wrote:
> > > > > >
> > > > > > > -----Original Message-----
> > > > > > > From: Conor Dooley <conor@kernel.org>
> > > > > > > Sent: Monday, July 22, 2024 10:20 PM
> > > > > > > To: Pankaj Gupta <pankaj.gupta@nxp.com>
> > > > > > > Cc: Jonathan Corbet <corbet@lwn.net>; Rob Herring
> > > > > > > <robh@kernel.org>; Krzysztof Kozlowski <krzk+dt@kernel.org>;
> > > > > > > Conor Dooley <conor+dt@kernel.org>; Shawn Guo
> > > > > > > <shawnguo@kernel.org>; Sascha
> > > > > Hauer
> > > > > > > <s.hauer@pengutronix.de>; Pengutronix Kernel Team
> > > > > > > <kernel@pengutronix.de>; Fabio Estevam <festevam@gmail.com>;
> > > > > > > Rob Herring <robh+dt@kernel.org>; linux-doc@vger.kernel.org;
> > > > > > > linux- kernel@vger.kernel.org; devicetree@vger.kernel.org;
> > > > > > > imx@lists.linux.dev; linux-arm-kernel@lists.infradead.org
> > > > > > > Subject: [EXT] Re: [PATCH v6 2/5] dt-bindings: arm: fsl: add
> > > > > > > imx-se-fw binding doc
> > > > >
> > > > > Please fix this ^
> > > > >
> > > > > > >
> > > > > > > On Mon, Jul 22, 2024 at 10:21:37AM +0530, Pankaj Gupta wrote:
> > > > In case of imx8ulp, there is a single node.
> > > > Having a same node name for both parent and child, is bit strange.
> > > > firmware {
> > > > 	firmware {
> > > > 	};
> > > > };
> > > >
> > > > Request you to allow to re-evaluate this point.
> > >
> > > I dunno, it's all firmware so I don't really get why it is so strange=
!
> > > Can you remind me again why it is inside a parent node to begin with?
> >
> > Three type of security firmware(s): HSM, V2X-SHE, V2X-HSM, are running =
at
> the cores dedicated to the each different secure-enclave hardware IP(s).
> > Each firmware receives the message to act and response back with the
> completed act.
> > This message exchanges happens through the Message-Unit hardware
> interface.
> > There could be multiple MU for multiple security firmware, that would b=
e
> used for respective message exchanges.
> >
> > This node defines the details of each such MU interface.
> >
> > Reason to put under firmware:
> > 	Since this node specifies interface details between kernel and
> firmware, it was put under parent "firmware {".
> > 	I am not sure if this reason is correct enough to begin with.
> >
> > Thanks for allowing to revisit.
> >
> > I will make the change to whatever you finalize now. Thanks.
>=20
> I'm sorry, I still don't understand why you have the parent node. It seem=
s
> pointless to me, and this new node could be added at the top level.
Lately, I got this feedback in NXP internal as well.

Accepted. Will add it at the top level.
Thanks.

Help with the suggestion for the node name:
1. enclave-interface
	For multiple nodes, it will be:
	enclave-interface-0
	enclave-interface-1
	enclave-interface-2
2. secure-enclave
	For multiple nodes, it will be:
	secure-enclave-0
	secure-enclave-1
	secure-enclave-3

Or share any other suggested word(s).
Thanks.


