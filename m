Return-Path: <linux-kernel+bounces-529224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 279BEA421E4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 14:51:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B40C3188EB58
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 13:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362751A23AA;
	Mon, 24 Feb 2025 13:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gocontrollcom.onmicrosoft.com header.i=@gocontrollcom.onmicrosoft.com header.b="fTBeEgck"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2095.outbound.protection.outlook.com [40.107.20.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A87F3FBB3;
	Mon, 24 Feb 2025 13:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740405045; cv=fail; b=qXyisHLQFZWKrrvZybKc7kVEpMfk51NZGr9n1sj1f+J4RlzZ0MXmOchfloqk87Z0I3PnOTfT+QRTmhhYYGIjP8lq02zenBO9gBXD5t0twPQ14t/p5ToMd+SI0fNhWY0ICm3tkprNpbIp9yfH6jJXtCzXEHqtU+hAYRmfYQwKWU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740405045; c=relaxed/simple;
	bh=R0JIvf45Ocr7GRDqQnFR/2Ir2TEni3XFjynkFrEZEoc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dSDQ9z32TtCCNXAqgquqEoD9THJwLPE8EFSlHFYXAsoO/eBfJXRr3udLxKBrxp/7GiCsaJQ65b3HTmz5yRPf47JsbJcKXE15wiv6oc2JhtTWELrIJyiJIXrtfaD0x9M9484UQv22ah5D/Q8KQTz7WJ/BXGLcMj0bx4jZCR3y9zg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gocontroll.com; spf=pass smtp.mailfrom=gocontroll.com; dkim=pass (2048-bit key) header.d=gocontrollcom.onmicrosoft.com header.i=@gocontrollcom.onmicrosoft.com header.b=fTBeEgck; arc=fail smtp.client-ip=40.107.20.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gocontroll.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gocontroll.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N7ddZ1r9FQmAVRGXT8ozmRtE0v892/ohxm+AEt2dMY9yuGppz+nk+Rlh6KvEu64ym0Kkihk2hRllRF9navip4q5QCbjqkc+0EybZLqEF7svMthpiZsdszFE/E9rbOD6LZF367fWGZgbuBYV2aBH6Z/L+kjq3IcXqfGTROLT8zdxVjT2WuRAtW8jXMgJM+/G/issPR+2jUV08J+2gewm7sF5F2OBiWEoXkZh1EBmNB0PVg77k+0aT0RhYJ4m3SzaUebTNKNcBLjZxOfSWchVz26hp2Cm3SLlopv8rzhdSB46W07cpSogi5gWpOFxZUGpmQU5aeYzw6LfxQYLB+bOjFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R0JIvf45Ocr7GRDqQnFR/2Ir2TEni3XFjynkFrEZEoc=;
 b=tMGsL7IZyQY4sj+nC0i4kDwt5JXry+xSwq0jcWIN+vCLipObqr7NAp8RDjg3nRAVoWiimGMeVea8Vuc/RF3JPTjsrFsm1h3zLv/+iQiuU1gq5ckreNlX3r3jHMwyJ7pQpi4Aq3UL/dnBJoNP6nuaMkTxAxFPHNAznoMwpakBUuJDt0Efjvlw1OzSC0VoS1noGWyuf2pXXv2xv3gSAmxMnEu6OwUcb8W1ZMkej8TpprrIPU2H7qPkBRSwRC/I9muxIeY9P/b/jvSJfjltTkPFazDjQoamW8ZfB2uUHYk/2g3OyIM6rZALD/bcv+JcLVPgtYCHrTzNZvDwKk5GBbLF1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gocontroll.com; dmarc=pass action=none
 header.from=gocontroll.com; dkim=pass header.d=gocontroll.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gocontrollcom.onmicrosoft.com; s=selector1-gocontrollcom-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R0JIvf45Ocr7GRDqQnFR/2Ir2TEni3XFjynkFrEZEoc=;
 b=fTBeEgckZ/8KTwRiMhHUXchXWY0WuxjC5cgDtsLDyPvxWqPy8ir9AIZ7BQwvZpUwnslnieY3Qs4F8yv+SIvmIcsjnx0tz+30z8TVOQ8qhSlCMGM0IhsaxGCvWYrs2CsM4R3c23zdfDSyh8I3QbjY+XSh7wcuieBX0p3wYwvlme1r79SXuavAadnXXJFzel5Suf5W/5+P4wVRDJkO6La4Bv1moijAU2wnvPcIy+E5PTkk6w9g56d2FXJfPC5zOA4aPV4ZPGJ1VdZRAWc4a9NyzkNzHgBP9JzqUGRI7baCr1JtBIuAa/t8maj4x2ydmu3qBGizvmySRWp4JVZNvvwJFQ==
Received: from PA4PR04MB7630.eurprd04.prod.outlook.com (2603:10a6:102:ec::16)
 by VI0PR04MB10289.eurprd04.prod.outlook.com (2603:10a6:800:242::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Mon, 24 Feb
 2025 13:50:36 +0000
Received: from PA4PR04MB7630.eurprd04.prod.outlook.com
 ([fe80::311b:ad3a:4a62:7b5f]) by PA4PR04MB7630.eurprd04.prod.outlook.com
 ([fe80::311b:ad3a:4a62:7b5f%4]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 13:50:36 +0000
From: Maud Spierings | GOcontroll <maudspierings@gocontroll.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha
 Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Maud Spierings |
 GOcontroll <maudspierings@gocontroll.com>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] arm64: dts: imx8m: Add pinctrl config definitions
Thread-Topic: [PATCH v2 0/2] arm64: dts: imx8m: Add pinctrl config definitions
Thread-Index: AQHbgeCe2MBtFahOs0Kb5AKUbUIwd7NWgTVj
Date: Mon, 24 Feb 2025 13:50:36 +0000
Message-ID:
 <PA4PR04MB7630361D3404B039B09DDF47C5C02@PA4PR04MB7630.eurprd04.prod.outlook.com>
References: <20250218-pinctrl_defines-v2-0-c554cad0e1d2@gocontroll.com>
In-Reply-To: <20250218-pinctrl_defines-v2-0-c554cad0e1d2@gocontroll.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gocontroll.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB7630:EE_|VI0PR04MB10289:EE_
x-ms-office365-filtering-correlation-id: 79c4dc64-ca39-4a33-30c8-08dd54da376e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?2bufcNjXjMnmLRE5IzOUpy2mcZDuBYQPtIP0lKpErBMsdPYanrghyOC/2L?=
 =?iso-8859-1?Q?3c9Sw4r7kjhqp9bfy+5dNDRF7Uf4uPBNr5QR17SXqzq04AizjaGLc9saJY?=
 =?iso-8859-1?Q?HXotrfddWYs/J40ykttVH+4k8XAvxXSIUve/VJtylxfTxHZyAfDD3b7CB/?=
 =?iso-8859-1?Q?GtnCKzPMqlner5QtJl4t/TX8ytG7rwmiI+fmC3Wqy9GbL5dgtMNEj7Suc3?=
 =?iso-8859-1?Q?JYlYHAq2Lo7ttzxaEjA76bduwyGZSpirQagOgPIhnEs4GVU88LwyPyo7Q0?=
 =?iso-8859-1?Q?3RDZQbEdMHZAw0zx8k4sP3k5IbsAV9MVzbCTzIJfnGh2Ljq6c4UqWsI/ZC?=
 =?iso-8859-1?Q?wYR5i01480cOmSayeczgYdKBE0YzT0tma9VpK8JsR6/dHhIMRgCHugXoKK?=
 =?iso-8859-1?Q?t6W/FdCfFNLwhJx0HVlGvfvIbjHdx6xKCQdSXTdnN26C9SvMmowGaj/0m7?=
 =?iso-8859-1?Q?AsxRCCvwdnEF4AfTXANJPlolodeTV4ywYhUZS6v8iwUo/7Bnhu3WzbIL7T?=
 =?iso-8859-1?Q?ODIJe5GfOAeSV1+xPw4LrPbOb3q+4J6Gfmn5sLDX4ziSn6hCN5kzIoMwhj?=
 =?iso-8859-1?Q?adT4TJu263HCNTIqcILid73Y2h6hgnpLQs7QdnE7gOS81Feq0jNXEIsU1r?=
 =?iso-8859-1?Q?Q9tt9eKcctXQhl1UNzBQj4mDxfzJVtw8RC4bauTYSKDITEs3YTZZfK98dI?=
 =?iso-8859-1?Q?fsfcXbp50qNNjcGqlMz4Q6VZ3C28JJceVMxTDJDmfPLArp4JL+AFyVrXlZ?=
 =?iso-8859-1?Q?eWx+sRvZN7z09R2ytg5BbvbQ9dorlBdf/ONTPiLuNXLXIK4mV8TJAvfy4M?=
 =?iso-8859-1?Q?OlGbXMKtZ6lWFZq60GvAm2bRAS96X3DLORkkh2kjTrNV2eBJb9kDpNGarW?=
 =?iso-8859-1?Q?WJhLGafQGLpfLEM/rLcZ587ONBcpodg8AKuPeyZWGYrYkJVyIu+lbDKz19?=
 =?iso-8859-1?Q?6Y0RjB3TkghAioijQdTSfoMcI6XrqEX7ZyPkBbSaH4v608O/k2W/hJ4G7N?=
 =?iso-8859-1?Q?RSI6rg2fpAxjLtylwdoNOd/d7j7INDP+Z5SosUqzTYptvlEPNTHhAzhVW9?=
 =?iso-8859-1?Q?NBon/ESrQxLLMc9iRmC75RxVPg6ogYvNfRVWg6L4ami9sv64ujlp3HvaE4?=
 =?iso-8859-1?Q?OZt/WP95DwsdaEUSd+vHtqyBsQLEa8+gmJsx1nsoAlKPvCyoN/kz1JjmZc?=
 =?iso-8859-1?Q?ygJMyoy536KcRLtdhPGJfX/0s+6bjhf68dxEW66GqvXzt6yxG55jPPNOWM?=
 =?iso-8859-1?Q?U8Snwlg2195aTEbWiy2dTXemQsrp0wBJCDltqUefDsEV95YfVQ3XkKYu/v?=
 =?iso-8859-1?Q?oXiYPEurQwEr4Dc+3AggD+Ik3KCVO3A6IL4N8/uNTA8TpjKBpj9LLJ56zw?=
 =?iso-8859-1?Q?o3At1Hs4C29vKm6XdWzk/Xro112o6pQ0JiqpTPkaLkdVIS3dnihEOw0MGm?=
 =?iso-8859-1?Q?obsKXgLvoCin5YaLCWYNuIKi2qQDBiIZSZJFIjezx3V19l0R8ud7VJUHXG?=
 =?iso-8859-1?Q?TyPrW5vMjsw3T2JaKo6K+Q?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?bXmR1PmTOCQIop0OHuRu7ByJduayd8gRD4q1juIMNrp93IVKSiOFVNsECF?=
 =?iso-8859-1?Q?wqGbFnJHHoC/RsU0ukULI8o5ZnDAF4in7o328kdguHFqLZyL4edF7L37Kb?=
 =?iso-8859-1?Q?now8IqQlDrbMWI0++k9Ltzk6miTpn5KmK1LuvZ8Gf+56X5Jq50HnEckKP5?=
 =?iso-8859-1?Q?g4Sfv8jvV1HkiC+iOlv63HC26IkrDNK9a9TwQdGFc6yo6V6IY3OP04CgGu?=
 =?iso-8859-1?Q?wvUAhYRK5TRO/iCD4DPofY7R4cVyQ16t71rgJlM4clmqLCqwwH1/FuBX5T?=
 =?iso-8859-1?Q?2Gm+soeLtBVLQ/OwVLlMbkivqIFKhcH6kwAcihxxt5yT5d9bi5ArVkaujT?=
 =?iso-8859-1?Q?z6r+Ix5Z+6SY5bH0R/qVXvZbNp6Uj7f440XQYVw5LSMb2N5bKqQI85zBMf?=
 =?iso-8859-1?Q?ABxBLQ4H80+PRkozX4kT+iXpgkiDF4rtNEW47gwCIkFgNoo9qs5WiIH8FI?=
 =?iso-8859-1?Q?6G9OGZWu5Kh6OuxetaUB3Q6r4Pmn1xBSo1sULUUaUGnSjO445nPEmrr/t9?=
 =?iso-8859-1?Q?M947S1Gtb1WXvR1BiuZ/HsJz6ZW7XMY9QDjgn5SIycIBWtNNyZpPMNYbFy?=
 =?iso-8859-1?Q?Is28kEfIvc9Qqciz1JvfAP2PhgOXXR8MP8KpGzxeF8Gm0L3E/iHZh8wA3j?=
 =?iso-8859-1?Q?zLVelTY1F6Oe4rPppVzgD8MlMH+h9jvbpY3xJJsw4ge/9VgE3ra40YpE8Y?=
 =?iso-8859-1?Q?MHiK3rLIcKNgLsmWpK6cSCHLL/Ebxkfged2pKAwUi0OmDLtMH6vRYF5oHN?=
 =?iso-8859-1?Q?nI3M7tvGPDS7c6MhJcHlMBfECScIeGF44h2TvSrRt6ObMtujAMb978NXrA?=
 =?iso-8859-1?Q?v618+PVMUNMBTzqAe7CBRdKme3Eg9CQ4TE8/9VdLTrioyuHR0Z6uNApdE4?=
 =?iso-8859-1?Q?ZThas2oODTO5BZdSNG0Zf5F0uNRm0XeiKgp4X6aSVJWQ0M8FuVAyAdK5CN?=
 =?iso-8859-1?Q?5MoF7CvPRmkx5dvtprZv7uj4EINQEH2l5DFfjjp9ci/TEKtnjtiOCO+L/a?=
 =?iso-8859-1?Q?KfgdXdNRCk9ZCJQh/OJv5Jry5xNoLVcw87JK0V6rRK0ovcAIx9I2ETwgCV?=
 =?iso-8859-1?Q?3YojX1VrX0GRciDFb2plNQp+LkZsR2A4uZgeQJr83IRrZvvE1VsyO3gmyf?=
 =?iso-8859-1?Q?MOSJ45OAFgt2SUdFyfTagKddDM1r3/2nC6Zrfl5fwIpenK741r3R4PmOxd?=
 =?iso-8859-1?Q?//B9u19YmByW49darE4lmuJXpHDDkShkSv759Bd+QyB5Olfarm0V2/ZWyb?=
 =?iso-8859-1?Q?xwohzzea17DPqub0dAsfOQ7407oilLsNYvQdkYIXPy7ilA7RKKHXlqnlMK?=
 =?iso-8859-1?Q?bL9FAI3ck2m5vmDScb4w0tXC2Ijebfj8dyK2+mkKvIxVkqVrdbFKu51oHV?=
 =?iso-8859-1?Q?HzyUrA+1Vy4YfSO5F+f7f12CWrJM8FgyewKcePcyAGAqcWjoa67f4EMl9V?=
 =?iso-8859-1?Q?3c71ILndwMpTuHPB4aLnCMo1lJ+m53YULP8+ol5VZnChgXxAKA+0cw67HR?=
 =?iso-8859-1?Q?XumjcswsV+jFaoQpf603apecwpg4UAyq7VaxI6mGQ0siTWGRXQ3qWF0iHA?=
 =?iso-8859-1?Q?K0XoRMa5hjJvq1T1bkYOLWUthmcTSZBANL7T32aZLEGnT5hulnMnMkvJXX?=
 =?iso-8859-1?Q?15ySgVWKekXpyKMIuxhAdoFPXLVHjUDg1NjYEtCxtGi0MFLAYDOgY/fu1H?=
 =?iso-8859-1?Q?WQwxI8Vyk4zKlFOvirfMx8dnWUQfWZWgtyrN58ICsymX7OgeSmysiaYA+t?=
 =?iso-8859-1?Q?Fr1Q=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: gocontroll.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79c4dc64-ca39-4a33-30c8-08dd54da376e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2025 13:50:36.5422
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4c8512ff-bac0-4d26-919a-ee6a4cecfc9d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vldb/mWNrNsqzH87Nwx3ODy+gifx7TxkkIxnZNkDU5J52JW+egw+GLAWQjWM+i1KYWQYOX0UCj9s/qoROykL6Sg5gH80wqfEGZKvxfVt5vc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10289

From:=A0Maud Spierings via B4 Relay <devnull+maudspierings.gocontroll.com@k=
ernel.org>=0A=
Sent:=A0Tuesday, February 18, 2025 9:39 AM=0A=
=A0=0A=
>Up untill now the extra function mux (pull resistor, etc) has been=0A=
>defined as a raw hex value, this is difficult to interpret. Add=0A=
>definitions for these parts of the pinctrl registers to allow for more=0A=
>readable pinctrl definitions in devictree files.=0A=
>=0A=
>It should also be done for the mn/mq but I currently do not have the=0A=
>reference manuals for these to verify these fields, though I can only=0A=
>assume that they would be the same.=0A=
>=0A=
>Signed-off-by: Maud Spierings <maudspierings@gocontroll.com>=0A=
>---=0A=
>Changes in v2:=0A=
>- Changed mystery bit to SION=0A=
>- Link to v1: https://lore.kernel.org/r/20250214-pinctrl_defines-v1-0-fbc8=
6a42ef3c@gocontroll.com=0A=
>=0A=
>---=0A=
>Maud Spierings (2):=0A=
>=A0=A0=A0=A0=A0 arm64: dts: imx8mm: Add pinctrl config definitions=0A=
>=A0=A0=A0=A0=A0 arm64: dts: imx8mp: Add pinctrl config definitions=0A=
>=0A=
>=A0arch/arm64/boot/dts/freescale/imx8mm-pinfunc.h | 27 +++++++++++++++++++=
+++++++=0A=
>=A0arch/arm64/boot/dts/freescale/imx8mp-pinfunc.h | 27 +++++++++++++++++++=
+++++++=0A=
>=A02 files changed, 54 insertions(+)=0A=
>---=0A=
>base-commit: 0ae0fa3bf0b44c8611d114a9f69985bf451010c3=0A=
>change-id: 20250214-pinctrl_defines-237e7db61c6a=0A=
>=0A=
>Best regards,=0A=
>--=0A=
>Maud Spierings <maudspierings@gocontroll.com>=0A=
=0A=
This series has partially been integrated in another patchset (the imx8mp=
=0A=
one). The other one aimed at the imx8mm will also be sent later with a=0A=
patchset that also adds users for it.=0A=
=0A=
This patchset should therefore not be merged, thank you all for your=0A=
feedback so far.=0A=
=0A=
Kind regards,=0A=
Maud=

