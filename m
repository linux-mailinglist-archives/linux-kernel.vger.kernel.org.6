Return-Path: <linux-kernel+bounces-259111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 152B293915E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 17:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 386FE1C21790
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 15:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6AA16EBED;
	Mon, 22 Jul 2024 15:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="Qca7U5Vm"
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11022089.outbound.protection.outlook.com [52.101.66.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE1916EBEC;
	Mon, 22 Jul 2024 15:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721660745; cv=fail; b=KITmRcpt1ZLElJpxedIXuMjoONvgsXhLAYvk66M+eIjgLxFkqU+FfUTy2t5snVQaVgndJB7VzbOyti2KJ32xzt2m39AemAzEXoDFZ4ZSVx4BH2tnfp+wDBdm90hPSL1g6bexIpWwdYA3oeYynZ2YmbObxJC6jRpKi8t9swq1oto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721660745; c=relaxed/simple;
	bh=HBhgIi53RKuY5OlOfyAFurVoggsgK8U4+v6OuaCJvW0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=INdbs24KZ5Y3HbNCfQgfwVBVbu4aP0rB5+kelAFe1JdhejDxbkReXl2eHQM2KTsJxTr4BmXCZFCFSxS4Lyjo3bWDliAMS6rjFjPQ/vCGaEcza6IubJrE1rXqqBUc3ShcwlA+wWpU1f3GfiXK1gXctzZX2Tq8zdP0lCVJXQxT9GM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=Qca7U5Vm; arc=fail smtp.client-ip=52.101.66.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gmn3ZponsDSS1c8BE0B2SJZmgcQPbWaKKd4vGKyfuwlKoh++vp7wOPyTdTeJCGyZRbRy6cg9Qt45D2Crhxt+boN/wQvBpUR+bXjRD71fpyz22eKTxV/8AeaCKYZyIaQ+PrXd2eucT34HehwnLK+CEBksNzSTYQXbj4axtRKG9mabZBptHCJHypT6We5tZO+TXKyp3n7Lgem05ZqEPdgiLbU2Lh3pBnXLVvPLaeP/60olYbitufdvsBzqRzSwuyPakCUHYqlyTO8S2v9TGXKmAgMFlNFdy6d3yyFriaf2bVYomBEyxCTrjOV+NwDURLHtVZXyNpndP+rFQEucL8fR0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HBhgIi53RKuY5OlOfyAFurVoggsgK8U4+v6OuaCJvW0=;
 b=AS8z242INf7BxYqo/iO7FTaUsKDBHOXUC5VBugfibqX/RfToQhs6Bs92AD0Zrq2VbezYMFkkqodY1Ywk2FSCs/wIl27VHOSDsytPUi4PXinbjy3JywoW285kXe/8p3A7f/F8cRBIll5MSq2igw2wvc/mN/UyCaWtSUnBzkb/dJBmy9SImz6z2ZAPdFWuaFg2+9Y16O28lcA3SaxTyEQaZydsxKDHOjlZ3e3oECHaUgpTvozyB6FlsVGEwbkqJmBp0+NOkDOxd+LqOTv7L8KTsms6TeNsJjqpXhpUWsPMm2SKDzdhAzkUbndII9k753wvHpN4miZNhaYMfra/ktLrDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HBhgIi53RKuY5OlOfyAFurVoggsgK8U4+v6OuaCJvW0=;
 b=Qca7U5VmmvHQGqnUEM7qnFmrjI9U3ePJN+wPgGIPow7QJWNkgrGgucJWu9sLMh4EYpa488jIcsoXRRAcym1DakbA7QAa2W6eBODnZcD/m3eTovndrbspsYaFxEJUriKPHOCfd8x7TJU01Fn4Jcy5fiDk/DXHlnRj3VAYQ3vRAEc=
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by VI2PR04MB10091.eurprd04.prod.outlook.com (2603:10a6:800:22f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.19; Mon, 22 Jul
 2024 15:05:38 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%3]) with mapi id 15.20.7762.027; Mon, 22 Jul 2024
 15:05:38 +0000
From: Josua Mayer <josua@solid-run.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>, Sebastian Hesselbarth
	<sebastian.hesselbarth@gmail.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Russell
 King <linux@armlinux.org.uk>, Konstantin Porotchkin <kostap@marvell.com>
CC: Yazan Shhady <yazan.shhady@solid-run.com>, "linux-phy@lists.infradead.org"
	<linux-phy@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: Re: [PATCH RFC v3 3/6] dt-bindings: phy: cp110-utmi-phy: add
 compatible string for armada-38x
Thread-Topic: [PATCH RFC v3 3/6] dt-bindings: phy: cp110-utmi-phy: add
 compatible string for armada-38x
Thread-Index: AQHa2q/UwdGhmeTzHkyvzzjdx6DlRrIA7BMAgAHvxgA=
Date: Mon, 22 Jul 2024 15:05:38 +0000
Message-ID: <14090e3b-e627-4342-91b0-d6d0b769b736@solid-run.com>
References: <20240720-a38x-utmi-phy-v3-0-4c16f9abdbdc@solid-run.com>
 <20240720-a38x-utmi-phy-v3-3-4c16f9abdbdc@solid-run.com>
 <d48d261f-c428-4b96-9a88-725e29f6648f@kernel.org>
In-Reply-To: <d48d261f-c428-4b96-9a88-725e29f6648f@kernel.org>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB7586:EE_|VI2PR04MB10091:EE_
x-ms-office365-filtering-correlation-id: 47da6108-b4bb-4096-8dfc-08dcaa5fbf05
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZjRSakRBY0JNZThwdkhOOE9DbmwvVFFmQi9TUmE1ajM3K2FiTzBRUExneVVS?=
 =?utf-8?B?M0pyVElIRUhCNHd3a2ZXOVhHWm85R2VVV0JROXpqdlJwVDhSbzB4aWQ3U2N1?=
 =?utf-8?B?b0lOeisvYXREK3dFaUdBNnAvNHlPRktmUHBmaytmN3Y0ek1MQ1NQdzgxQzZt?=
 =?utf-8?B?dUFXMVVLRElaa2xQbkxIQU56RWRUci9jMk1CNVM2a2ZFMlpBbUdiRzVEb2FK?=
 =?utf-8?B?YVFCaW4zR3FmbzhwcW85ZngwdlhMc1laL0FEQWtSM2dDUTV0Y3lZOWRoa21T?=
 =?utf-8?B?VjVhMkRSK0VDRWROOEp3aFhhWThENnVHLy9iTmkweEc3emxxVzJrc1VMZmgw?=
 =?utf-8?B?WmdJeW04ay9nMVhqMTEvSHdwVUdDSm5PQjJnbzhaeEYwL1ZsRko0MzVSZzNs?=
 =?utf-8?B?eDhTdjZXTXp6VG5DU01SVVl2MU5VV2MyL2xZTldSS0dvR2lod1FIVmlFcnBx?=
 =?utf-8?B?K0RYcVJRaXJyM00zVW5XT2c1TVFkNGcweG5ndWxobDB4Qkxsb29HaWNzMGE5?=
 =?utf-8?B?T1NqL05qT3EvdXVWckNENzdPRUxoNE0wZUx1cTRFeEJieTU2S3c3TnNuRE9T?=
 =?utf-8?B?Vzd6NXg3NlBtR1BHRlNkWlBjaFA1Wm5Dd0xybUdrZ05LRjNjQVBsUy95K3hS?=
 =?utf-8?B?Z05WZ2J5ZkhRd293Q0JpRkRmbXh1dHZlMGlNQW9XZVV1NHFUNDFkY0hEeFRT?=
 =?utf-8?B?Z3RsVHd1SUpiNXo1VUV2UE9teGdaTStzeWM1RDdyNS9UaHVkMmdCT0xHeis0?=
 =?utf-8?B?a01MWXEzWTZ3QVYwSzdkYzdPNTRCaDJsaFRPeVVlSDlBaDZPbUhTZFhIWHJQ?=
 =?utf-8?B?ZjZJbTRCOVV2TEs4S3hFa01lcDNHWHd5ZEhqWnFLNVR1d0xUeTc3WXA2cTA3?=
 =?utf-8?B?Qnp0S3c0MXdiOVRVekhDUG1kbnU1SUl2WUc4U2lBZzhOZTA3TFJJMjlzM2NI?=
 =?utf-8?B?Wkh5ZlNYRzI3R3Z5Nk5ickNNaWRwMnI4TWR2K1g4dUIxT21yRFdlNm1GVTVi?=
 =?utf-8?B?Z3VyTmxCUlAxTko4WUsvU01oZmErSTBHSmpQRDh3UDkrODcyZVo2V05yY3hV?=
 =?utf-8?B?MkMxSzFKV3BYemZCMXc1YTNsZGJKTUNsOVp3SUhYcHU0MVZqaUlIb1pEaERZ?=
 =?utf-8?B?T2tqQ2tHaDU2TER3NE9IQXkwbmJIbTFpWGVwLzNGZUtqdVI3VFBPSkxjOGgr?=
 =?utf-8?B?RjZUb1VCeS9kb2t5a2lzWXFtSWpPd2dOVHVieVNjZTdvd3Y2cU5vWmZ3U1BP?=
 =?utf-8?B?aUl5UDJoS0RDUUlYbllqSytQWDhKTDRsRDQyeWJ2c09pV1FEcHU4aTUreXNG?=
 =?utf-8?B?eWc3S1R6Q05HUk5CZEE5ZFRENUNhbTRTSXVla3RYYUZTcUhEQ25MQjI4ZFJy?=
 =?utf-8?B?RXhHcDloVUR4VEMrZG9tZ3NhcWxiQzcreEhGRTM4YkNhQXhsTUNyakE3dDh5?=
 =?utf-8?B?OSthNzhvL3lybExlU2d3UURoRnFnakNDakRKYVFLSGpsZTFUNkhZZllIb2VD?=
 =?utf-8?B?Skp0RzUxMFdOOXlraVlZSlNKYlRtbVZYNzhOWkU4ajE3RC9rNStpT2gxdXY2?=
 =?utf-8?B?SlV5MURQVUJac2hPbnFQZU10ZnRhR0wreGgvTW1sbHRXWG1FZXhuSTV6Y2Y3?=
 =?utf-8?B?TTZCVXBsUGlNeFV2dGY3bFdJalp5SzV1cVFPc0Q5b1pnVGUrdllPcTRsR01Y?=
 =?utf-8?B?czJlc09HN2k0eDhvS25Bc1d5NXRPV1pLVnJUVDdENVMxVHJvempZdjBUMzhF?=
 =?utf-8?B?a1FBVlkxektoRFZjbjE5TVZnSXFPeHlEZGdpK3R1T1NKQm53N1hNRTJXUjJU?=
 =?utf-8?B?RWY2aXpFRUNXckxtUGxLcTRqb3ZLaXBWY1o5U1NEWkx6YTJSVEJkby9qUlJj?=
 =?utf-8?B?S3dhSENSMlFiNHNJb0Y1ZDZBK3h2Mm5uQTdqMzdpT1lhWFFvNHBjbWlBUEZZ?=
 =?utf-8?Q?FRwG5hB9FXg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QjllZFRnUnUxQ0duY1Ewd0hoS2dJTllIZE9JQ3ZSeVZuQnBMZWtRalhoTjB3?=
 =?utf-8?B?Z2V0M0RYR29Vc2ZDK3FFR1RSdUc5bENuenk0V3ZHVDNmSUlMd2hmYUozdyt5?=
 =?utf-8?B?VkFWZGN1RTkvMXJkd3lOa1hPSG56c3EyNXVuUUp2Z3VqTTY3ZHRaNFE2M1Rj?=
 =?utf-8?B?WHUySUFnSXd6REsvdlR3M0FzdlJRWDRmS29aUmZIZy9MMVdUbmEzeURtVHhQ?=
 =?utf-8?B?WGl5RG9rQmNTWlhwTE1mRUVwcmptSUg1NEFpdGhiU1MxRmZYaktTSzVkcW4w?=
 =?utf-8?B?NnVzc1JraG9IQmtpeTU1MGlIV1N2NHozRC9GcmpKV3AvTHdtV29nRUxlWG4z?=
 =?utf-8?B?YmFqZEZwem5zRFZoZWk3OXRUK2xFQ1l6TEhBb2Y5OXZQMmN0RzlsMnhvN05U?=
 =?utf-8?B?aUJjTjRJaXlmY0ZGbXIxZGlKVGcremJiQitNeEVoNHdBb3JIZGxyQW5QeVBQ?=
 =?utf-8?B?OGZUdDF3R01jd2xldnkyRlR2TkJ2YmNwYitESnFDWm4zUHc4eGpDRzU5cnlR?=
 =?utf-8?B?ZlllUjhPU0tybkg3VXlpNlFEZkt2RlJQdG53VnJTaDFUMHlzaUdGM1lDcURs?=
 =?utf-8?B?dmYrUFhmUGkwU0NqVmJZeUdUdHR5UGUycmpZdmM3clV3ZGUzb0NzTU42R0RX?=
 =?utf-8?B?WlJNalVtUmtrRy9yNFNsbEgvWERIWU9zVklyZCtpSEtiREdEVm1QNlFZL1VZ?=
 =?utf-8?B?YU1JVlJ5QkN1VGVEMVRQQ2FmMG9hMzBTTmpmVG9JNFRQQ0tab1FNQmlGbmJ4?=
 =?utf-8?B?KzY4YldFbWpOSHMvak10N01sd0Q4RUxxYUlNREFReTZSYTZ1SHNydEk5a0hU?=
 =?utf-8?B?clRFSG0yeEEwOFhOR0N0VlpyTCt5VHRhTmd2K01ld0NKbjZjR0ZFTzRQOEZp?=
 =?utf-8?B?d1pLRDJGOEJYSWl5TCt6Rk16OGIwc2k3WUUzQlFsZnk4U3lhTVB6MHVRWUg3?=
 =?utf-8?B?ODJCd0taUmFrZUxWOGFTYkpob25OemJlWjV3OU9zdnZ0a1RjZ2VOMmpUQkdt?=
 =?utf-8?B?ZDlKUHErclVxeUQvRVpJRVJZaHhvQVJXTk5qVktkbUhiVEtmUkw3RElCU25r?=
 =?utf-8?B?cHB5UnR2RnhxcmlZclNpVUc4aUhLWkR3M3o4aFFQSVZGQzdKZ0Fqb2I1M1A2?=
 =?utf-8?B?cElZYTdFT1NmNHdGMkNrbzN1bGhvdzJLYXF1NzNQaGVSM1FoaTJQczFUS3lW?=
 =?utf-8?B?OUhrN1N4NmFsSmE0bG1xcTBrQlhWendvY0VnN1hNWnpLSUd0R1lnVFFoUmZm?=
 =?utf-8?B?dmNldG9mcGE5OUZ5QkVwcWx1WFJFYU1tWk82YndvbEU5ZE9uNFNKZlZISjNk?=
 =?utf-8?B?VGlSSmltZ1NEc2FnT1ppQU15bG5YZzZoK2QwREdpUW5BQjRkLzNXN2IyUnRN?=
 =?utf-8?B?dUpkSHhTL2xHSE9iODhqTFJnMGVyaHk4U3BjWUFDZU1lbGhUK05sNzFXMFNS?=
 =?utf-8?B?Ymk2MWVmWERMUlZoZTVldmdFTW9neTdlay9Uak1aVzZoZ0FTYXg0Yi9wNVF3?=
 =?utf-8?B?dVd0R3JORCtZV0F1Y1Mreng0TWF2cDJUR1R6UFNVSVVOY0o4UG1EaEJXUXJP?=
 =?utf-8?B?N0dEY29MSElDa1MzMm43TzdTb2RjS3VuaFdlTFZWbzRMZm12YUoySEFEMlVS?=
 =?utf-8?B?V29mSzNaWXJ4Yzd2VEVjenUzRUdqSVlmTXk4d2xZdjlLVzdOd2pPVzhhVisy?=
 =?utf-8?B?eU5JRlB0S2RFR1VWRW5lOXY2bWJjMHl4WHBRZ3R5Qmc0emV0RFJuSjFQNVJQ?=
 =?utf-8?B?Ym9VQU5YZ2thUUNWNmJjQnRIdnFpT2llaEFUSTRtOXNMcURrUUsvTGxoV2dZ?=
 =?utf-8?B?SkI4SW55RkpnVWFqNjl4Y0tKbjhMMUp2T2lUM3JudHpCVFVJY3hkWVVQUm02?=
 =?utf-8?B?QUJHd0dwVkRNbUsyQTJQWEFoT05IVlEyWml6Y3RtN2Iza095bjB4dVp6NVlW?=
 =?utf-8?B?WmNLdmkzWG45M2JNUmFuc3F0TUsvYU1xZ1hGK0lFcmZ2ZGNXQVpUeGF3NUxt?=
 =?utf-8?B?aDEwSGwrcUl0TUo5ZzNVYUJjV1NHTHJrM09nY1dldUYxS1NzdjNpT3FLVUpV?=
 =?utf-8?B?aEIvSzFKUWJwWEhseVZZVjhhcktBdE9vZC80enhBRklRY0ZkWWJpbGQvdWdl?=
 =?utf-8?Q?DBQ0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C1D115DBD42A584EA7D8E1D6AE9FAD69@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47da6108-b4bb-4096-8dfc-08dcaa5fbf05
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2024 15:05:38.2743
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qGPUsmcTEHjgQ1LGzVKbdrB7a6qd/xaGuDk2rPcatdlgtLlyuArhOOAN2qHIOfw6SkCiFUVKBpCrJNTzPPK2mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10091

DQpBbSAyMS4wNy4yNCB1bSAxMTozMSBzY2hyaWViIEtyenlzenRvZiBLb3psb3dza2k6DQo+IE9u
IDIwLzA3LzIwMjQgMTY6MTksIEpvc3VhIE1heWVyIHdyb3RlOg0KPj4gQXJtYWRhIDM4eCBVU0It
Mi4wIFBIWXMgYXJlIHNpbWlsYXIgdG8gQXJtYWRhIDhLIChDUDExMCkgYW5kIGNhbiBiZQ0KPj4g
c3VwcG9ydGVkIGJ5IHRoZSBzYW1lIGRyaXZlciB3aXRoIHNtYWxsIGRpZmZlcmVuY2VzLg0KPj4N
Cj4+IEFkZCBuZXcgY29tcGF0aWJsZSBzdHJpbmcgZm9yIGFybWFkYS0zOHggdmFyaWFudCBvZiB1
dG1pIHBoeS4NCj4+IFRoZW4gYWRkIGRlc2NyaXB0aW9ucyBhbmQgbmFtZXMgZm9yIHR3byBhZGRp
dGlvbmFsIHJlZ2lzdGVyIGRlZmluaXRpb25zDQo+PiB0aGF0IG1heSBiZSBzcGVjaWZpZWQgaW5z
dGVhZCBvZiBhIHN5c2NvbiBwaGFuZGxlLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IEpvc3VhIE1h
eWVyIDxqb3N1YUBzb2xpZC1ydW4uY29tPg0KPj4gLS0tDQo+PiAgLi4uL3BoeS9tYXJ2ZWxsLGFy
bWFkYS1jcDExMC11dG1pLXBoeS55YW1sICAgICAgICAgfCAzNCArKysrKysrKysrKysrKysrKyst
LS0tDQo+PiAgMSBmaWxlIGNoYW5nZWQsIDI5IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0p
DQo+Pg0KPj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9w
aHkvbWFydmVsbCxhcm1hZGEtY3AxMTAtdXRtaS1waHkueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9waHkvbWFydmVsbCxhcm1hZGEtY3AxMTAtdXRtaS1waHkueWFtbA0K
Pj4gaW5kZXggOWNlN2I0YzZkMjA4Li4yNDZlNDhkNTE3NTUgMTAwNjQ0DQo+PiAtLS0gYS9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGh5L21hcnZlbGwsYXJtYWRhLWNwMTEwLXV0
bWktcGh5LnlhbWwNCj4+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9w
aHkvbWFydmVsbCxhcm1hZGEtY3AxMTAtdXRtaS1waHkueWFtbA0KPj4gQEAgLTIzLDEyICsyMywz
NiBAQCBkZXNjcmlwdGlvbjoNCj4+ICAgIFVUTUkgUEhZMSAgLS0tLS0tLS1cDQo+PiAgICAgICAg
ICAgICAgICAgICAgICAgIDEuSC0tLS0tIFVTQiBIT1NUMQ0KPj4gIA0KPj4gKyAgT24gQXJtYWRh
IDM4MCB0aGVyZSBpcyBhbiBhZGRpdGlvbmFsIFVTQi0yLjAtb25seSBjb250cm9sbGVyLA0KPj4g
KyAgYW5kIGFuIGFkZGl0aW9uYWwgVVRNSSBQSFkgcmVzcGVjdGl2ZWx5Lg0KPj4gKyAgVGhlIFVT
QiBkZXZpY2UgY29udHJvbGxlciBjYW4gb25seSBiZSBjb25uZWN0ZWQgdG8gYSBzaW5nbGUgVVRN
SSBQSFkgcG9ydCwNCj4+ICsgIGVpdGhlciBVVE1JIFBIWTAgb3IgVVRNSSBQSFkyLg0KPj4gKw0K
Pj4gKw0KPj4gKw0KPiBPbmUgYmxhbmsgbGluZSBpcyBlbm91Z2guDQpBY2suDQo+DQo+PiAgcHJv
cGVydGllczoNCj4+ICAgIGNvbXBhdGlibGU6DQo+PiAtICAgIGNvbnN0OiBtYXJ2ZWxsLGNwMTEw
LXV0bWktcGh5DQo+PiArICAgIGVudW06DQo+PiArICAgICAgLSBtYXJ2ZWxsLGEzOHgtdXRtaS1w
aHkNCj4+ICsgICAgICAtIG1hcnZlbGwsY3AxMTAtdXRtaS1waHkNCj4+ICANCj4+ICAgIHJlZzoN
Cj4+IC0gICAgbWF4SXRlbXM6IDENCj4+ICsgICAgYW55T2Y6DQo+IFRoYXQncyBvbmVPZi4NCg0K
QWNrbm93bGVkZ2VkLCB0aGFua3MhDQoNClRvZGF5IG9uZU9mIHNlZW1zIGNvcnJlY3QgdG8gbWUs
IHRvby4NCg0KPg0KPj4gKyAgICAgIC0gaXRlbXM6DQo+PiArICAgICAgICAgIC0gZGVzY3JpcHRp
b246IFVUTUkgcmVnaXN0ZXJzDQo+PiArICAgICAgLSBpdGVtczoNCj4+ICsgICAgICAgICAgLSBk
ZXNjcmlwdGlvbjogVVRNSSByZWdpc3RlcnMNCj4+ICsgICAgICAgICAgLSBkZXNjcmlwdGlvbjog
VVNCIGNvbmZpZyByZWdpc3Rlcg0KPj4gKyAgICAgICAgICAtIGRlc2NyaXB0aW9uOiBVVE1JIGNv
bmZpZyByZWdpc3RlcnMNCj4+ICsNCj4+ICsgIHJlZy1uYW1lczoNCj4+ICsgICAgYW55T2Y6DQo+
IG9uZU9mDQpBY2suDQo+DQo+PiArICAgICAgLSBpdGVtczoNCj4+ICsgICAgICAgICAgLSBjb25z
dDogdXRtaQ0KPj4gKyAgICAgIC0gaXRlbXM6DQo+PiArICAgICAgICAgIC0gY29uc3Q6IHV0bWkN
Cj4+ICsgICAgICAgICAgLSBjb25zdDogdXNiLWNmZw0KPj4gKyAgICAgICAgICAtIGNvbnN0OiB1
dG1pLWNmZw0KPj4gIA0KPj4gICAgIiNhZGRyZXNzLWNlbGxzIjoNCj4+ICAgICAgY29uc3Q6IDEN
Cj4+IEBAIC0zOCwxMyArNjIsMTQgQEAgcHJvcGVydGllczoNCj4+ICANCj4+ICAgIG1hcnZlbGws
c3lzdGVtLWNvbnRyb2xsZXI6DQo+PiAgICAgIGRlc2NyaXB0aW9uOg0KPj4gLSAgICAgIFBoYW5k
bGUgdG8gdGhlIHN5c3RlbSBjb250cm9sbGVyIG5vZGUNCj4+ICsgICAgICBQaGFuZGxlIHRvIHRo
ZSBzeXN0ZW0gY29udHJvbGxlciBub2RlLg0KPj4gKyAgICAgIE9wdGlvbmFsIHdoZW4gdXNiLWNm
ZyBhbmQgdXRtaS1jZmcgcmVncyBhcmUgZ2l2ZW4uDQo+PiAgICAgICRyZWY6IC9zY2hlbWFzL3R5
cGVzLnlhbWwjL2RlZmluaXRpb25zL3BoYW5kbGUNCj4+ICANCj4+ICAjIFJlcXVpcmVkIGNoaWxk
IG5vZGVzOg0KPj4gIA0KPj4gIHBhdHRlcm5Qcm9wZXJ0aWVzOg0KPj4gLSAgIl51c2ItcGh5QFsw
fDFdJCI6DQo+PiArICAiXnVzYi1waHlAWzB8MXwyXSQiOg0KPiBbMC0yXQ0KQWNrLg0KPg0KPj4g
ICAgICB0eXBlOiBvYmplY3QNCj4+ICAgICAgZGVzY3JpcHRpb246DQo+PiAgICAgICAgRWFjaCBV
VE1JIFBIWSBwb3J0IG11c3QgYmUgcmVwcmVzZW50ZWQgYXMgYSBzdWItbm9kZS4NCj4+IEBAIC02
OCw3ICs5Myw2IEBAIHJlcXVpcmVkOg0KPj4gICAgLSByZWcNCj4+ICAgIC0gIiNhZGRyZXNzLWNl
bGxzIg0KPj4gICAgLSAiI3NpemUtY2VsbHMiDQo+PiAtICAtIG1hcnZlbGwsc3lzdGVtLWNvbnRy
b2xsZXINCj4geW91IG1pc3MgaGVyZSBhbGxPZjppZjp0aGVuOiBuYXJyb3dpbmcgYW5kIG1hcnZl
bGwsc3lzdGVtLWNvbnRyb2xsZXIgcGVyDQo+IGVhY2ggdmFyaWFudC4NCkNvcnJlY3QuDQpJIHdp
bGwgbGVhcm4gaG93IHRvIGRvIHRoYXQsIGFuZCBpbmNsdWRlZCBpdCBhIG5vbi1yZmMgdmVyc2lv
bi4NCg0KDQpUaGFua3MhDQoNCnNpbmNlcmVseQ0KSm9zdWEgTWF5ZXINCg0K

