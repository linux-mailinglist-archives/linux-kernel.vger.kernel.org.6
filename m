Return-Path: <linux-kernel+bounces-516123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C1DA36D2C
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 11:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80F041892965
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Feb 2025 10:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9395C1A2397;
	Sat, 15 Feb 2025 10:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gocontrollcom.onmicrosoft.com header.i=@gocontrollcom.onmicrosoft.com header.b="4i5zegAR"
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2103.outbound.protection.outlook.com [40.107.103.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86084C2ED;
	Sat, 15 Feb 2025 10:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739613729; cv=fail; b=lcy87Dn/VAph+4SIrtPkdrB0fJDRTiv2fNBzTM5C+znWOig8Vp4/VvkFMhqbv9NavQS+nSrK+gwGFxAVATedyr5DBiqgKsTXsS6WgcAmf8JrtA5umrQRWa1bw5LyvURfBW8H7Og2Qabl1fSIuOcyrT5qCTAUbRpxm3dQypD9qbQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739613729; c=relaxed/simple;
	bh=OKpjhai9vysKqS6D3tgQsrmQT0JtdHsG+fRqg4pfnH0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eGlhORFdBVbLadZBuSA2WySAviMiTGxc1ktAEwUpjhXG8gK0GMAIzENWwNAsrRSS95PUKVhYus0f7p49RDLEegE4+y0J3wUOoapnEw+YXJaSXyR4Him+/eJyDCQgbg/0E+4S/qUtRKGDoYseLTBd9UQNhoFIOGqPd+ERfiEvdXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gocontroll.com; spf=pass smtp.mailfrom=gocontroll.com; dkim=pass (2048-bit key) header.d=gocontrollcom.onmicrosoft.com header.i=@gocontrollcom.onmicrosoft.com header.b=4i5zegAR; arc=fail smtp.client-ip=40.107.103.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gocontroll.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gocontroll.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q4ZZXblr0/YJBBUwR8pKin0RG+ikrSaS4XMl19fL/UvOscEG7zfYG2+lROkYlQ/x2fOjmakhgqBcYAEFgkS6mkWjqWmQemeBF53besgoytxuD+9C4vPLlGudljujJbDp7pXXFd2xWtxDOua+uZoBR6qeIWMGPgxhdX5B7djyUxEuldovPMFzJUm46grbpjutGxKjrUkypbherOtEsRo1iP79XeFFzlZzMe8sBbysht8pzQrEqwZLL6lqKgB+5g2KCUs1AVd+MPD4RgFyJHgzqsPdpNJIygfV5RUAOEIXiUvoeUsQeT8cWT18oK5bxxDqbMIFJni40drls0kc5AkJmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OKpjhai9vysKqS6D3tgQsrmQT0JtdHsG+fRqg4pfnH0=;
 b=tmNHiMsxk3tNcADiRF11A2LabTVCquFvwrczo4e3ljux1frHjQtlaXU0BMQw+iPpy344Z0Zn9GCAvbqDDXazknEgmR21z/syW5ntItkGH0KU0Bk0KX1OzsUXiwd38CwZBI7JJwRBkkcMy+oN8xZZvz/YRK8gIhgEzFhWI+BchX7kyxREptkPVQmraql+AFaEKqjFLlgCCQNGGmsCNaLQ00qMpFuWteFcj9UQKEtvlQX2SslJJmAf0RARQhOWUQbZKGwvSA7/WKJYasvxoauhQP4qneb1rgY1Xa80tiqIUbl+HNXr0IvvsrRoCSJfZE9K3RWcS//rSwtJtJHH2QoNww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=gocontroll.com; dmarc=pass action=none
 header.from=gocontroll.com; dkim=pass header.d=gocontroll.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gocontrollcom.onmicrosoft.com; s=selector1-gocontrollcom-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OKpjhai9vysKqS6D3tgQsrmQT0JtdHsG+fRqg4pfnH0=;
 b=4i5zegARm5qhGI7BIiOG2jgr0NrpMrKzMbDRXbYRdDxo6RVRNy9SgpuIkYJrVilgDIKUqr4eFECxlCY3/GnHRq3bCNHFwcqCXJtQVMEadcI/S/oZa+wZa3W9YwnADbFGJZ/NMhtRThEV5lUz29MNLSHzEjt/yN8uDCvXy9bBqCi+tP/hAXqIE1rJUlCzYcy/gyZu7TX4WOkJJwwjXJFJznXR5iaoo+wcEe1kt3NJ0nT78timnAK6DOXK62Czpk0HxdMrifctsjHIN/+gWiS//evnwJ+BqEpJFmOqImFnr7F2VLRdWYO1LLGjCxHTAAMQ/R4eo99XtgeialREB1ojUw==
Received: from PA4PR04MB7630.eurprd04.prod.outlook.com (2603:10a6:102:ec::16)
 by PA1PR04MB10602.eurprd04.prod.outlook.com (2603:10a6:102:490::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Sat, 15 Feb
 2025 10:02:03 +0000
Received: from PA4PR04MB7630.eurprd04.prod.outlook.com
 ([fe80::311b:ad3a:4a62:7b5f]) by PA4PR04MB7630.eurprd04.prod.outlook.com
 ([fe80::311b:ad3a:4a62:7b5f%6]) with mapi id 15.20.8445.016; Sat, 15 Feb 2025
 10:02:03 +0000
From: Maud Spierings | GOcontroll <maudspierings@gocontroll.com>
To: Lucas Stach <l.stach@pengutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
	<festevam@gmail.com>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>
Subject: Re: [PATCH 0/2] arm64: dts: imx8m: Add pinctrl config definitions
Thread-Topic: [PATCH 0/2] arm64: dts: imx8m: Add pinctrl config definitions
Thread-Index: AQHbfvkzLhlPpPKrFEuvLnbvL9E25LNG/SSAgAEjOYQ=
Date: Sat, 15 Feb 2025 10:02:03 +0000
Message-ID:
 <PA4PR04MB76308879CAA0764BB293C4C3C5F92@PA4PR04MB7630.eurprd04.prod.outlook.com>
References: <20250214-pinctrl_defines-v1-0-fbc86a42ef3c@gocontroll.com>
 <d0dd61ea558ef8b18978301ef710925b83ef4037.camel@pengutronix.de>
In-Reply-To: <d0dd61ea558ef8b18978301ef710925b83ef4037.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=gocontroll.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB7630:EE_|PA1PR04MB10602:EE_
x-ms-office365-filtering-correlation-id: 53817128-3c1b-4c5e-4cc5-08dd4da7cc28
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|10070799003|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?QgS5xuY9w/EI91ZJyY71AXD1xQTM5+xdD0t30X5MFU9cccQBPBWKsCj4th?=
 =?iso-8859-1?Q?PMHv8YpXAtyL/alozEWxUfJTrh4DCgoxQomLso0S2TXRXQghpwsxiCWtIq?=
 =?iso-8859-1?Q?i9PwQVKjRs1XOUr08Wb6A+qGmaEBEoLGMpJRW20fobHysY9vtrKJzdko2I?=
 =?iso-8859-1?Q?p4LxDQjqOmqPAuP82Uc0hyXsXrlVYVSOzqssKNsQ4nx2+a8+qxUoLineEl?=
 =?iso-8859-1?Q?8KvuidZjcMeYyew/CwwYhRnpoSS2+a+IiPMj9bQNiPrZ4YVz+USpQ0uWO0?=
 =?iso-8859-1?Q?TYJ0XGnKmoGWrMcSd0l18nNRoprLI5aHqRi30zkSDeZOkZx9WCn3yYU4ge?=
 =?iso-8859-1?Q?yAso+82vJVo3r4maCfFOuB4Mc3T46IkgSJPH1+wiUpRRa0sgr7Y0OnXbbg?=
 =?iso-8859-1?Q?EtOIkxQ/gzJQZ7renZZIlDaxxDTJp7LyO8JNOoUiF69+eE+r1kKZ+wiB0x?=
 =?iso-8859-1?Q?NZeuCUX9WbObWccDE3N+7oZerkmIAg3wdFUTJC3RDUaAlqcpTC5dqP9yt0?=
 =?iso-8859-1?Q?UFA5dZgY6rB8DW226JdOfYW981nmp8lNOkByrMw7cLbB9P6vorzJcf6he2?=
 =?iso-8859-1?Q?gUusPidmY+DlAJwLhyfehuG0me4WzktzM+6jL+nyp0g5ttjn+Vb5fh5fBT?=
 =?iso-8859-1?Q?4TfyGCRxi268T+dGIC4Iqd/LtDuts3CDb83Q4JlUBQvDRVqWdJ6qD5KQaE?=
 =?iso-8859-1?Q?FkMWCLZiICmHKol6zYt0Bh9AedWapHLnn/oWmLdfOnWOCef/kOk/sQBJYS?=
 =?iso-8859-1?Q?wa/mwWAiDOiLoB2D9cdvT6tbDSKsGqeYW06qvRXSizISP/9nrhGWqckYWW?=
 =?iso-8859-1?Q?+dboa9hTac2AxVLojq8w9SvTFJFkepznGJvDX18RQB3ps/shni8soT8YBn?=
 =?iso-8859-1?Q?/V2A/dZGuFQXkFr7bUSMf29qSIruDbIKYeTLovwPQKo5BaGEGuUwyRcnPE?=
 =?iso-8859-1?Q?Zbb5klYIfONFSXMTLg9vnSZQGNID9daCWSANpSO5/oLmDGyL+FUGwt5iOu?=
 =?iso-8859-1?Q?zH4V3Bv++E+fGi4KZQ7eb0HJmBFuFXDdXG/O0p4MLZvR4xzRC7o8vZtjnb?=
 =?iso-8859-1?Q?g8Sq4aQpceYqQAsGRI/k9P2hcIx2j+al7tGyeePvymAXHxie/l97zKb7mC?=
 =?iso-8859-1?Q?IIGDdg6s4UvwqDDjP3QxqQRW4SyVyZ5MZa1QDG3yrygK6l7BDbCfOkk9D2?=
 =?iso-8859-1?Q?7vLSBqT8eVhI8nYxWSc0c/25gpY1E5pO2OyggW/My5KzRanfVCBkWjfe9j?=
 =?iso-8859-1?Q?+08HaNpuv3ykPj3lz4pE4Gvmh6wT2i6e7FC6Ml6+BuF0HIT1pFoG/y03wB?=
 =?iso-8859-1?Q?Ps6O7ndP3OhApYJyjKNPeahfbzEA1oz2xtm80d847z7CFfHGHfWsOxvSKp?=
 =?iso-8859-1?Q?5SLkM+Gx9oxyEER7Go/e5/HlzDPO1iK+Uq+0MypADFUIX/BBUxiyyp9tu3?=
 =?iso-8859-1?Q?jwqOKcCSFekTJqSuiBm253YRZ7BBSMhfxpDycaJ95+cZA9rxDWt+kXMd+u?=
 =?iso-8859-1?Q?4niW7OelAU5Ummve4aqGuI?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?APeFvONFj2hu6l5x5v13VkTyyZ+X5PA93+d4NDifc7yIWEu8cvuD9S0MsY?=
 =?iso-8859-1?Q?zCSg8aluV2qDe2YEVlN2Ko+0Qf8gIFqunvPd3v4J7yjnON4wiP31nMPxkD?=
 =?iso-8859-1?Q?WqSacIPYqqherWFFYItD/FHcjkKtdYOjWwv4zo4jrGr7SXX6Lv4/j2LZOu?=
 =?iso-8859-1?Q?AiKQTFoRv93e3fPJkwi7ae9QjPor1LidoGjhxt8nl6z4xK/FT4vp56VY5P?=
 =?iso-8859-1?Q?p6AZxyROuOtysrBhm6BU9vC5Kkldqpi0hMu/VZNpTxvqNdB9EtREwPn7q3?=
 =?iso-8859-1?Q?3/Nz5diBNwKNEfjUp6K5D+RjJdcpgFiEvvxkLr4Lxf5IdpP0V8G4MbXb6f?=
 =?iso-8859-1?Q?wvZOkt1V2C7f3quyqXnRo256/r+mBhpQPy6COQgtW/w18pWxBeDM5Cw726?=
 =?iso-8859-1?Q?D8VzIyTU4RF9yHHo9Sq2GXQ4hqPVum5lbILgJ98+ZqPirgf5pVrIWPFO44?=
 =?iso-8859-1?Q?/XO5mQ/L3O19gAvdlce5yTn7VE2HFlzB9cF+vHERj/g0+OUmLL4VdlAezs?=
 =?iso-8859-1?Q?OKyBMWBzGCYQT0psU4czkCG5qNTZnm991A2mS4F4YRK1DgStchBjkp1bMA?=
 =?iso-8859-1?Q?TeXirZwL+L1wCsAU5bNJ7h8eD4j9IEwhwe7czcgQDwc8Uyfs+HLdURAY1O?=
 =?iso-8859-1?Q?BRwsrSZrNIKCVzsWuY+eD8MQ37FYA279IwmuzG3GvOjRGElfLY0AhoNsVK?=
 =?iso-8859-1?Q?JynGzOM1RE4TvMGyForuB/cj2ZEKArjhu94Wj/XasjgG+qeS2EFBSZNz6d?=
 =?iso-8859-1?Q?Y3QIQnYO8flXUTHn4Tco746F6sn/6MsNFWB8W9EL2z4ENkx5v2IFHeA8p3?=
 =?iso-8859-1?Q?a+4bzJvsD+r0JzarRrSiH1rIBtMWfkVLNNlC97CYAo1Z+esz9QLdiXU6dv?=
 =?iso-8859-1?Q?husx3fECw1tE3PY0qwnWNwnxBhkDM0Ge83xhcoW9CdaDQ+Bz2f89Qb0a5K?=
 =?iso-8859-1?Q?n3V31mlhRI8g7VCDSme8lXokooDFl43X+SeMu5JY0TcmSeYWHHjYlRHX+K?=
 =?iso-8859-1?Q?EkzV1bn4pB/V58VU0Duxchm8NgvYMY7y+phDHaFkBTMz7bniNDGfSqZVAP?=
 =?iso-8859-1?Q?RyhXmplX8tVCy3hxtZy5Dywt1EHWiTKU97eYobpkv47uFxzdCq8BsZRRRo?=
 =?iso-8859-1?Q?C1NNPfvzb0qVOkthGFsSBVQVWfFmdWmRKoXDvFzR+HANVoZYV80YvgMA2J?=
 =?iso-8859-1?Q?RFRfXrnAEEBNKoS6kZvHa/7/3aleAyGnbvXsN7md2A4kuYjZ5B7Der4rn2?=
 =?iso-8859-1?Q?l/cjRjV039EnNVSomlIQmymaJXMYpZ4S283LMFft0Tr/sEZcXtwSUpAd00?=
 =?iso-8859-1?Q?ztd+E1pLLUzPgSVgKqOzJjuVJFGk5H2lMyLpoZrM8MGfWhtgeIIivOmPN4?=
 =?iso-8859-1?Q?8Y33YW9C4sepoDJvgp3mYChUaCqJPNLiPO4PHKu0IKFjkjB2gFcAaEm4y1?=
 =?iso-8859-1?Q?E7cRFk5GigESlpz19mDZr9CVpERljzBKDc3uk2/e6CXMTnYrl23bAi4G7b?=
 =?iso-8859-1?Q?+WRfXA/J0aTR0/aChumwDoYurWnWCirOqFtL1UObRucuo5TBGfqXfgLKgw?=
 =?iso-8859-1?Q?NCUKTx2oFLS2KoRgUHNdyWDbwstzBK3vlbvMyiHplPij4DSkSXGuJgFjU2?=
 =?iso-8859-1?Q?QkTY0uSKrawBl4QuSufiuLzR4bc0x0fVIy4PIOotN1gkmgGNXhaMONDxmu?=
 =?iso-8859-1?Q?/7T2ulWbFulCJxd9gLwUxPDxz2uV4Me2EfXK0Q3n?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 53817128-3c1b-4c5e-4cc5-08dd4da7cc28
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2025 10:02:03.6053
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4c8512ff-bac0-4d26-919a-ee6a4cecfc9d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dNLrwyDuledGm9VgWigJM6hnoQYL/YTr4BwgydZrqWbPO+wv3/prbLLOiyXcIWoFwkY+95yZHoDNvGv+ike76X/ubhYtCdTvv8bBXFkkCFY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10602

From:=A0Lucas Stach <l.stach@pengutronix.de>=0A=
Sent:=A0Friday, February 14, 2025 5:28 PM=0A=
=A0=0A=
>Hi Maud,=0A=
=0A=
>Am Freitag, dem 14.02.2025 um 16:57 +0100 schrieb Maud Spierings via B4=0A=
>Relay:=0A=
>> Up untill now the extra function mux (pull resistor, etc) has been=0A=
>> defined as a raw hex value, this is difficult to interpret. Add=0A=
>> definitions for these parts of the pinctrl registers to allow for more=
=0A=
>> readable pinctrl definitions in devictree files.=0A=
=0A=
>I certainly prefer the short form with the hex value, I find that quite=0A=
>a bit more readable than very verbose swathes of defines ORed together.=0A=
>But each to their own.=0A=
=0A=
I personally prefer it, but it would be accepted if I write a dts using thi=
s if it=0A=
gets accepted? I am currently working on devicetrees for all of our devices=
=0A=
preferably they would use this.=0A=
=0A=
>> At this point the patch is not complete, some pinctrl definitions set=0A=
>> bit 30 (0x40000000) but according to the reference manual this is a=0A=
>> reserved field, I currently have no way to identify what the meaning of=
=0A=
>> this bit is, I hope someone in this CC may be able to provide an answer=
=0A=
>> to this. It will then be fixed in the v2 of this patch.=0A=
=0A=
>This is not a mystery bit, it's used by the pinctrl driver to force=0A=
>enable the input path of the pad (SION). This is defined in the generic=0A=
>i.MX pinctrl binding, see=0A=
>Documentation/devicetree/bindings/pinctrl/fsl,imx-pinctrl.txt=0A=
=0A=
I had a suspicion that it was that but got confused because that is a diffe=
rent=0A=
register. Will change it to that in v2 somewhere next week.=0A=
=0A=
Kind regards,=0A=
Maud Spierings=0A=
=0A=

