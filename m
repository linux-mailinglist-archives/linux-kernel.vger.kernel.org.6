Return-Path: <linux-kernel+bounces-202067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F9728FC773
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 11:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B385B24210
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 09:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E14E49645;
	Wed,  5 Jun 2024 09:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="q5W7kjTK"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2054.outbound.protection.outlook.com [40.107.20.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F85714BFAE;
	Wed,  5 Jun 2024 09:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717578946; cv=fail; b=ta0r+CmKRXpJq2HRmJcCYKPzFE4C0Xw5hglZeYBJQmmGhc/O7+xdlni0QjsetKzFGiiuqtD6/wGyTwPblGiP6b+ShezkNdHo2y6Ceok2X7vp67spIH9b7JqzEBObTmRhnAKBa48WY7fK7hQqw6t8NbLSePP/loTIQ7tdCH4M6xY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717578946; c=relaxed/simple;
	bh=dbHvw5Cj/xj7m2/dhdm8YBzmPCkVNo6AewO4LbHwIDE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hKsmesDCPIK2Eolm3Y5HxiJpJjMhXupLdSgE4PkQ1qvRbPRfplKMfVuk8uoKHsQrm2l3z+jKKehvwDlDznLnnZ2qSpylFM5nZA4lmvYv+Bpf+hoPQwIqGSKq8DYNN5PxLTUpZOZiMWRO+1hT9jCcWi6u6Ntl3Xl5V+WvR7h+s4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=q5W7kjTK; arc=fail smtp.client-ip=40.107.20.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HYKzaI9eIcOgHu3sflTHJ48I7u8k7AHtj9f93a9CZVoVKyZYiS8D7YcQgfUNE05Yy/Vgp39VxCz05kWyzxM+mdj8Fn29ju0CLJP5R1GbGK3XC9FKywXGwKOWXEm9gLfOVyztI0XQzbI8//StZWunZjZES0vAP1FexZR6eNSHkMG59vbIapVLHydIfaEkcPsazE5VLVTByeX8FumiYTzJRE6Uy7T38d410sl1GZ5HSczN5UppPBjCgCbKMYGGsx1sOLjJfhPpCiexG22FZzw3XuEY0Gc02vE8zEpIx9WNV59wbqe3zRHE/3qJS/FPFdY7ceCOpMqR3+dqWC21YZtxig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/uBvgno0uBC66zISuN4XsaRK04N9shnS7OFengdt68U=;
 b=GDjO/lopsGpNhqXIYejHpVMMUdy3sjGnZdpbLf6usYLFqPEJT005ia37ErMRjzcQKE2UaCpKbS+wNQkqw/wqpFF36GaDrDXNxusBBtqZKbFNx3NRU4Mfhz82CCDiokFdssH/Mx6legOFqVbfPnCkoqQZ4yFI/ksoaSt40lpdqOBv2Z+NXHNgi90nBb+xkHccHiaqvwYLGFuVuJ1+BxpqKfFNow2s/TBr3eXfPlPAmWUb8ZAc/YGzv5p+0xNgy6fxCUMFpv23UET0QilEv7CM7LklozBaThlp3eGQwAQJx7f8zRUu9W/RqEgV6PJNn2slKDVikZgSVBhgTWB+ky8UvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/uBvgno0uBC66zISuN4XsaRK04N9shnS7OFengdt68U=;
 b=q5W7kjTKO/DYFeKPH3KMpTU91e5kGgeT36gZ+3PFMJaexDXrjKGzIr+2N7/1j3olDye1lgle8P0Pu1qJLE+0yApa2rm5Qffg1BwEzAIufeXPSpjFkk1IRZmGrAeJRRh/QhwqBskriK7SJ9ruog8L/oXr9iiPmIGdrSvHnziPMT8=
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by DU4PR04MB10484.eurprd04.prod.outlook.com (2603:10a6:10:564::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Wed, 5 Jun
 2024 09:15:38 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%5]) with mapi id 15.20.7633.021; Wed, 5 Jun 2024
 09:15:37 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
To: Amit Singh Tomar <amitsinght@marvell.com>, Jonathan Corbet
	<corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
	<festevam@gmail.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>
CC: "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] [PATCH v2 5/5] firmware: imx: adds miscdev
Thread-Topic: [EXT] [PATCH v2 5/5] firmware: imx: adds miscdev
Thread-Index: AQHarP9e6ZcFPGAJSk+wtTuaFLEKr7G2SogAgAKsxZA=
Date: Wed, 5 Jun 2024 09:15:37 +0000
Message-ID:
 <AM9PR04MB860404A9EC45723E1EBE134A95F92@AM9PR04MB8604.eurprd04.prod.outlook.com>
References: <20240523-imx-se-if-v2-0-5a6fd189a539@nxp.com>
 <20240523-imx-se-if-v2-5-5a6fd189a539@nxp.com>
 <2a9693e3-cd13-4161-9671-0f5175aedf38@marvell.com>
In-Reply-To: <2a9693e3-cd13-4161-9671-0f5175aedf38@marvell.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8604:EE_|DU4PR04MB10484:EE_
x-ms-office365-filtering-correlation-id: 4d339e47-c585-45a2-80e0-08dc85401064
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|1800799015|366007|376005|7416005|921011|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?fn01M1N4sXOTF/fPmGpLuGI/8ZJB9KEu5oJFdG5bNBp1zNB/O58EzarfI8S5?=
 =?us-ascii?Q?vryN8zWXc0FoereVd/fLGnjUsmN/kwPsTODZPJaQBw21XW5gDSTeRWG25FuO?=
 =?us-ascii?Q?3QY2d88GL9wA0QqSaO9vawP+aJyUr2nfhwT6zvTDzXxaG/pwTpazFXXqMjhy?=
 =?us-ascii?Q?aFurFwIQQ6kuWSIvBAswNxv3bWoxMxZTf5homMuRn4IwYRHl5CSLB6BsqKPh?=
 =?us-ascii?Q?Q6qmqxDqwDZ9Bl501FxQFQbw68H1mvzvMNKBAvpUB0GyBLRzhVJYWHOc7YUF?=
 =?us-ascii?Q?xIX1k6WcivXyPZwPdRy5dyWeH/ITPicPpROREPRk4j9zrvEDAb300OGmG5EK?=
 =?us-ascii?Q?BJXqezyu2WsDsPgV5I6qhryysu0LsvYil2FcaUMbpgrQvuSBWdwQxUmWZMG4?=
 =?us-ascii?Q?SirNNv734f53VnyDrGashGsVeaDdamNtyzQT7CRF4Y8Be7nFKQNOfDve8rWR?=
 =?us-ascii?Q?JzqvKG9gcp56c7BcvwE4sSKQifthAcfv0HjwiFCq2Vl1GBWxLjUSDWFfUQYt?=
 =?us-ascii?Q?ESpcgjVIjodp3F0S6RFu76YJpWG1w41650q7B3WI2IyOKujuYkB+7y4KcXcV?=
 =?us-ascii?Q?1l/Clq3d02sa0Sfx8p6PLD5KewTJ4eX1lViXRWs6+f0zPvVRyRxu8MGD+zJc?=
 =?us-ascii?Q?OImuEyLvAugkPq/yZU7LVgoAc30KEoC467VRInEWrGO7y1YzzUdFxR9qnlVR?=
 =?us-ascii?Q?k/lqG+qqtuhE+jtXFXM1s3Ci7MjRD2wR2odk/LAgs4XPvyrQ/VUjEQWXoW4s?=
 =?us-ascii?Q?xK+kkzN/GzygdPNIM1TbCOcS+EP2auya4UrRsFJ6JMpY+ykIhod9i83e3KRF?=
 =?us-ascii?Q?niEbH9TDugmkKbyCPD0OyFG+VDzpUaCxBXGEHsIghjQkDIHodG8pJzHxcvue?=
 =?us-ascii?Q?JSpbTjcgOA9LgmyDNNEl94Qg1AQ0RDN2jRzD7jhT0dyH02u7UlXcZLeu9azp?=
 =?us-ascii?Q?CPCoPzxFs3Oi3BlkmxafxMoicb5XF1qvqDQLY+3xmaVVIYvIK4IRqjGDOhl3?=
 =?us-ascii?Q?Su7uqXQbsZJTeMR61BAeWn+jNRZJ9vWdxuVVambGnI08jF1kCyx5nNQ4SJNn?=
 =?us-ascii?Q?VwiiDi1yVZQvyQLftrT+pIj66GXGFbNCMeKlf1gju3GE+G5jznzx2CGannSv?=
 =?us-ascii?Q?xI9HgKlIIRJNfeMcECCbX4zkOaj6NAE/PJVuCDrWnr6Lrv08uTFdGG9TChoj?=
 =?us-ascii?Q?/vLTEBzBZWMBy4TDktBSu6rEqYOAejQZ3vcfGireBbCxxLqD9eLdl3LW5VDd?=
 =?us-ascii?Q?k8eVVYQXmfvRcnYSYtHjg0jIz+eo6iHwAlaLZVld4dW7VNTvGFmBaxaEVNEz?=
 =?us-ascii?Q?WZtur2QnqhDdTvtATHBBs21QswdS0DoXYVWK9gbZ91nCyHZyL7lSlBe2/Vik?=
 =?us-ascii?Q?uxlmxYM=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(7416005)(921011)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?uI6Tx5LG1/rET700rC6wOkiRxKJRpjKtbP6DT0Ysl7J5SoXRZXwrF9PMY5mM?=
 =?us-ascii?Q?OivIWHNp1MiXWauM+DwACKMxkilJoPwQxUkPH0jU/djjo6bMyAOWtLV6ffN6?=
 =?us-ascii?Q?ABZZ390vSRDbNCz03a6ZrYRSi99BhJnkLHxn8mg0A6S8scOKMJK5ho0SBJu7?=
 =?us-ascii?Q?CjGVF0U/bOSu+D1hsdU3JJbvjpxR/1RJZidr7roxGahVA+rcrG0A+xQR6WFP?=
 =?us-ascii?Q?noe76eN6FkfSJuKOcvNbtCaJfFuT9CR4k17af+p8M+Rbc53FOZIMHx6cnnOV?=
 =?us-ascii?Q?uPheo/dhXHvNCiCagND87klWwM0I8Xenn94KCHUahukkqjC4aMRazfAkdjHT?=
 =?us-ascii?Q?4nm9ZEtPd/jPUYBvy4hyTI8D+4raz0mN72tLz81khzhg04jmKT/be13kUb4X?=
 =?us-ascii?Q?d3uBVZ7JqiWABn1A3d3CAQeQYPn4rv6HDPdzjl4uJi6Jo6U1lUSi7ieIbxOA?=
 =?us-ascii?Q?RVR8OvybxP4VH4ka9+TWAWifbgTgTNGeXw2uX3MW0QGx6P1PH/eN/Vq1qyno?=
 =?us-ascii?Q?B/oODN9NU0tWyjj3Va3b1a3VRGDPxJks/Vw6T56GpkIRtzPpW1LRVGAiFnFv?=
 =?us-ascii?Q?6t5uSqu/17UUKmaVqG0fZauJj9qbDWneTc2ZEozgEm/HaY6psCM+Ru3XRjIu?=
 =?us-ascii?Q?C8qxBNuiBfIAJr7G7K34LD3fdAzB1NhmTCHXjvPK3878qP5HrRgNPI8lQvVO?=
 =?us-ascii?Q?kJhOX1sd5y0NJIoFFPZq9zzoZw8KIAd83cNYpteG4oOnuiFoqwIBNcAItlNm?=
 =?us-ascii?Q?CUa9hdFHnKfjm/+HttthEzMy0/XwVdzwX9vykd7Co9JTHw/EQMDlSutA61jk?=
 =?us-ascii?Q?D1dKXZ7clPBrisYkAKy9TzBQ3++xgrdKYqueQqkpSOT8r9OOKN/Dh3li66jQ?=
 =?us-ascii?Q?StsCq1YPfjRvq5m06kFoNooxCn4zWMyc6utMIgGIEUSwvSaMRtzshP505guS?=
 =?us-ascii?Q?vvCcA1oZtRVkDoL7QBk4ZctV7S0GohFNG9qitSA8b7vi9VK7G/np6l2yBLWM?=
 =?us-ascii?Q?d+PthmbcJ5TuhqbSi6EpPFBk9MyRqEjC/NwtJ5RPLxdNTCAevX2FRiEVXQFg?=
 =?us-ascii?Q?+HkKVBwySmljAoQYPC/MJmvE+y3Q7oAdE5XAWskTfWujNNhgu+ZzpNYFlYdh?=
 =?us-ascii?Q?7udKjBhfokBKwqAVAr5RVGLpEdc7sTGT+8LCf640hIQEd/1SbmRaGJrmMVsE?=
 =?us-ascii?Q?d/a6neXYR8izfVbUMeyLlxTotoTZmHKgtKP5HieJalK/leBapgky2YnKdbhj?=
 =?us-ascii?Q?3cPc99zCAAccX1nLaDfRL9jEq/lOWTyHlAXhpEEDmA0kqHAxiLIdlclAdsJ+?=
 =?us-ascii?Q?B3LDoomrw+WAAuimSiLBu4/WZpI3k2yrB5MtR6gMO8njcH2dmatagg4GOGt5?=
 =?us-ascii?Q?SaUxxpk3yvHDObMdrpYOX+jij1JI9QeiDjnH4Afj5DI6WMYlB11sZr7Z3Gs6?=
 =?us-ascii?Q?bO+B4bR/eJw+1ynGlFFQ9IAxMRVnLlLqw7NF+2zuZkImHIJDU9a+HppMGEsy?=
 =?us-ascii?Q?4pgree3gPxg6QZVdepFzKDjt0og8RVH2Bxjb41NzZeD8VpdXPoUnTippZP7x?=
 =?us-ascii?Q?zOAU3uBaNpH57KhDpLieIVMkftq5ds9PMHtyrVyz?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d339e47-c585-45a2-80e0-08dc85401064
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2024 09:15:37.8830
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b5szwrgfBdS1hSoKNeziWzcJCPjSpe/mjmu5Dbcc3quk1dZSCCf3zfG6uoqjELddOxaWqUGyO8loXh8UjxKG3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10484



> -----Original Message-----
> From: Amit Singh Tomar <amitsinght@marvell.com>
> Sent: Monday, June 3, 2024 9:53 PM
> To: Pankaj Gupta <pankaj.gupta@nxp.com>; Jonathan Corbet
> <corbet@lwn.net>; Rob Herring <robh+dt@kernel.org>; Krzysztof Kozlowski
> <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley <conor+dt@kernel.org>;
> Shawn Guo <shawnguo@kernel.org>; Sascha Hauer
> <s.hauer@pengutronix.de>; Pengutronix Kernel Team
> <kernel@pengutronix.de>; Fabio Estevam <festevam@gmail.com>; Rob
> Herring <robh@kernel.org>; Krzysztof Kozlowski <krzk+dt@kernel.org>
> Cc: linux-doc@vger.kernel.org; linux-kernel@vger.kernel.org;
> devicetree@vger.kernel.org; imx@lists.linux.dev; linux-arm-
> kernel@lists.infradead.org
> Subject: [EXT] [PATCH v2 5/5] firmware: imx: adds miscdev
>=20
> Caution: This is an external email. Please take care when clicking links =
or
> opening attachments. When in doubt, report the message using the 'Report
> this email' button
>=20
>=20
> Hi,
>=20
> >
> > ----------------------------------------------------------------------
> > Adds the driver for communication interface to secure-enclave, for
> > exchanging messages with NXP secure enclave HW IP(s) like EdgeLock
> > Enclave from:
> > - User-Space Applications via character driver.
> >
> > ABI documentation for the NXP secure-enclave driver.
> >
> > User-space library using this driver:
> > - i.MX Secure Enclave library:
> >    -- URL:
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Furl=
d
> > efense.proofpoint.com%2Fv2%2Furl%3Fu%3Dhttps-3A__github.com_nxp-
> 2Dimx_
> > imx-2Dsecure-
> 2Denclave.git%26d%3DDwICAg%26c%3DnKjWec2b6R0mOyPaz7xtfQ%2
> > 6r%3DV_GK7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-
> JKU%26m%3D8xuiz3OEyshbkzL
> > Q6-
> G2afLkh7sVv9b_HkFaPJVBu4wjmgAowHGi90q5RTroZ2oy%26s%3Dxi3fO_c9z_t
> -zd
> > k3LdTGgqJ6M-5OjRD6oj-
> ECiVQ40Q%26e%3D&data=3D05%7C02%7Cpankaj.gupta%40nxp
> > .com%7Cf63cdafaf0fe4a191a3108dc83e97a8a%7C686ea1d3bc2b4c6fa92cd
> 99c5c30
> >
> 1635%7C0%7C0%7C638530286027736635%7CUnknown%7CTWFpbGZsb3d8e
> yJWIjoiMC4w
> >
> LjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C
> %7C&sd
> >
> ata=3DKHyEla5aGRaS8tMOBYAbsYWxUPO%2BxBploTHqvGwMSuA%3D&reserve
> d=3D0 ,
> > - i.MX Secure Middle-Ware:
> >    -- URL:
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Furl=
d
> > efense.proofpoint.com%2Fv2%2Furl%3Fu%3Dhttps-3A__github.com_nxp-
> 2Dimx_
> > imx-
> 2Dsmw.git%26d%3DDwICAg%26c%3DnKjWec2b6R0mOyPaz7xtfQ%26r%3DV_
> GK7jRu
> > CHDErm6txmgDK1-MbUihtnSQ3gPgB-A-JKU%26m%3D8xuiz3OEyshbkzLQ6-
> G2afLkh7sV
> >
> v9b_HkFaPJVBu4wjmgAowHGi90q5RTroZ2oy%26s%3DjPOlKXqt_GIZGMvMbo
> Odjkwu3UT
> >
> pZ7fwEFm8Ki5z0LE%26e%3D&data=3D05%7C02%7Cpankaj.gupta%40nxp.com%
> 7Cf63cda
> >
> faf0fe4a191a3108dc83e97a8a%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0
> %7C0%
> >
> 7C638530286027747831%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjA
> wMDAiLCJQI
> >
> joiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3DEw
> UWiVl5q
> > fKjdEgOm6J0cvg%2FmeLKo%2FQxetXPWJlNUDY%3D&reserved=3D0
> >
> > Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> > ---
> >   Documentation/ABI/testing/se-cdev |  42 +++
> >   drivers/firmware/imx/ele_common.c | 108 +++++-
> >   drivers/firmware/imx/ele_common.h |   3 +
> >   drivers/firmware/imx/se_ctrl.c    | 689
> ++++++++++++++++++++++++++++++++++++++
> >   drivers/firmware/imx/se_ctrl.h    |  46 +++
> >   include/uapi/linux/se_ioctl.h     |  88 +++++
> >   6 files changed, 974 insertions(+), 2 deletions(-)
> >
> > diff --git a/Documentation/ABI/testing/se-cdev
> > b/Documentation/ABI/testing/se-cdev
> > new file mode 100644
> > index 000000000000..699525af6b86
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/se-cdev
> > @@ -0,0 +1,42 @@
> > +What:                /dev/<se>_mu[0-9]+_ch[0-9]+
> > +Date:                May 2024
> > +KernelVersion:       6.8
> > +Contact:     linux-imx@nxp.com, pankaj.gupta@nxp.com
> > +Description:
> > +             NXP offers multiple hardware IP(s) for  secure-enclaves l=
ike
> EdgeLock-
> > +             Enclave(ELE), SECO. The character device file-descriptors
> > +             /dev/<se>_mu*_ch* are the interface between user-space NX=
P's
> secure-
> > +             enclave shared-library and the kernel driver.
> > +
> > +             The ioctl(2)-based ABI is defined and documented in
> > +             [include]<linux/firmware/imx/ele_mu_ioctl.h>
> > +              ioctl(s) are used primarily for:
> > +                     - shared memory management
> > +                     - allocation of I/O buffers
> > +                     - get mu info
> > +                     - setting a dev-ctx as receiver that is slave to =
fw
> > +                     - get SoC info
> > +
> > +             The following file operations are supported:
> > +
> > +             open(2)
> > +               Currently the only useful flags are O_RDWR.
> > +
> > +             read(2)
> > +               Every read() from the opened character device context i=
s waiting
> on
> > +               wakeup_intruptible, that gets set by the registered mai=
lbox
> callback
> > +               function; indicating a message received from the firmwa=
re on
> message-
> > +               unit.
> > +
> > +             write(2)
> > +               Every write() to the opened character device context ne=
eds to
> acquire
> > +               mailbox_lock, before sending message on to the message =
unit.
> > +
> > +             close(2)
> > +               Stops and free up the I/O contexts that was associated
> > +               with the file descriptor.
> > +
> > +Users:
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Furlde=
f
> ense.proofpoint.com%2Fv2%2Furl%3Fu%3Dhttps-3A__github.com_nxp-
> 2Dimx_imx-2Dsecure-
> 2Denclave.git%26d%3DDwICAg%26c%3DnKjWec2b6R0mOyPaz7xtfQ%26r%3D
> V_GK7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-
> JKU%26m%3D8xuiz3OEyshbkzLQ6-
> G2afLkh7sVv9b_HkFaPJVBu4wjmgAowHGi90q5RTroZ2oy%26s%3Dxi3fO_c9z_t
> -zdk3LdTGgqJ6M-5OjRD6oj-
> ECiVQ40Q%26e%3D&data=3D05%7C02%7Cpankaj.gupta%40nxp.com%7Cf63cda
> faf0fe4a191a3108dc83e97a8a%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0
> %7C0%7C638530286027754085%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC
> 4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C0%7C%
> 7C%7C&sdata=3DS20ZeHvRTa8ByxkD7znd5qbLitdcyuQOOmtdnak%2F9VQ%3D&
> reserved=3D0 ,
> > +
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Furlde=
f
> ense.proofpoint.com%2Fv2%2Furl%3Fu%3Dhttps-3A__github.com_nxp-
> 2Dimx_imx-
> 2Dsmw.git%26d%3DDwICAg%26c%3DnKjWec2b6R0mOyPaz7xtfQ%26r%3DV_
> GK7jRuCHDErm6txmgDK1-MbUihtnSQ3gPgB-A-
> JKU%26m%3D8xuiz3OEyshbkzLQ6-
> G2afLkh7sVv9b_HkFaPJVBu4wjmgAowHGi90q5RTroZ2oy%26s%3DjPOlKXqt_GI
> ZGMvMboOdjkwu3UTpZ7fwEFm8Ki5z0LE%26e%3D&data=3D05%7C02%7Cpank
> aj.gupta%40nxp.com%7Cf63cdafaf0fe4a191a3108dc83e97a8a%7C686ea1d3b
> c2b4c6fa92cd99c5c301635%7C0%7C0%7C638530286027758865%7CUnknown
> %7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haW
> wiLCJXVCI6Mn0%3D%7C0%7C%7C%7C&sdata=3DqusMAsOp5fGyER76rQNwsaFq
> WgOPhY755l42krUF%2Bok%3D&reserved=3D0
> > +             crypto/skcipher,
> > +             drivers/nvmem/imx-ocotp-ele.c
> > diff --git a/drivers/firmware/imx/ele_common.c
> > b/drivers/firmware/imx/ele_common.c
> > index c286c3d84d82..15fabc369b21 100644
> > --- a/drivers/firmware/imx/ele_common.c
> > +++ b/drivers/firmware/imx/ele_common.c
> > @@ -78,12 +78,98 @@ int imx_ele_msg_send_rcv(struct se_if_priv *priv,
> void *tx_msg, void *rx_msg)
> >       return err;
> >   }
> >
> > +int imx_ele_miscdev_msg_rcv(struct se_if_device_ctx *dev_ctx) {
> > +     struct se_msg_hdr *header =3D {0};
> > +     int err;
> > +
> > +     if (dev_ctx->priv->waiting_rsp_dev =3D=3D dev_ctx)
> > +             lockdep_assert_held(&dev_ctx->priv->se_if_cmd_lock);
> > +
> > +     err =3D wait_event_interruptible(dev_ctx->wq, dev_ctx->pending_hd=
r !=3D
> 0);
> > +     if (err)
> > +             dev_err(dev_ctx->dev,
> > +                     "%s: Err[0x%x]:Interrupted by signal.\n",
> > +                     dev_ctx->miscdev.name, err);
> > +
> > +     header =3D (struct se_msg_hdr *) dev_ctx->temp_resp;
> > +
> > +     if (header->tag =3D=3D dev_ctx->priv->rsp_tag) {
> > +             if (dev_ctx->priv->waiting_rsp_dev !=3D dev_ctx)
> > +                     dev_warn(dev_ctx->dev,
> > +                     "%s: Device context waiting for response mismatch=
.\n",
> > +                     dev_ctx->miscdev.name);
> > +             else
> > +                     dev_ctx->priv->waiting_rsp_dev =3D NULL;
> > +
> > +             mutex_unlock(&dev_ctx->priv->se_if_cmd_lock);
> > +     }
> > +
> > +     return err;
> > +}
> > +
> > +int imx_ele_miscdev_msg_send(struct se_if_device_ctx *dev_ctx,
> > +                          void *tx_msg, int tx_msg_sz) {
> > +     struct se_if_priv *priv =3D dev_ctx->priv;
> > +     struct se_msg_hdr *header;
> > +     int err;
> > +
> > +     header =3D (struct se_msg_hdr *) tx_msg;
> > +
> > +     /*
> > +      * Check that the size passed as argument matches the size
> > +      * carried in the message.
> > +      */
> > +     err =3D header->size << 2;
> > +
> > +     if (err !=3D tx_msg_sz) {
> > +             err =3D -EINVAL;
> > +             dev_err(priv->dev,
> > +                     "%s: User buffer too small\n",
> > +                             dev_ctx->miscdev.name);
> > +             goto exit;
> > +     }
> > +     /* Check the message is valid according to tags */
> > +     if (header->tag =3D=3D priv->cmd_tag) {
> > +             mutex_lock(&priv->se_if_cmd_lock);
>=20
> In the previous patch (4/5), you used 'guard' locks. Wouldn't it be bette=
r to
> use them here as well, considering the lock handling seems a bit dodgy (I
> mean, the way lock is released only under certain condition)?

There is a comment from Pengutronix.
I have created an IOCTL for send/receive, where I am locking and unlocking =
the command lock.

>=20
> > +             priv->waiting_rsp_dev =3D dev_ctx;
> > +     } else if (header->tag =3D=3D priv->rsp_tag) {
> > +             /* Check the device context can send the command */
> > +             if (dev_ctx !=3D priv->cmd_receiver_dev) {
> > +                     dev_err(priv->dev,
> > +                             "%s: Channel not configured to send resp =
to FW.",
> > +                             dev_ctx->miscdev.name);
> > +                     err =3D -EPERM;
> > +                     goto exit;
> > +             }
> > +     } else {
> > +             dev_err(priv->dev,
> > +                     "%s: The message does not have a valid TAG\n",
> > +                             dev_ctx->miscdev.name);
> > +             err =3D -EINVAL;
> > +             goto exit;
> > +     }
> > +     err =3D imx_ele_msg_send(priv, tx_msg);
> > +     if (err < 0) {
> > +             if (header->tag =3D=3D priv->cmd_tag) {
> > +                     priv->waiting_rsp_dev =3D NULL;
> > +                     mutex_unlock(&dev_ctx->priv->se_if_cmd_lock);
> > +             }
> > +     } else
> > +             err =3D header->size << 2;
> > +exit:
> > +     return err;
> > +}
> > +
> >   /*
> >    * Callback called by mailbox FW, when data is received.
> >    */
> >   void se_if_rx_callback(struct mbox_client *mbox_cl, void *msg)
> >   {
> >       struct device *dev =3D mbox_cl->dev;
> > +     struct se_if_device_ctx *dev_ctx;
> > +     struct se_api_msg *rx_msg;
> >       struct se_if_priv *priv;
> >       struct se_msg_hdr *header;
> >
> > @@ -97,8 +183,15 @@ void se_if_rx_callback(struct mbox_client
> > *mbox_cl, void *msg)
> >
> >       header =3D (struct se_msg_hdr *) msg;
> >
> > -     if (header->tag =3D=3D priv->rsp_tag) {
> > -             if (!priv->waiting_rsp_dev) {
> > +     /* Incoming command: wake up the receiver if any. */
> > +     if (header->tag =3D=3D priv->cmd_tag) {
> > +             dev_dbg(dev, "Selecting cmd receiver\n");
> > +             dev_ctx =3D priv->cmd_receiver_dev;
> > +     } else if (header->tag =3D=3D priv->rsp_tag) {
> > +             if (priv->waiting_rsp_dev) {
> > +                     dev_dbg(dev, "Selecting rsp waiter\n");
> > +                     dev_ctx =3D priv->waiting_rsp_dev;
> > +             } else {
> >                       /*
> >                        * Reading the EdgeLock Enclave response
> >                        * to the command, sent by other @@ -116,6
> > +209,17 @@ void se_if_rx_callback(struct mbox_client *mbox_cl, void
> *msg)
> >                               *((u32 *) header));
> >               return;
> >       }
> > +     /* Init reception */
> > +     rx_msg =3D kzalloc(header->size << 2, GFP_KERNEL);
> > +     if (rx_msg)
> > +             memcpy(rx_msg, msg, header->size << 2);
> > +
> > +     dev_ctx->temp_resp =3D (u32 *)rx_msg;
> > +     dev_ctx->temp_resp_size =3D header->size;
> > +
> > +     /* Allow user to read */
> > +     dev_ctx->pending_hdr =3D 1;
> > +     wake_up_interruptible(&dev_ctx->wq);
> >   }
> >
> >   int validate_rsp_hdr(struct se_if_priv *priv, diff --git
> > a/drivers/firmware/imx/ele_common.h
> > b/drivers/firmware/imx/ele_common.h
> > index 76777ac629d6..11b9b36d4fda 100644
> > --- a/drivers/firmware/imx/ele_common.h
> > +++ b/drivers/firmware/imx/ele_common.h
> > @@ -12,6 +12,9 @@
> >   #define IMX_ELE_FW_DIR                 "imx/ele/"
> >
> >   uint32_t plat_add_msg_crc(uint32_t *msg, uint32_t msg_len);
> > +int imx_ele_miscdev_msg_rcv(struct se_if_device_ctx *priv); int
> > +imx_ele_miscdev_msg_send(struct se_if_device_ctx *dev_ctx,
> > +                          void *tx_msg, int tx_msg_sz);
> >   int imx_ele_msg_rcv(struct se_if_priv *priv);
> >   int imx_ele_msg_send(struct se_if_priv *priv, void *tx_msg);
> >   int imx_ele_msg_send_rcv(struct se_if_priv *priv, void *tx_msg, void
> > *rx_msg); diff --git a/drivers/firmware/imx/se_ctrl.c
> > b/drivers/firmware/imx/se_ctrl.c index 0642d349b3d3..3acaecd8f3bc
> > 100644
> > --- a/drivers/firmware/imx/se_ctrl.c
> > +++ b/drivers/firmware/imx/se_ctrl.c
> > @@ -23,6 +23,7 @@
> >   #include <linux/slab.h>
> >   #include <linux/string.h>
> >   #include <linux/sys_soc.h>
> > +#include <uapi/linux/se_ioctl.h>
> >
> >   #include "ele_base_msg.h"
> >   #include "ele_common.h"
> > @@ -232,6 +233,590 @@ static int imx_fetch_se_soc_info(struct device
> *dev)
> >       return 0;
> >   }
> >
> > +/*
> > + * File operations for user-space
> > + */
> > +
> > +/* Write a message to the MU. */
> > +static ssize_t se_if_fops_write(struct file *fp, const char __user *bu=
f,
> > +                             size_t size, loff_t *ppos) {
> > +     struct se_api_msg *tx_msg __free(kfree);
> > +     struct se_if_device_ctx *dev_ctx;
> > +     struct se_if_priv *priv;
> > +     int err;
> > +
> > +     dev_ctx =3D container_of(fp->private_data,
> > +                            struct se_if_device_ctx,
> > +                            miscdev);
> > +     priv =3D dev_ctx->priv;
> > +     dev_dbg(priv->dev,
> > +             "%s: write from buf (%p)%zu, ppos=3D%lld\n",
> > +                     dev_ctx->miscdev.name,
> > +                     buf, size, ((ppos) ? *ppos : 0));
> > +
> > +     if (down_interruptible(&dev_ctx->fops_lock))
> > +             return -EBUSY;
> > +
> > +     if (dev_ctx->status !=3D SE_IF_CTX_OPENED) {
> > +             err =3D -EINVAL;
> > +             goto exit;
> > +     }
> > +
> > +     if (size < SE_MU_HDR_SZ) {
> > +             dev_err(priv->dev,
> > +                     "%s: User buffer too small(%zu < %d)\n",
> > +                             dev_ctx->miscdev.name,
> > +                             size, SE_MU_HDR_SZ);
> > +             err =3D -ENOSPC;
> > +             goto exit;
> > +     }
> > +     tx_msg =3D memdup_user(buf, size);
> > +     if (!tx_msg) {
> > +             err =3D -ENOMEM;
> > +             goto exit;
> > +     }
> > +
> > +     print_hex_dump_debug("from user ", DUMP_PREFIX_OFFSET, 4, 4,
> > +                          tx_msg, size, false);
> > +
> > +     err =3D imx_ele_miscdev_msg_send(dev_ctx, tx_msg, size);
> > +
> > +exit:
> > +     up(&dev_ctx->fops_lock);
> > +     return err;
> > +}
> > +
> > +/*
> > + * Read a message from the MU.
> > + * Blocking until a message is available.
> > + */
> > +static ssize_t se_if_fops_read(struct file *fp, char __user *buf,
> > +                            size_t size, loff_t *ppos) {
> > +     struct se_if_device_ctx *dev_ctx;
> > +     struct se_buf_desc *b_desc;
> > +     struct se_if_priv *priv;
> > +     u32 size_to_copy;
> > +     int err;
> > +
> > +     dev_ctx =3D container_of(fp->private_data,
> > +                            struct se_if_device_ctx,
> > +                            miscdev);
> > +     priv =3D dev_ctx->priv;
> > +     dev_dbg(priv->dev,
> > +             "%s: read to buf %p(%zu), ppos=3D%lld\n",
> > +                     dev_ctx->miscdev.name,
> > +                     buf, size, ((ppos) ? *ppos : 0));
> > +
> > +     if (down_interruptible(&dev_ctx->fops_lock))
> > +             return -EBUSY;
> > +
> > +     if (dev_ctx->status !=3D SE_IF_CTX_OPENED) {
> > +             err =3D -EINVAL;
> > +             goto exit;
> > +     }
> > +
> > +     err =3D imx_ele_miscdev_msg_rcv(dev_ctx);
> > +     if (err)
> > +             goto exit;
> > +
> > +     /* Buffer containing the message from FW, is
> > +      * allocated in callback function.
> > +      * Check if buffer allocation failed.
> > +      */
> > +     if (!dev_ctx->temp_resp) {
> > +             err =3D -ENOMEM;
> > +             goto exit;
> > +     }
> > +
> > +     dev_dbg(priv->dev,
> > +                     "%s: %s %s\n",
> > +                     dev_ctx->miscdev.name,
> > +                     __func__,
> > +                     "message received, start transmit to user");
> > +
> > +     /*
> > +      * Check that the size passed as argument is larger than
> > +      * the one carried in the message.
> > +      */
> > +     size_to_copy =3D dev_ctx->temp_resp_size << 2;
> > +     if (size_to_copy > size) {
> > +             dev_dbg(priv->dev,
> > +                     "%s: User buffer too small (%zu < %d)\n",
> > +                             dev_ctx->miscdev.name,
> > +                             size, size_to_copy);
> > +             size_to_copy =3D size;
> > +     }
> > +
> > +     /*
> > +      * We may need to copy the output data to user before
> > +      * delivering the completion message.
> > +      */
> > +     while (!list_empty(&dev_ctx->pending_out)) {
> > +             b_desc =3D list_first_entry_or_null(&dev_ctx->pending_out=
,
> > +                                               struct se_buf_desc,
> > +                                               link);
> > +             if (!b_desc)
> > +                     continue;
> > +
> > +             if (b_desc->usr_buf_ptr && b_desc->shared_buf_ptr) {
> > +
> > +                     dev_dbg(priv->dev,
> > +                             "%s: Copy output data to user\n",
> > +                             dev_ctx->miscdev.name);
> > +                     if (copy_to_user(b_desc->usr_buf_ptr,
> > +                                      b_desc->shared_buf_ptr,
> > +                                      b_desc->size)) {
> > +                             dev_err(priv->dev,
> > +                                     "%s: Failure copying output data =
to user.",
> > +                                     dev_ctx->miscdev.name);
> > +                             err =3D -EFAULT;
> > +                             goto exit;
> > +                     }
> > +             }
> > +
> > +             if (b_desc->shared_buf_ptr)
> > +                     memset(b_desc->shared_buf_ptr, 0, b_desc->size);
> > +
> > +             __list_del_entry(&b_desc->link);
> > +             kfree(b_desc);
> > +     }
> > +
> > +     /* Copy data from the buffer */
> > +     print_hex_dump_debug("to user ", DUMP_PREFIX_OFFSET, 4, 4,
> > +                          dev_ctx->temp_resp, size_to_copy, false);
> > +     if (copy_to_user(buf, dev_ctx->temp_resp, size_to_copy)) {
> > +             dev_err(priv->dev,
> > +                     "%s: Failed to copy to user\n",
> > +                             dev_ctx->miscdev.name);
> > +             err =3D -EFAULT;
> > +             goto exit;
> > +     }
> > +
> > +     err =3D size_to_copy;
> > +     kfree(dev_ctx->temp_resp);
> > +
> > +     /* free memory allocated on the shared buffers. */
> > +     dev_ctx->secure_mem.pos =3D 0;
> > +     dev_ctx->non_secure_mem.pos =3D 0;
> > +
> > +     dev_ctx->pending_hdr =3D 0;
> > +
> > +exit:
> > +     /*
> > +      * Clean the used Shared Memory space,
> > +      * whether its Input Data copied from user buffers, or
> > +      * Data received from FW.
> > +      */
> > +     while (!list_empty(&dev_ctx->pending_in) ||
> > +            !list_empty(&dev_ctx->pending_out)) {
> > +             if (!list_empty(&dev_ctx->pending_in))
> > +                     b_desc =3D list_first_entry_or_null(&dev_ctx->pen=
ding_in,
> > +                                                       struct se_buf_d=
esc,
> > +                                                       link);
> > +             else
> > +                     b_desc =3D list_first_entry_or_null(&dev_ctx->pen=
ding_out,
> > +                                                       struct se_buf_d=
esc,
> > +                                                       link);
> > +
> > +             if (!b_desc)
> > +                     continue;
> > +
> > +             if (b_desc->shared_buf_ptr)
> > +                     memset(b_desc->shared_buf_ptr, 0, b_desc->size);
> > +
> > +             __list_del_entry(&b_desc->link);
> > +             kfree(b_desc);
> > +     }
> > +
> > +     up(&dev_ctx->fops_lock);
> > +     return err;
> > +}
> > +
> > +static int se_ioctl_get_mu_info(struct se_if_device_ctx *dev_ctx,
> > +                             u64 arg) {
> > +     struct se_if_priv *priv =3D dev_get_drvdata(dev_ctx->dev);
> > +     struct imx_se_node_info *if_node_info;
> > +     struct se_ioctl_get_if_info info;
> > +     int err =3D 0;
> > +
> > +     if_node_info =3D (struct imx_se_node_info *)priv->info;
> > +
> > +     info.se_if_id =3D if_node_info->se_if_id;
> > +     info.interrupt_idx =3D 0;
> > +     info.tz =3D 0;
> > +     info.did =3D if_node_info->se_if_did;
> > +     info.cmd_tag =3D if_node_info->cmd_tag;
> > +     info.rsp_tag =3D if_node_info->rsp_tag;
> > +     info.success_tag =3D if_node_info->success_tag;
> > +     info.base_api_ver =3D if_node_info->base_api_ver;
> > +     info.fw_api_ver =3D if_node_info->fw_api_ver;
> > +
> > +     dev_dbg(priv->dev,
> > +             "%s: info [se_if_id: %d, irq_idx: %d, tz: 0x%x, did: 0x%x=
]\n",
> > +                     dev_ctx->miscdev.name,
> > +                     info.se_if_id, info.interrupt_idx, info.tz,
> > + info.did);
> > +
> > +     if (copy_to_user((u8 *)arg, &info, sizeof(info))) {
> > +             dev_err(dev_ctx->priv->dev,
> > +                     "%s: Failed to copy mu info to user\n",
> > +                             dev_ctx->miscdev.name);
> > +             err =3D -EFAULT;
> > +             goto exit;
> > +     }
> > +
> > +exit:
> > +     return err;
> > +}
> > +
> > +/*
> > + * Copy a buffer of data to/from the user and return the address to
> > +use in
> > + * messages
> > + */
> > +static int se_ioctl_setup_iobuf_handler(struct se_if_device_ctx *dev_c=
tx,
> > +                                         u64 arg) {
> > +     struct se_shared_mem *shared_mem =3D NULL;
> > +     struct se_ioctl_setup_iobuf io =3D {0};
> > +     struct se_buf_desc *b_desc =3D NULL;
> > +     int err =3D 0;
> > +     u32 pos;
> > +
> > +     if (copy_from_user(&io, (u8 *)arg, sizeof(io))) {
> > +             dev_err(dev_ctx->priv->dev,
> > +                     "%s: Failed copy iobuf config from user\n",
> > +                             dev_ctx->miscdev.name);
> > +             err =3D -EFAULT;
> > +             goto exit;
> > +     }
> > +
> > +     dev_dbg(dev_ctx->priv->dev,
> > +                     "%s: io [buf: %p(%d) flag: %x]\n",
> > +                     dev_ctx->miscdev.name,
> > +                     io.user_buf, io.length, io.flags);
> > +
> > +     if (io.length =3D=3D 0 || !io.user_buf) {
> > +             /*
> > +              * Accept NULL pointers since some buffers are optional
> > +              * in FW commands. In this case we should return 0 as
> > +              * pointer to be embedded into the message.
> > +              * Skip all data copy part of code below.
> > +              */
> > +             io.ele_addr =3D 0;
> > +             goto copy;
> > +     }
> > +
> > +     /* Select the shared memory to be used for this buffer. */
> > +     if (io.flags & SE_MU_IO_FLAGS_USE_SEC_MEM) {
> > +             /* App requires to use secure memory for this buffer.*/
> > +             dev_err(dev_ctx->priv->dev,
> > +                     "%s: Failed allocate SEC MEM memory\n",
> > +                             dev_ctx->miscdev.name);
> > +             err =3D -EFAULT;
> > +             goto exit;
> > +     } else {
> > +             /* No specific requirement for this buffer. */
> > +             shared_mem =3D &dev_ctx->non_secure_mem;
> > +     }
> > +
> > +     /* Check there is enough space in the shared memory. */
> > +     if (shared_mem->size < shared_mem->pos
> > +                     || io.length >=3D shared_mem->size - shared_mem->=
pos) {
> > +             dev_err(dev_ctx->priv->dev,
> > +                     "%s: Not enough space in shared memory\n",
> > +                             dev_ctx->miscdev.name);
> > +             err =3D -ENOMEM;
> > +             goto exit;
> > +     }
> > +
> > +     /* Allocate space in shared memory. 8 bytes aligned. */
> > +     pos =3D shared_mem->pos;
> > +     shared_mem->pos +=3D round_up(io.length, 8u);
> > +     io.ele_addr =3D (u64)shared_mem->dma_addr + pos;
> > +
> > +     if ((io.flags & SE_MU_IO_FLAGS_USE_SEC_MEM) &&
> > +         !(io.flags & SE_MU_IO_FLAGS_USE_SHORT_ADDR)) {
> > +             /*Add base address to get full address.*/
> > +             dev_err(dev_ctx->priv->dev,
> > +                     "%s: Failed allocate SEC MEM memory\n",
> > +                             dev_ctx->miscdev.name);
> > +             err =3D -EFAULT;
> > +             goto exit;
> > +     }
> > +
> > +     memset(shared_mem->ptr + pos, 0, io.length);
> > +     if ((io.flags & SE_IO_BUF_FLAGS_IS_INPUT) ||
> > +         (io.flags & SE_IO_BUF_FLAGS_IS_IN_OUT)) {
> > +             /*
> > +              * buffer is input:
> > +              * copy data from user space to this allocated buffer.
> > +              */
> > +             if (copy_from_user(shared_mem->ptr + pos, io.user_buf,
> > +                                io.length)) {
> > +                     dev_err(dev_ctx->priv->dev,
> > +                             "%s: Failed copy data to shared memory\n"=
,
> > +                             dev_ctx->miscdev.name);
> > +                     err =3D -EFAULT;
> > +                     goto exit;
> > +             }
> > +     }
> > +
> > +     b_desc =3D kzalloc(sizeof(*b_desc), GFP_KERNEL);
> > +     if (!b_desc) {
> > +             err =3D -ENOMEM;
> > +             goto exit;
> > +     }
> > +
> > +copy:
> > +     /* Provide the EdgeLock Enclave address to user space only if
> success.*/
> > +     if (copy_to_user((u8 *)arg, &io, sizeof(io))) {
> > +             dev_err(dev_ctx->priv->dev,
> > +                     "%s: Failed to copy iobuff setup to user\n",
> > +                             dev_ctx->miscdev.name);
> > +             kfree(b_desc);
> > +             err =3D -EFAULT;
> > +             goto exit;
> > +     }
> > +
> > +     if (b_desc) {
> > +             b_desc->shared_buf_ptr =3D shared_mem->ptr + pos;
> > +             b_desc->usr_buf_ptr =3D io.user_buf;
> > +             b_desc->size =3D io.length;
> > +
> > +             if (io.flags & SE_IO_BUF_FLAGS_IS_INPUT) {
> > +                     /*
> > +                      * buffer is input:
> > +                      * add an entry in the "pending input buffers" li=
st so
> > +                      * that copied data can be cleaned from shared me=
mory
> > +                      * later.
> > +                      */
> > +                     list_add_tail(&b_desc->link, &dev_ctx->pending_in=
);
> > +             } else {
> > +                     /*
> > +                      * buffer is output:
> > +                      * add an entry in the "pending out buffers" list=
 so data
> > +                      * can be copied to user space when receiving Sec=
ure-
> Enclave
> > +                      * response.
> > +                      */
> > +                     list_add_tail(&b_desc->link, &dev_ctx->pending_ou=
t);
> > +             }
> > +     }
> > +
> > +exit:
> > +     return err;
> > +}
> > +
> > +/* IOCTL to provide SoC information */ static int
> > +se_ioctl_get_se_soc_info_handler(struct se_if_device_ctx *dev_ctx,
> > +                                          u64 arg) {
> > +     struct imx_se_node_info_list *info_list;
> > +     struct se_ioctl_get_soc_info soc_info;
> > +     int err =3D -EINVAL;
> > +
> > +     info_list =3D (struct imx_se_node_info_list *)
> > +                     device_get_match_data(dev_ctx->priv->dev);
> > +     if (!info_list)
> > +             goto exit;
> > +
> > +     soc_info.soc_id =3D info_list->soc_id;
> > +     soc_info.soc_rev =3D dev_ctx->priv->soc_rev;
> > +
> > +     err =3D (int)copy_to_user((u8 *)arg, (u8 *)(&soc_info), sizeof(so=
c_info));
> > +     if (err) {
> > +             dev_err(dev_ctx->priv->dev,
> > +                     "%s: Failed to copy soc info to user\n",
> > +                     dev_ctx->miscdev.name);
> > +             err =3D -EFAULT;
> > +             goto exit;
> > +     }
> > +
> > +exit:
> > +     return err;
> > +}
> > +
> > +/* Open a character device. */
> > +static int se_if_fops_open(struct inode *nd, struct file *fp) {
> > +     struct se_if_device_ctx *dev_ctx =3D container_of(fp->private_dat=
a,
> > +                                                     struct se_if_devi=
ce_ctx,
> > +                                                     miscdev);
> > +     int err =3D 0;
> > +
> > +     /* Avoid race if opened at the same time */
> > +     if (down_trylock(&dev_ctx->fops_lock))
> > +             return -EBUSY;
> > +
> > +     /* Authorize only 1 instance. */
> > +     if (dev_ctx->status !=3D SE_IF_CTX_FREE) {
> > +             err =3D -EBUSY;
> > +             goto exit;
> > +     }
> > +
> > +     /*
> > +      * Allocate some memory for data exchanges with S40x.
> > +      * This will be used for data not requiring secure memory.
> > +      */
> > +     dev_ctx->non_secure_mem.ptr =3D dmam_alloc_coherent(dev_ctx->dev,
> > +                                     MAX_DATA_SIZE_PER_USER,
> > +                                     &dev_ctx->non_secure_mem.dma_addr=
,
> > +                                     GFP_KERNEL);
> > +     if (!dev_ctx->non_secure_mem.ptr) {
> > +             err =3D -ENOMEM;
> > +             goto exit;
> > +     }
> > +
> > +     dev_ctx->non_secure_mem.size =3D MAX_DATA_SIZE_PER_USER;
> > +     dev_ctx->non_secure_mem.pos =3D 0;
> > +     dev_ctx->status =3D SE_IF_CTX_OPENED;
> > +
> > +     dev_ctx->pending_hdr =3D 0;
> > +
> > +     goto exit;
> > +
> > +     dmam_free_coherent(dev_ctx->priv->dev, MAX_DATA_SIZE_PER_USER,
> > +                        dev_ctx->non_secure_mem.ptr,
> > +                        dev_ctx->non_secure_mem.dma_addr);
> > +
> > +exit:
> > +     up(&dev_ctx->fops_lock);
> > +     return err;
> > +}
> > +
> > +/* Close a character device. */
> > +static int se_if_fops_close(struct inode *nd, struct file *fp) {
> > +     struct se_if_device_ctx *dev_ctx =3D container_of(fp->private_dat=
a,
> > +                                                     struct se_if_devi=
ce_ctx,
> > +                                                     miscdev);
> > +     struct se_if_priv *priv =3D dev_ctx->priv;
> > +     struct se_buf_desc *b_desc;
> > +
> > +     /* Avoid race if closed at the same time */
> > +     if (down_trylock(&dev_ctx->fops_lock))
> > +             return -EBUSY;
> > +
> > +     /* The device context has not been opened */
> > +     if (dev_ctx->status !=3D SE_IF_CTX_OPENED)
> > +             goto exit;
> > +
> > +     /* check if this device was registered as command receiver. */
> > +     if (priv->cmd_receiver_dev =3D=3D dev_ctx)
> > +             priv->cmd_receiver_dev =3D NULL;
> > +
> > +     /* check if this device was registered as waiting response. */
> > +     if (priv->waiting_rsp_dev =3D=3D dev_ctx) {
> > +             priv->waiting_rsp_dev =3D NULL;
> > +             mutex_unlock(&priv->se_if_cmd_lock);
> > +     }
> > +
> > +     /* Unmap secure memory shared buffer. */
> > +     if (dev_ctx->secure_mem.ptr)
> > +             devm_iounmap(dev_ctx->dev, dev_ctx->secure_mem.ptr);
> > +
> > +     dev_ctx->secure_mem.ptr =3D NULL;
> > +     dev_ctx->secure_mem.dma_addr =3D 0;
> > +     dev_ctx->secure_mem.size =3D 0;
> > +     dev_ctx->secure_mem.pos =3D 0;
> > +
> > +     /* Free non-secure shared buffer. */
> > +     dmam_free_coherent(dev_ctx->priv->dev, MAX_DATA_SIZE_PER_USER,
> > +                        dev_ctx->non_secure_mem.ptr,
> > +                        dev_ctx->non_secure_mem.dma_addr);
> > +
> > +     dev_ctx->non_secure_mem.ptr =3D NULL;
> > +     dev_ctx->non_secure_mem.dma_addr =3D 0;
> > +     dev_ctx->non_secure_mem.size =3D 0;
> > +     dev_ctx->non_secure_mem.pos =3D 0;
> > +
> > +     while (!list_empty(&dev_ctx->pending_in) ||
> > +            !list_empty(&dev_ctx->pending_out)) {
> > +             if (!list_empty(&dev_ctx->pending_in))
> > +                     b_desc =3D list_first_entry_or_null(&dev_ctx->pen=
ding_in,
> > +                                                       struct se_buf_d=
esc,
> > +                                                       link);
> > +             else
> > +                     b_desc =3D list_first_entry_or_null(&dev_ctx->pen=
ding_out,
> > +                                                       struct se_buf_d=
esc,
> > +                                                       link);
> > +
> > +             if (!b_desc)
> > +                     continue;
> > +
> > +             if (b_desc->shared_buf_ptr)
> > +                     memset(b_desc->shared_buf_ptr, 0, b_desc->size);
> > +
> > +             __list_del_entry(&b_desc->link);
> > +             kfree(b_desc);
> > +     }
> > +
> > +     dev_ctx->status =3D SE_IF_CTX_FREE;
> > +
> > +exit:
> > +     up(&dev_ctx->fops_lock);
> > +     return 0;
> > +}
> > +
> > +/* IOCTL entry point of a character device */ static long
> > +se_ioctl(struct file *fp, unsigned int cmd, unsigned long arg) {
> > +     struct se_if_device_ctx *dev_ctx =3D container_of(fp->private_dat=
a,
> > +                                                     struct se_if_devi=
ce_ctx,
> > +                                                     miscdev);
> > +     struct se_if_priv *se_if_priv =3D dev_ctx->priv;
> > +     int err =3D -EINVAL;
> > +
> > +     /* Prevent race during change of device context */
> > +     if (down_interruptible(&dev_ctx->fops_lock))
> > +             return -EBUSY;
> > +
> > +     switch (cmd) {
> > +     case SE_IOCTL_ENABLE_CMD_RCV:
> > +             if (!se_if_priv->cmd_receiver_dev) {
> > +                     se_if_priv->cmd_receiver_dev =3D dev_ctx;
> > +                     err =3D 0;
> > +             }
> > +             break;
> > +     case SE_IOCTL_GET_MU_INFO:
> > +             err =3D se_ioctl_get_mu_info(dev_ctx, arg);
> > +             break;
> > +     case SE_IOCTL_SETUP_IOBUF:
> > +             err =3D se_ioctl_setup_iobuf_handler(dev_ctx, arg);
> > +             break;
> > +     case SE_IOCTL_GET_SOC_INFO:
> > +             err =3D se_ioctl_get_se_soc_info_handler(dev_ctx, arg);
> > +             break;
> > +
> > +     default:
> > +             err =3D -EINVAL;
> > +             dev_dbg(se_if_priv->dev,
> > +                     "%s: IOCTL %.8x not supported\n",
> > +                             dev_ctx->miscdev.name,
> > +                             cmd);
> > +     }
> > +
> > +     up(&dev_ctx->fops_lock);
> > +     return (long)err;
> > +}
> > +
> > +/* Char driver setup */
> > +static const struct file_operations se_if_fops =3D {
> > +     .open           =3D se_if_fops_open,
> > +     .owner          =3D THIS_MODULE,
> > +     .release        =3D se_if_fops_close,
> > +     .unlocked_ioctl =3D se_ioctl,
> > +     .read           =3D se_if_fops_read,
> > +     .write          =3D se_if_fops_write,
> > +};
> > +
> > +/* interface for managed res to unregister a character device */
> > +static void if_misc_deregister(void *miscdevice) {
> > +     misc_deregister(miscdevice);
> > +}
> > +
> >   /* interface for managed res to free a mailbox channel */
> >   static void if_mbox_free_channel(void *mbox_chan)
> >   {
> > @@ -270,6 +855,7 @@ static int se_probe_if_cleanup(struct
> platform_device *pdev)
> >       struct device *dev =3D &pdev->dev;
> >       struct se_if_priv *priv;
> >       int ret =3D 0;
> > +     int i;
> >
> >       priv =3D dev_get_drvdata(dev);
> >       if (!priv) {
> > @@ -294,6 +880,17 @@ static int se_probe_if_cleanup(struct
> platform_device *pdev)
> >               priv->imem.buf =3D NULL;
> >       }
> >
> > +     if (priv->ctxs) {
> > +             for (i =3D 0; i < priv->max_dev_ctx; i++) {
> > +                     if (priv->ctxs[i]) {
> > +                             devm_remove_action(dev,
> > +                                                if_misc_deregister,
> > +                                                &priv->ctxs[i]->miscde=
v);
> > +                             misc_deregister(&priv->ctxs[i]->miscdev);
> > +                     }
> > +             }
> > +     }
> > +
> >       if (priv->flags & RESERVED_DMA_POOL) {
> >               of_reserved_mem_device_release(dev);
> >               priv->flags &=3D (~RESERVED_DMA_POOL); @@ -302,6 +899,84
> > @@ static int se_probe_if_cleanup(struct platform_device *pdev)
> >       return ret;
> >   }
> >
> > +static int init_device_context(struct device *dev) {
> > +     const struct imx_se_node_info *info;
> > +     struct se_if_device_ctx *dev_ctx;
> > +     struct se_if_priv *priv;
> > +     u8 *devname;
> > +     int ret =3D 0;
> > +     int i;
> > +
> > +     priv =3D dev_get_drvdata(dev);
> > +
> > +     if (!priv) {
> > +             ret =3D -EINVAL;
> > +             dev_err(dev, "Invalid SE-MU Priv data");
> > +             return ret;
> > +     }
> > +     info =3D priv->info;
> > +
> > +     priv->ctxs =3D devm_kzalloc(dev, sizeof(dev_ctx) * priv->max_dev_=
ctx,
> > +                               GFP_KERNEL);
> > +
> > +     if (!priv->ctxs) {
> > +             ret =3D -ENOMEM;
> > +             return ret;
> > +     }
> > +
> > +     /* Create users */
> > +     for (i =3D 0; i < priv->max_dev_ctx; i++) {
> > +             dev_ctx =3D devm_kzalloc(dev, sizeof(*dev_ctx), GFP_KERNE=
L);
> > +             if (!dev_ctx) {
> > +                     ret =3D -ENOMEM;
> > +                     return ret;
> > +             }
> > +
> > +             dev_ctx->dev =3D dev;
> > +             dev_ctx->status =3D SE_IF_CTX_FREE;
> > +             dev_ctx->priv =3D priv;
> > +
> > +             priv->ctxs[i] =3D dev_ctx;
> > +
> > +             /* Default value invalid for an header. */
> > +             init_waitqueue_head(&dev_ctx->wq);
> > +
> > +             INIT_LIST_HEAD(&dev_ctx->pending_out);
> > +             INIT_LIST_HEAD(&dev_ctx->pending_in);
> > +             sema_init(&dev_ctx->fops_lock, 1);
> > +
> > +             devname =3D devm_kasprintf(dev, GFP_KERNEL, "%s_ch%d",
> > +                                      info->se_name, i);
> > +             if (!devname) {
> > +                     ret =3D -ENOMEM;
> > +                     return ret;
> > +             }
> > +
> > +             dev_ctx->miscdev.name =3D devname;
> > +             dev_ctx->miscdev.minor =3D MISC_DYNAMIC_MINOR;
> > +             dev_ctx->miscdev.fops =3D &se_if_fops;
> > +             dev_ctx->miscdev.parent =3D dev;
> > +             ret =3D misc_register(&dev_ctx->miscdev);
> > +             if (ret) {
> > +                     dev_err(dev, "failed to register misc device %d\n=
",
> > +                             ret);
> > +                     return ret;
> > +             }
> > +
> > +             ret =3D devm_add_action(dev, if_misc_deregister,
> > +                                   &dev_ctx->miscdev);
> > +             if (ret) {
> > +                     dev_err(dev,
> > +                             "failed[%d] to add action to the misc-dev=
\n",
> > +                             ret);
> > +                     return ret;
> > +             }
> > +     }
> > +
> > +     return ret;
> > +}
> > +
> >   static void se_load_firmware(const struct firmware *fw, void *context=
)
> >   {
> >       struct se_if_priv *priv =3D (struct se_if_priv *) context; @@
> > -461,6 +1136,16 @@ static int se_if_probe(struct platform_device *pdev)
> >               }
> >       }
> >
> > +     if (info->max_dev_ctx) {
> > +             ret =3D init_device_context(dev);
> > +             if (ret) {
> > +                     dev_err(dev,
> > +                             "Failed[0x%x] to create device contexts.\=
n",
> > +                             ret);
> > +                     goto exit;
> > +             }
> > +     }
> > +
> >       dev_info(dev, "i.MX secure-enclave: %s interface to firmware,
> configured.\n",
> >                info->se_name);
> >       return devm_of_platform_populate(dev); @@ -502,6 +1187,10 @@
> > static int se_resume(struct device *dev)
> >       struct se_if_priv *priv =3D dev_get_drvdata(dev);
> >       const struct imx_se_node_info *info
> >                                       =3D priv->info;
> > +     int i;
> > +
> > +     for (i =3D 0; i < priv->max_dev_ctx; i++)
> > +             wake_up_interruptible(&priv->ctxs[i]->wq);
> >
> >       if (info && info->imem_mgmt)
> >               se_restore_imem_state(dev); diff --git
> > a/drivers/firmware/imx/se_ctrl.h b/drivers/firmware/imx/se_ctrl.h
> > index 7d4f439a6158..41d9cedb05d7 100644
> > --- a/drivers/firmware/imx/se_ctrl.h
> > +++ b/drivers/firmware/imx/se_ctrl.h
> > @@ -13,15 +13,61 @@
> >   #define MAX_FW_LOAD_RETRIES         50
> >
> >   #define RES_STATUS(x)                       FIELD_GET(0x000000ff, x)
> > +#define MAX_DATA_SIZE_PER_USER               (65 * 1024)
> >   #define MESSAGING_VERSION_6         0x6
> >   #define MESSAGING_VERSION_7         0x7
> >
> > +#define SE_MU_IO_FLAGS_USE_SEC_MEM   (0x02u)
> > +#define SE_MU_IO_FLAGS_USE_SHORT_ADDR        (0x04u)
> > +
> >   struct se_imem_buf {
> >       u8 *buf;
> >       phys_addr_t phyaddr;
> >       u32 size;
> >   };
> >
> > +struct se_buf_desc {
> > +     u8 *shared_buf_ptr;
> > +     u8 *usr_buf_ptr;
> > +     u32 size;
> > +     struct list_head link;
> > +};
> > +
> > +/* Status of a char device */
> > +enum se_if_dev_ctx_status_t {
> > +     SE_IF_CTX_FREE,
> > +     SE_IF_CTX_OPENED
> > +};
> > +
> > +struct se_shared_mem {
> > +     dma_addr_t dma_addr;
> > +     u32 size;
> > +     u32 pos;
> > +     u8 *ptr;
> > +};
> > +
> > +/* Private struct for each char device instance. */ struct
> > +se_if_device_ctx {
> > +     struct device *dev;
> > +     struct se_if_priv *priv;
> > +     struct miscdevice miscdev;
> > +
> > +     enum se_if_dev_ctx_status_t status;
> > +     wait_queue_head_t wq;
> > +     struct semaphore fops_lock;
> > +
> > +     u32 pending_hdr;
> > +     struct list_head pending_in;
> > +     struct list_head pending_out;
> > +
> > +     struct se_shared_mem secure_mem;
> > +     struct se_shared_mem non_secure_mem;
> > +
> > +     u32 *temp_resp;
> > +     u32 temp_resp_size;
> > +     struct notifier_block se_notify; };
> > +
> >   /* Header of the messages exchange with the EdgeLock Enclave */
> >   struct se_msg_hdr {
> >       u8 ver;
> > diff --git a/include/uapi/linux/se_ioctl.h
> > b/include/uapi/linux/se_ioctl.h new file mode 100644 index
> > 000000000000..f68a36e9da2c
> > --- /dev/null
> > +++ b/include/uapi/linux/se_ioctl.h
> > @@ -0,0 +1,88 @@
> > +/* SPDX-License-Identifier: (GPL-2.0 WITH Linux-syscall-note) OR
> > +BSD-3-Clause*/
> > +/*
> > + * Copyright 2024 NXP
> > + */
> > +
> > +#ifndef SE_IOCTL_H
> > +#define SE_IOCTL_H
> > +
> > +/* IOCTL definitions. */
> > +
> > +struct se_ioctl_setup_iobuf {
> > +     u8 *user_buf;
> > +     u32 length;
> > +     u32 flags;
> > +     u64 ele_addr;
> > +};
> > +
> > +struct se_ioctl_shared_mem_cfg {
> > +     u32 base_offset;
> > +     u32 size;
> > +};
> > +
> > +struct se_ioctl_get_if_info {
> > +     u8 se_if_id;
> > +     u8 interrupt_idx;
> > +     u8 tz;
> > +     u8 did;
> > +     u8 cmd_tag;
> > +     u8 rsp_tag;
> > +     u8 success_tag;
> > +     u8 base_api_ver;
> > +     u8 fw_api_ver;
> > +};
> > +
> > +struct se_ioctl_signed_message {
> > +     u8 *message;
> > +     u32 msg_size;
> > +     u32 error_code;
> > +};
> > +
> > +struct se_ioctl_get_soc_info {
> > +     u16 soc_id;
> > +     u16 soc_rev;
> > +};
> > +
> > +/* IO Buffer Flags */
> > +#define SE_IO_BUF_FLAGS_IS_OUTPUT    (0x00u)
> > +#define SE_IO_BUF_FLAGS_IS_INPUT     (0x01u)
> > +#define SE_IO_BUF_FLAGS_USE_SEC_MEM  (0x02u)
> > +#define SE_IO_BUF_FLAGS_USE_SHORT_ADDR       (0x04u)
> > +#define SE_IO_BUF_FLAGS_IS_IN_OUT    (0x10u)
> > +
> > +/* IOCTLS */
> > +#define SE_IOCTL                     0x0A /* like MISC_MAJOR. */
> > +
> > +/*
> > + * ioctl to designated the current fd as logical-reciever.
> > + * This is ioctl is send when the nvm-daemon, a slave to the
> > + * firmware is started by the user.
> > + */
> > +#define SE_IOCTL_ENABLE_CMD_RCV      _IO(SE_IOCTL, 0x01)
> > +
> > +/*
> > + * ioctl to get the buffer allocated from the memory, which is shared
> > + * between kernel and FW.
> > + * Post allocation, the kernel tagged the allocated memory with:
> > + *  Output
> > + *  Input
> > + *  Input-Output
> > + *  Short address
> > + *  Secure-memory
> > + */
> > +#define SE_IOCTL_SETUP_IOBUF _IOWR(SE_IOCTL, 0x03, \
> > +                                     struct se_ioctl_setup_iobuf)
> > +
> > +/*
> > + * ioctl to get the mu information, that is used to exchange message
> > + * with FW, from user-spaced.
> > + */
> > +#define SE_IOCTL_GET_MU_INFO _IOR(SE_IOCTL, 0x04, \
> > +                                     struct se_ioctl_get_if_info)
> > +/*
> > + * ioctl to get SoC Info from user-space.
> > + */
> > +#define SE_IOCTL_GET_SOC_INFO      _IOR(SE_IOCTL, 0x06, \
> > +                                     struct se_ioctl_get_soc_info)
> > +
> > +#endif
> >


