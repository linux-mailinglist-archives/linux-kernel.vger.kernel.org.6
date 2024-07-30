Return-Path: <linux-kernel+bounces-267681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3E694143F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 16:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C992B28815E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jul 2024 14:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F551A2554;
	Tue, 30 Jul 2024 14:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hrizLDKw"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011028.outbound.protection.outlook.com [52.101.70.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1209E1A00CE;
	Tue, 30 Jul 2024 14:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722349463; cv=fail; b=bgVGonjbI1zzKJwOso9uFw5i+UI2Yyl9D4dD/7bcRYJuKXm3w+d/ENFZy0t7xb9svQiphhFHNMHOGzc8Hk0Zu7UN7CT8A5/0AlRb/CzDiWqYxso4qKYJJijeeVZ5LH5zSNzGwEoebCOv4hqO9vDW6HnTfRsqqJBj7gQKvKjDlzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722349463; c=relaxed/simple;
	bh=rph8eWIqCntPTdyILFW+r+y21UZ3Cc+ETE7rOJrtCvE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=spJY9ULXaklsryx8PVI5+NRqs2CXWIqoi3dECk7n3uHPHek6jD/+C94g3y7UdL8yawwaju3VIYfd/CD42ksMLI/Gd0NYMPceqAoU2LBj/pNANwmE1z0a632jIo1bjrY6aozRrji59DRzCUr969uJko6X35UCwtO0wkVBEs+I+4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hrizLDKw; arc=fail smtp.client-ip=52.101.70.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T5ZBK8Q63iexPNCQId71C1FnxaAq4BbT1WROl3heWS4OPhvp1QjAQxsfsPZdO91Jx3vIPZV3F5fwjVdtEQc14sS4txuqEEYMsDA9uoSGeVk4UWOi7fVueOCacCDn49FN/x0Xq57/GcKXs6JqA/ayOZx+OdB3NAgq73HKKJ7ReGp2bOVDeAv2j0oDBkND9WDPniEL2jdbKI4NlqiGLdkPB3oU2wb8tSlDw0ulLmxrqdG4vJ9S6aMK5uI51lkr/8jK1AWXu2zEkVdksBo+TLgKvoMtcEMniPgyqUoOfSFzBnNubOVmXeNZBJ3IWjkCnrKvoHjqBDQZRJ+wEG5IlGDbEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rph8eWIqCntPTdyILFW+r+y21UZ3Cc+ETE7rOJrtCvE=;
 b=NcKdGp5EhH4kkADiexzHapgM8mQybLxn0ZIVrqtKQRu5fXK3y+WdYtvRYv2VPh1SqJGv2k8Y59XVRGW50WIUkQ9Avn0G3/9WHoUDJNBJDlfj7sln0NhSf4GEStTjlpyWqN2rfojPmN+MYgtDmXBCvb4A9jJx0M//rPMbQ2rnzIc1lRyF95JQjDQyNTpTrSwqtGhQof4KskS8LnLBNU40R6fFIf+TB1J9kD2xS11gq1Higx9kCboYP1Y32eINTfFjApj+UH+jad15dI3ZfxuvQeAJnLvWwsBmSusQSP1s480gu2X08F0q5iJZVZelunTHdqUibc4hMiazyy9P0kwsBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rph8eWIqCntPTdyILFW+r+y21UZ3Cc+ETE7rOJrtCvE=;
 b=hrizLDKwfmEGeAUxLXLb7bfnHCz3NlcNtMtQ39ESY+/+m1O62wOW09aMz2Ui16Fki5ARoIxrirnomail2EsHk/Pz5bs3lE6Dn49f3ZeDG8h/au5LoAdL1VV508OcFp2mRQP+E3Q50gJrOUa5HmlPw+NOFvNxgB0g6RTq2C6gMVylTNJVlYNda7uPl26cE3zRivwzVHOtEU0sbmmNmtj3jaqN0j3yzZczAI2OXFmJshiiRPaxVdaAtxXzcEYlvIFBhZDzhmMx1Mu50V+O8gvSQY7PAuJXqJ6d+Rp4fTBLT3bCVNib9DHqB6DAW3sm42wHfj+Tp45YBZhkqvvNrkEtoA==
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by PA4PR04MB7821.eurprd04.prod.outlook.com (2603:10a6:102:c5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Tue, 30 Jul
 2024 14:24:17 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%5]) with mapi id 15.20.7762.020; Tue, 30 Jul 2024
 14:24:17 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Cristian Marussi <cristian.marussi@arm.com>
CC: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, "sudeep.holla@arm.com"
	<sudeep.holla@arm.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "arm-scmi@vger.kernel.org"
	<arm-scmi@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: RE: [PATCH V3 2/2] firmware: arm_scmi: set mailbox timeout value from
 device tree
Thread-Topic: [PATCH V3 2/2] firmware: arm_scmi: set mailbox timeout value
 from device tree
Thread-Index: AQHa0gh1nzSgPeT6CEaXte3Yk8eLv7H7zrKggBN1UQCAAC+E4A==
Date: Tue, 30 Jul 2024 14:24:17 +0000
Message-ID:
 <DB9PR04MB84613EEEC8EA13469757FF8B88B02@DB9PR04MB8461.eurprd04.prod.outlook.com>
References: <20240709140957.3171255-1-peng.fan@oss.nxp.com>
 <20240709140957.3171255-2-peng.fan@oss.nxp.com>
 <PAXPR04MB84594F4271F68D9072BA0C0D88AC2@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <ZqjPGvTgtosWQTzM@pluto>
In-Reply-To: <ZqjPGvTgtosWQTzM@pluto>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB8461:EE_|PA4PR04MB7821:EE_
x-ms-office365-filtering-correlation-id: 598f1410-36e9-4a91-a4d5-08dcb0a34bc9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?+3ta9wCae6EpAPioMBmaXj6qrka1j+N8HAxEiK9h43IY8N7kMPsmTh93TKhE?=
 =?us-ascii?Q?ARLtFX/rINrotJdjMGbh6NtyORT0Z/XzGVLcz8fc9CSfdCEMRh926MCImqhC?=
 =?us-ascii?Q?1VJwULdKhcGP0cKGz7SAqdNwMlDORFFjZ7A6z+ZJlBpNt1T5o/OQGmj3lofS?=
 =?us-ascii?Q?ATjZleDwR+XZ1ZU1mIW18nuZugY1hqya1hZhIIQSlSOaZSBNyqcSh8dPPFWG?=
 =?us-ascii?Q?f94Vy0LmKNy8MuE+z5F0uxQjxrmQwjGqog4d8oIYiUGWdKK7YB+iL6Ibaxp7?=
 =?us-ascii?Q?+qXIPvHWEPnIPwBf/OykpBbbDWWf1rEjyQIQPWLeTxF0gUCXMBIxjTnybCB0?=
 =?us-ascii?Q?oQeEZ/y70J0ddcy8gZXXHvfYyicA3IDB1e2WvdA3eJV5Syr9pY5h7FkuCgfc?=
 =?us-ascii?Q?xzWLPXYZlJmNL9e6RB8GCOAvWdj3fjU9IdshAQKke69UBSYjhe2mYD0DaXUx?=
 =?us-ascii?Q?rgkMSrONPw8uC7xzCL46ry18zIPy5uzCKMQP5g0/MrqppJm103+AqBwG7OKZ?=
 =?us-ascii?Q?Ah/4/sl9xNRKMmjWXt19o7Zh3kezKthJCmSL53qSbVnyASoIoRT7Qxo2c/9k?=
 =?us-ascii?Q?V0bCzmvCJhDYilx2pJHxAz7vliexmNnOEwnaSkhBdVTo3ci7+rHlKdusnbOw?=
 =?us-ascii?Q?ioi8eB6dQY7HeUiv+JrrzCSEAmu4V6QCtlmI/Msj315rZ7tze19oYWs2uUWB?=
 =?us-ascii?Q?Mj8KrNzp4ZIl3NSrhfME8CEcDJMDGTD8WbKCs+tE0+/NrIDjT3c1UHAtoage?=
 =?us-ascii?Q?ZtT3d6h4C/rHR1dJEmewNvSTdbTkIc79qORkVjV3mTSUUkbQI9y9zECKwxMl?=
 =?us-ascii?Q?/hBDdlYaao0Mp42gq7PBbuuubg0S3883yEVBK0V1x+CwqDAbOuPh246q2j9E?=
 =?us-ascii?Q?RyxV1babRS9Vdgiv9krXeHNFVnfUhTMKglVtzKzJXPXsx0lnLlrId2MHqHDG?=
 =?us-ascii?Q?aKRh4zkSYM9CDoOvljgAQTt38mizv8WknvZuigM2HZjHuR/pu9Q2LDnhZC49?=
 =?us-ascii?Q?E0QRizDwu6C8ta0G12OaUMSK+0Q2zg5tdWySjPh31BoAsDHOpmdFRbv9FTnD?=
 =?us-ascii?Q?WiQnjO818x35bKLl70CyZfgXYIvWQmwPcDmAzDVU6nXsKpLidLEPW6DxSAZO?=
 =?us-ascii?Q?mjPxonafpajnW6Y/gYB3zSAhRyx5/QiAx5cH36HOyGPq+MWa3JBVNQRV41uc?=
 =?us-ascii?Q?xhWuB6Tfwh6h9qfzSFneWGQYibrX2mj6K6e/lifHy526terzd27cHQps1r0o?=
 =?us-ascii?Q?C9amBuxKFj2jHe3C3q0EhQQVSevA8ScIns1KnfNV/dRF5MRABTISRSwLDcID?=
 =?us-ascii?Q?fPp1/EIj6InRjdwNehEKYO3U21LOTN2gfTUrQNQR1+NZxDfl3Vo0VHEKpnF0?=
 =?us-ascii?Q?ZKcAtLrga1NrMSgQ2S2QCjyyH1YCUSXkRaOsAAjUESIdzhkZ0Q=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8461.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?gY+wHwgkBjypykhAqiLBFHDXhjgv+IbxtY99iJ257PCafERe9kqZeBPnpLe3?=
 =?us-ascii?Q?PO8VsY9JoFsFLTva6fD48Y9XDa/XBdHX6fHMoeP2XkVk76oSrCu8Hvr/ZelK?=
 =?us-ascii?Q?M6AIaXiVs4//Yajx3/lkBR7UucKWS6oKpmYmmwMm59wS8ghchQO7u7vDCDq+?=
 =?us-ascii?Q?nAyZhD8T4DvEWmb+m2OoV49BYtJSILzyYmqoTbGPw3CM4B9DjbR+lxa8kkWq?=
 =?us-ascii?Q?aUdr9Hl/XYwEwLsjnasE8ssXJrU+4LRMBMvtNT1y0Hq4AAa1yCOZQGt15Wis?=
 =?us-ascii?Q?VDrO6iLze7VAYoPpNT+jsx09HClYHbqBHOFy3HdDT9KHWvnxgm6J4vKUuBWE?=
 =?us-ascii?Q?ynrF+SYo7bmIME++MHGjfJZLrA9z8BCHXfbDq7z56JZtEG0G/D5QmUKXkYOY?=
 =?us-ascii?Q?mU1DCc5RzJ1v4oYOwyjxw9XB4R1F6PmEA5MK+1yuLflUsNJtWGKS9OY9I35L?=
 =?us-ascii?Q?pRGnqWopce87GAsCb8urnqidsBiTG/+i/rQqqXxgPc3syCutk5jlmkEBs0Pr?=
 =?us-ascii?Q?2VRRMQAdk94nNDtxJtRDn9uFgFdtdOBW7b5d9nfoNgZm8WIpOY33fIW0FthB?=
 =?us-ascii?Q?RMqHJtFhKYDzAmVlth8pano9bHKBbS3npcBld39La6Pc3W5uiq5U/sLAglBL?=
 =?us-ascii?Q?80aQfhbRSWhepdtHww0jzsu4eNTCbWxY61BfTqHOdFGXfxRgEBNfr0qtmtVY?=
 =?us-ascii?Q?awHdmEdmC6ZXJRZ2qCrqohEbL10l2EoBfUu3O567kXr6wUt2vIMH7iROJE1l?=
 =?us-ascii?Q?E6BRBxi/aS7+OcfF2hknlXaLp1TEEbaUOYbErk4VyC2qH7G7fxMPOcIkmvA0?=
 =?us-ascii?Q?911OrY/tizwp/YCTfEEgK7Ds8sF8HFWuVpztl6Tt/si5vAhW1C6dRK2Q5VoO?=
 =?us-ascii?Q?4CnlQMl83eRRV538xiF+oZLlJrdZhP4FkUTrk2o4Sj7AdxN2W4E9fY12R6sX?=
 =?us-ascii?Q?xxn9p3eZzI2q0K5ZyhnYYtT9BfCJDI+2bpR3u2JVRr1Gi2F3KTHsaxofjG0/?=
 =?us-ascii?Q?ti0doWnif8s20yoGRO1JeD1Kw8i3kkH7FWdTywHIXvy/Z0/5TwbqMqDplUgm?=
 =?us-ascii?Q?uZO1FKUbSzadedawpzpSS3DaYSLWYQOsa0pUBlEM6tGA/2wn9Pn9GlI2te6t?=
 =?us-ascii?Q?L7ZjrtCC4Whz88ZWrejGbygBOMm7vsfL6XigV2y1gQ74jsdfLVMrmHM99+Fl?=
 =?us-ascii?Q?6n3dkPvZ1TYf8ZRw482cbg4fjIJSTZdeQGg0BkIT8xf2kWTGI9bCogPCKA+6?=
 =?us-ascii?Q?qcrbTfbyEvfpfJvQAMidawhuNyiv/XuImDuYwqJ8Hq3Xzwunm0i3ZXXkHMdB?=
 =?us-ascii?Q?2k7IbHfHRjk44PSIkpEw9g0YDC26+AApbYVxZ99QnWqOCbZMTnUnKk14KIXo?=
 =?us-ascii?Q?8gpcLVczWJpu0pgnUIdbQPdye5THpSAp7r99mmlyqLfmrbmWLiYI1oKc8OND?=
 =?us-ascii?Q?SuMxKzRHdxrCwhkS6Do2pS8kzg+tgA/paW0nd1tKaUbEELf7ZWzc18+YsiXY?=
 =?us-ascii?Q?6eEG4ra5zBGRdw/eaH1gbffwnD1fhy6oFJBrSLptj1xdnzoiTUd3jhw9vr9S?=
 =?us-ascii?Q?4taB/uqEnZ4edvF1Cx8=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 598f1410-36e9-4a91-a4d5-08dcb0a34bc9
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2024 14:24:17.7368
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gyE/b+FIuO0YqX2ntx/TYoU/ElnD1j4oENjCl2Stg9TbGOIub9W3h7iv9XIfHpHiVvKTGtn63UmF/C916aybEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7821

Hi Cristian,

> Subject: Re: [PATCH V3 2/2] firmware: arm_scmi: set mailbox timeout
> value from device tree
>=20
> On Thu, Jul 18, 2024 at 02:24:15AM +0000, Peng Fan wrote:
> > Hi Cristian,
> >
>=20
> Hi Peng,
>=20
> > > Subject: [PATCH V3 2/2] firmware: arm_scmi: set mailbox timeout
> > > value from device tree
> >
> > The binding has got R-b from Rob, will you pick this patch in your
> > next Patchset?
> >
>=20
> I am going to post a new transport_drivers_V3 and, as a separate series
> on top of that, your latest "max-rx-timeuout" DT patch as reviewed by
> Rob, plus the related new logic based on transport_drivers_V3 and a
> few more similar changes as requested by Nikunj.

Ok, so your V3 not include this patchset. Do you have time to give
a look on the 2nd patch? We are still waiting this got R-b to land
this in Google GKI kernel.

Thanks,
Peng.

>=20
> Thanks,
> Cristian


