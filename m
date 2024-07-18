Return-Path: <linux-kernel+bounces-255898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C39DB93465C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 04:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79FBC282974
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jul 2024 02:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7361438DE5;
	Thu, 18 Jul 2024 02:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="GkNTQn3a"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013068.outbound.protection.outlook.com [52.101.67.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC7128DA0;
	Thu, 18 Jul 2024 02:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721269460; cv=fail; b=ty1WSiS4vst3W3jHagteGnm7KUd/T74b9qqdtpuBbpNkudVIvfWSqlqcgdMX5xBg4WBbRDlkGz4KunAXBls0OR9VT5d3nuYmMIullZhwAq5MKM2eqvww8qfpSusiItnNgfNwLAeFFWdrtGtxqcDuPSOD3+XVS93ujTXmGMD820U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721269460; c=relaxed/simple;
	bh=Z3aZWqQwXCldDFQv0o8vYcj/TyQiQK16uu2G6QqokyA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AoTcTu+j2rSRGa1tEyRe5HGMI4VA+7Lw8qeGsM2X7kKotQyQc+/042a5O/pVRyAWg32/xu+hplxjD4rTFL9vrO2azM9YE+39GuOcwd4DmPg2kafqME6zEyMra/0yJmGgcDBZWK1zfQjBEI6qpTCpouay5E+mtEIqFblkPZPQxTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=GkNTQn3a; arc=fail smtp.client-ip=52.101.67.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yHF7L1n4DsFH+ta5X0OVa7oM5vFseLMwrYmTe2AbAruyrygQ0QKjcDZDJKFlFeeEJAmTn4Atod948vPsGzMBRtlBEfJiTIBhexu7fspP7SBhQBfrmuaI55BmYn4d/2cQxRw9xWCd3ThfujHBDpWSIiEfwBEDC1WkcVWh4mLe43HCb0MZqHWg+jc1KEvGiapLzmBqceJoEYTTG2Cpk8Q4U9QJEb6DL6zWB+eW8MH/xRU1ZEYtk36UQTr5RqvmmDSBn/2wlemPo6LhbHdkyhqDIBe8U7XBUhpeRtqJ/0WFRJGxZErkf8arwnmS5INGEfnNjSra2ClTz9tEmDT8f5CCaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z3aZWqQwXCldDFQv0o8vYcj/TyQiQK16uu2G6QqokyA=;
 b=DPG+r4t/xShKiEpL4/3gM+urXK2oi7rzPvjsiTcqkveY0zyX1jaRrqF8CibmpT8FcAD+ma59NT5w6CctD6ukNiTSrBL3Gyb0TiVg5YXLQBsLJmeYDLbPDgWO4WqRJU0wWyPCx2ma5+NJvLMSNar/KfthZSXPQUxXm4D3KPmyftCRgKZ+/kWh3kveOOkRbl1+6pCbGLtk3Cu0Rl4GwuOUeOzlTh/J+Dkfg1QJ1//yeiNEpEPW+k0Mf9LDlTNp4nxyAzIcfYfmLoWkZYIV3Xy5gWD6ZFFyBHIYj3CpdwJeW+eoiCFKmjTy0A3Y6i8lxIYll8kef/D6aJATPnQaE+k82g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z3aZWqQwXCldDFQv0o8vYcj/TyQiQK16uu2G6QqokyA=;
 b=GkNTQn3ajbq6WOZXFZgRKz3HX8mo80vkfNRdyKkDNdKDDOT86PgykzHnWVSJCloa1Bh3ZV/LlS8r4lsmODY9AXfDZDtk7sMYkSJbdDaYwR3z8LlZmDPtXbwySJvXpmWYXmGkYeGvOibj33kRRi4WGmEa1Bml9nfqc755BVsQLSo=
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB8120.eurprd04.prod.outlook.com (2603:10a6:20b:3f1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.18; Thu, 18 Jul
 2024 02:24:15 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.7762.020; Thu, 18 Jul 2024
 02:24:15 +0000
From: Peng Fan <peng.fan@nxp.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, "sudeep.holla@arm.com"
	<sudeep.holla@arm.com>, "cristian.marussi@arm.com"
	<cristian.marussi@arm.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "arm-scmi@vger.kernel.org"
	<arm-scmi@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: RE: [PATCH V3 2/2] firmware: arm_scmi: set mailbox timeout value from
 device tree
Thread-Topic: [PATCH V3 2/2] firmware: arm_scmi: set mailbox timeout value
 from device tree
Thread-Index: AQHa0gh1nzSgPeT6CEaXte3Yk8eLv7H7zrKg
Date: Thu, 18 Jul 2024 02:24:15 +0000
Message-ID:
 <PAXPR04MB84594F4271F68D9072BA0C0D88AC2@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240709140957.3171255-1-peng.fan@oss.nxp.com>
 <20240709140957.3171255-2-peng.fan@oss.nxp.com>
In-Reply-To: <20240709140957.3171255-2-peng.fan@oss.nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|AS8PR04MB8120:EE_
x-ms-office365-filtering-correlation-id: a637551f-f15b-4dbf-b0a1-08dca6d0b855
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?LYez3TcietOTPn3bUP0LbKBdiqZIiUz7Lc+anYT7o4fJ1G6pJdo92Jt86WmP?=
 =?us-ascii?Q?LXYyjNWzIorZ/IibUtU+/9VNW0g2NhdUTO8ayG5o96lTBDJivldd/ZQdLp+2?=
 =?us-ascii?Q?2vnDiE4qi7Z0h/sP9mDE4uD8SjimUmhqh21/Sj6J2NPZis19lrENoNPyIsDT?=
 =?us-ascii?Q?3FYq0iAG2QVgHhn8dxzDx3vziIPhFXvIab1DwQSTCzO1zydU3RXl9dPSakN2?=
 =?us-ascii?Q?2CohziOfeYCppBcPq3CiLvFsFlqz0j2nYYtP+MLbmA+FOFx0vwLIO3Aismqf?=
 =?us-ascii?Q?NIcWlnw6YNizfWzu0/cD8RGG4XCQRhOFR9fO1V9xlYjfRpWi2g7VCPWJk2hd?=
 =?us-ascii?Q?MA3hdeIHH0NPyZGWb1rTwA7Q+ApMza7sZ1Xx/1E3AGZLCqgb9EGncG3frUsi?=
 =?us-ascii?Q?d1vyTU7YUV74MLKsHFhzkVXwO1iWvSRX7YSqkwj4RpaNsXjbqlui9WltfS3g?=
 =?us-ascii?Q?4Rauyh5m3yzyplrtNdzTDwftdX0ODep6APPwFPWu0TYQxOh68PMGFuZQO5eB?=
 =?us-ascii?Q?zIkzJJkJvyL3nZwmTUfIREM68kjtNlNqOENg3DWLYWgoZjxv41j3E3iqqY8m?=
 =?us-ascii?Q?8ehP9Dc/CxhGFqN9599ne+FImpKvGW1Sa+m3CNh4HL8Id6kn+xcn02mp1s1G?=
 =?us-ascii?Q?HJl5VFKjOfIE/Yj1ByW9ZMu3F9W07ewd9P3KemZrln1bjF3Imm+IxLzMon1X?=
 =?us-ascii?Q?H87ImORD+fbrZaiQZH8nDQYLS0HWfVUyDO/2GnwwacScG0+vt2H+SSuUREPj?=
 =?us-ascii?Q?c8Wy11bDmDN+oTUTq7pILt1xtpuFsePHLxfk/7W7WcbsRFP/p3pvjKZGA/r2?=
 =?us-ascii?Q?/7TcbjItyhekxvkdQyP9yprQrAaLNXpOP5JBRk+xjiUV51sWSn6JkzlSvPwH?=
 =?us-ascii?Q?XPP2U7sj59oXnaJhE9s3USeVg5f0kf+cTiNz/qE0t8MWTWH32zt79ZS6N0eA?=
 =?us-ascii?Q?afLuyYiQr+1shd0rh6a2k6WtXmttNtwdQzvcm/Fa3Ktw+4XbVInD2HqMmjw+?=
 =?us-ascii?Q?5b9m5ejk/w1TozDn9I4GhmSGnhZkCMT4sCVGOoijfNn4feismJdfL4ViH9r2?=
 =?us-ascii?Q?AX2JsEe+PbDamBcQO+K8qh0UbuTS8cVlRDVew7+l/aw6+BwqlTTHrzrnNGCy?=
 =?us-ascii?Q?3dKxJi9ih8iP7Z6ybHPeolD/awxKtwCJrXgd7eVddsY1vYyHPPwlS68b+tdo?=
 =?us-ascii?Q?N7ux4IE9o+LbAITrWlpWCKNdOIkscimq9Tqe2pEenxpAYRNTKaRJIODI4pSy?=
 =?us-ascii?Q?dApFsx+74jNdQZQp+7MnPEz/1sd32OSDWa7hu2YWehNUuDYMlzq1FeC/spB1?=
 =?us-ascii?Q?onvZEgc6XGo/8+JwIkZmN6DaK7Cryr+qyL+kqEU/QHORfIGICH9UfGCph3HI?=
 =?us-ascii?Q?XY3SPm7r6wGr0R2bpZ7slFufvwj8iuzokPT2RgUh8svSLLZM0w=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?WrfHSEDr2+a6TJlb65RVgjA2Oj9mOPbou1wOjCrwyY7+MaiKDtpyGtqHlhLN?=
 =?us-ascii?Q?cYvuYFICoNzo83DsIDTuGtumnLBX5qYrPhk/2UYpn8jdor9jRdr8HVrkFnz9?=
 =?us-ascii?Q?oxmEuTPZmmZMZO1W7gPiZKeoafqILAApdrrXyusl62Z6Wc8mGdL1e9RmHZ2E?=
 =?us-ascii?Q?OHGhutfnoGxEzVg6Xnv1t0j4UgPiCgUcBLAwpyP95gg3eCZnCz1+NeR+VW8d?=
 =?us-ascii?Q?GbtPbmDM4LuvlNeKliljRymvUhRp75pFaffOVZCK3YKNCbLS7CiOaHtBY8Wu?=
 =?us-ascii?Q?Oz0z14wE8/SA0e8rJ6VuCrsdGeLgoXq4MFOv3q01bNgtuAZIJpQxKZbiaINz?=
 =?us-ascii?Q?L/RqMp61RST3xQIvzPa9OK87aJ4Ggj/t8Pv9B4l5z3qbESrpwRVDiszdSC/5?=
 =?us-ascii?Q?Mf8fn3Po7pbV9DF+JsWRvp1Grzn1v6QX2mCJ0JzxFdlw2DMT4xXoaZij9hZy?=
 =?us-ascii?Q?3aEwRwGhSUhApkmr7jQ5xeS8YE2ZZ0+++MO5lJQdKuTWywHZmnljqHl+tG7W?=
 =?us-ascii?Q?/W5Dvgx8M4V/MPzzqNK7Cn0JTok5OxUlxeDLDL02kGQz5ij3Aecs9PdLCQqS?=
 =?us-ascii?Q?nY4R3PKApxbviapskCArOumHLEsAZuzVQlYpnxSGS80hoHImbDVI0cnnV4l9?=
 =?us-ascii?Q?c+QC7PsTyjwleZcACzL9t+Vvvpok7E6NUDSHkisIXUzBQstNokmSuW0otp8Y?=
 =?us-ascii?Q?+khCcnlgbckanmQkjpXCpcUgo9E8wgB+pvUXwl7ubv0qSoUjRRws7c7k2t9J?=
 =?us-ascii?Q?c21KkltsEEmMTRP1Sp6NtJgSmynrD7jvf7UK6WwnztctjdJ+roFPbmIbIkvi?=
 =?us-ascii?Q?xRKaUqjqVCtZcLhn42qWHMyM3ZeRbycQkXkcc3GCjmPi0Uo8X37FLGQcPdNK?=
 =?us-ascii?Q?vMkjjcUlVXRPatMbLPbysFJaUaykd1V/AFb/3GdjeLitBvSVwIGzQVuvP9Ho?=
 =?us-ascii?Q?v8s+vMvnuQewpvb7F4XSLxM9LqYELHu/2UTokJWp+kNrAqDck0ZE7LpOhZS8?=
 =?us-ascii?Q?19VVfFDHHDt95LCba20nUKmuM3E9q47hNpyUr7Z04DzZvqqJ3Tm91IL6zAMW?=
 =?us-ascii?Q?45teGQrH2YX08aOoXi+V1gXGWwlra08pXXWlqNpm1bfLZWs0stdg9EdghysN?=
 =?us-ascii?Q?OdNoTLHsYbs2PPrbyf3tjjVowklzLEoK7teNfSVSmziq53jGyzVRwxdpU4XE?=
 =?us-ascii?Q?cfBeH4CUpoRdDpKSABnUttMiEoSSeHT1QQfpAxIdmGpvjOQsUZeQCxacgmke?=
 =?us-ascii?Q?QYIj0+WPuCz7uOg7d8Sy6SjX/xaTm6rWq8upxs6ZLtHS8/O6qlB+d8L/tqKW?=
 =?us-ascii?Q?UjHXRApSIwGXdFe5NWuTlO9Bv552sT52IFlcNnaDl5RfUdAHxT/3tzTv4Y22?=
 =?us-ascii?Q?DoVmGlXrO9eanB9nAxPCYb0dtjiGapMoJ5O8zyZpATor1hVqYd3bbMzQyWH3?=
 =?us-ascii?Q?iasADonCf4PiLQ54TxCWA9wFeqZbY88JPT8HicrDt1/a5K+Uy7IxeVhJ4GA6?=
 =?us-ascii?Q?OnA30B0nX7kTprwJ0EA4UwgH7SCFPEepzdwiC7S/C+e/lNIBk+/oyjvNjCWs?=
 =?us-ascii?Q?2KoYGmFHhQqZuhvpjNM=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a637551f-f15b-4dbf-b0a1-08dca6d0b855
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2024 02:24:15.5487
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zwJm4G6vD53l4sWGcIsVugSVIdVeLhkedWDVfhMZRpxrcAt/jfPSDQuvq9Y4nNjMuqjofFShVr96sVond8riLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8120

Hi Cristian,

> Subject: [PATCH V3 2/2] firmware: arm_scmi: set mailbox timeout
> value from device tree

The binding has got R-b from Rob, will you pick this patch in your next
Patchset?

Thanks,
Peng.


