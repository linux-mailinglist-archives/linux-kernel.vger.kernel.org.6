Return-Path: <linux-kernel+bounces-413034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CAE09D128F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 15:01:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E53A281628
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 14:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A710A1A01B3;
	Mon, 18 Nov 2024 14:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zuehlke.com header.i=@zuehlke.com header.b="J2e6EISk"
Received: from GVAP278CU002.outbound.protection.outlook.com (mail-switzerlandwestazon11020078.outbound.protection.outlook.com [52.101.188.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814838836;
	Mon, 18 Nov 2024 14:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.188.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731938456; cv=fail; b=UAJNa6I8EAoa6iM3dW6Od0VvrQ5DreCCi0Qb0HePW5cND5gwp6wi8qd/xg9YSPSiN/EBw131T/ZgOw9U4JOm4oGQ6LTTxzlhrM+O70St/0VPw7FovgxDl2oivih/FzHLVMjR4V1IKMvN4MiRw6JZJ1PhuHPXbljfsuYAKLe/lsw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731938456; c=relaxed/simple;
	bh=W1KlV05vEj7y17aPjtWi08DBsHugB1vH5qfD9h+atQg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OgjAthJOj2bWzyHfayl/ohO2eKZxhSWbN+HMd320fXgAAw85GqTqSDrRLuxmN2DIHaY0506jc2KcEuRrzvHcTrL9V1A+SHUOSSsU/gJj7A7anrQEoeb/SnY752kx9UJttlRUZs85FFRBZgkoWFQ6FJWwy1SNLbItLDgMB3EkM/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zuehlke.com; spf=pass smtp.mailfrom=zuehlke.com; dkim=pass (1024-bit key) header.d=zuehlke.com header.i=@zuehlke.com header.b=J2e6EISk; arc=fail smtp.client-ip=52.101.188.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zuehlke.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zuehlke.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ktdaLTeCIPWqxMRgZ0obCpUvdnsKkSbAF0Wy9H8NLpyPo7xAm6gqiqDdywkajid4CYXzapJApcrGFIsf5KjXjuM3/CFPkcqoJdw1OENxwdsqSSpAhHusMwqRD7ujGZHWiJboywB+Zgz4FqQRqA6QIbqXd6wp3ZESMkhGglzLA9qUYmBJsdKGEejyLZ/AzzknBDuPE3Hz5HTVvN93Abid9/WDLgR2e6isJnNZJyoCcOXx6Lg2yIozX2+4v2U4oDUabUol17z4WcaQn9+YUSSzgM+siMsI823pUnFbhRQfJyuDrKFiVsvNBd3xEMCLh6IiD7rVYf3Q3jQB0hR9LFSXbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8MTlHKFUYTmE5Lc5QMEGd3SNCq0WVteKnR7rXLrYe18=;
 b=rYgvdl5clyP0aY5otIZZsckVbpE6o25c59aNgEf1ERgH5y1ZzYBiqO3KQGC3Jm7CtyV4sA1JZJs3cxHFjIR/TI7Lyqy++epRR0xai9nhtqK17UN33ITiXqAXDPt8VmRTZAz9R6/Z8rrmTHJhMhBkWgO5QT8wcvM7mBjKm84IfsTpV+o4E0Rr+iarQF7bryZM5+ol492PF98lS6qMFlTWDuq2waJ2N88q/2PXVnmt536uVT5CQlVmYgUBiGS4NKtfJveuStgrwJd06sQoYbRunxvhA2eenVcPGBVS1gRXquVskbI+sSI797vCKizUxz3DL7nsComuSe1b55dOZXVlDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zuehlke.com; dmarc=pass action=none header.from=zuehlke.com;
 dkim=pass header.d=zuehlke.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zuehlke.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8MTlHKFUYTmE5Lc5QMEGd3SNCq0WVteKnR7rXLrYe18=;
 b=J2e6EISk/2Rmc1q/TryN/ZXJl3n81k8rI7ol3O2Clqv19yvEilvYpJgFiFDL5y7DPWs1bnjliqv2q1gIBWmNqkoolFSbjMe6syQoryolABBzYU6YjfrEjM92BF2N5SInSqSjYZu07KIjcKrAGPUpqg5tdBacXEpBWLmB7w0FDlY=
Received: from ZR1P278MB1022.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:5c::8) by
 ZR0P278MB0123.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:19::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.23; Mon, 18 Nov 2024 14:00:41 +0000
Received: from ZR1P278MB1022.CHEP278.PROD.OUTLOOK.COM
 ([fe80::c887:bd2f:4c91:3d13]) by ZR1P278MB1022.CHEP278.PROD.OUTLOOK.COM
 ([fe80::c887:bd2f:4c91:3d13%3]) with mapi id 15.20.8158.023; Mon, 18 Nov 2024
 14:00:41 +0000
From: =?iso-8859-1?Q?Facklam=2C_Oliv=E9r?= <oliver.facklam@zuehlke.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
CC: Biju Das <biju.das@bp.renesas.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "von Heyl, Benedict"
	<benedict.vonheyl@zuehlke.com>, =?iso-8859-1?Q?F=F6rst=2C_Mathis?=
	<mathis.foerst@zuehlke.com>, "Glettig, Michael" <Michael.Glettig@zuehlke.com>
Subject: RE: [PATCH v2 3/4] usb: typec: hd3ss3220: support configuring port
 type
Thread-Topic: [PATCH v2 3/4] usb: typec: hd3ss3220: support configuring port
 type
Thread-Index: AQHbNmuKAbQgSYuDD0+aIkfTlZwMRLK88xQAgAAYJXA=
Date: Mon, 18 Nov 2024 14:00:41 +0000
Message-ID:
 <ZR1P278MB10224924F48419CA813402309F272@ZR1P278MB1022.CHEP278.PROD.OUTLOOK.COM>
References:
 <20241114-usb-typec-controller-enhancements-v2-0-362376856aea@zuehlke.com>
 <20241114-usb-typec-controller-enhancements-v2-3-362376856aea@zuehlke.com>
 <Zzsp2JOhnnPPOWvB@kuha.fi.intel.com>
In-Reply-To: <Zzsp2JOhnnPPOWvB@kuha.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-processedbytemplafy: true
x-templafyemailsigvstoversion: 9.16.0.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=zuehlke.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR1P278MB1022:EE_|ZR0P278MB0123:EE_
x-ms-office365-filtering-correlation-id: 0106987f-7e9d-4213-8dfd-08dd07d9638c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?04RoPq7t0vXDgtTUsNtculpER4w4mPbn+i7Xr92R8Ms5ttw1AhA5PEvLpi?=
 =?iso-8859-1?Q?6NNMSY1MHzWRa2S+ZIj1V2ThwsJSXTSZ9ElRRJpB+Qt1WKBtNvsKs69RzN?=
 =?iso-8859-1?Q?h7ArMV0xHO/bpE0Mmt2bDzhmLW+K9Wkr+r72epv/racDRQwh1zq1eFzpY+?=
 =?iso-8859-1?Q?ESXOok5EZGaXjMeP9MVOzEaNm9+kf94MUYkpBf85BkCFg5r2JV06O4OUum?=
 =?iso-8859-1?Q?Jp+OngD2hkD0R72TMzRuPj/pPEnR5gURS2VpVErVR0r/WiUjwWLuGx+1PN?=
 =?iso-8859-1?Q?8KFVUEfe/AZEIT1TGsN4EvFQmsGvBle8kxvRIkg/G0o4NVn2fT+QK6kwCK?=
 =?iso-8859-1?Q?UnD8k6gQ2W6Eoe2/31Lv9MojRiu1EkikMWORxseHqXfzyNOiGGmpyX7mXW?=
 =?iso-8859-1?Q?7YpmQyQO/DHlw9Qf4/zw6A97E50XlNqC6FLRq32EE7HswFpd/fsUAWA+9v?=
 =?iso-8859-1?Q?m22q3O8H500bc73MtwkTZlaKMbVwGd33D86vsKRZgFWPGzTHZRujPy41KP?=
 =?iso-8859-1?Q?6MAsFgSh7Sml9as0URvASppFRzYKEpzAtAf5GdF/N8Kou2WNhGbYf5REU2?=
 =?iso-8859-1?Q?bylSmngAng0Y8w6gzBlh0o/T5x3ADLakL7Uv5Ne7W9/OkrmgnjLYIWtWxt?=
 =?iso-8859-1?Q?TOOPv+TOPjh2jUo3oD+KELKnpHWlWrWCuKh5RYhx1Psw9PLIQiVPT7Et2k?=
 =?iso-8859-1?Q?fjt3yq4gIIM+2i+frkHNZYMd8HTXvFyiyITWBICzoBYo2fwO9mipyDiP83?=
 =?iso-8859-1?Q?nxSjLaq/UasOsyvTi83DIRcOyRfY59/PvyYrApIUoW3RJPjWKvuhx3/rfK?=
 =?iso-8859-1?Q?NmTyWlpd/Rw1FFu/F8HGb75bEG4FLRouilp+s8Fya6akUaI1hZVuU7gjI7?=
 =?iso-8859-1?Q?7x1OGChSqWrzf4icBj/7BnM8LdPidYjVp2WaZy1rIb92SdnpE9mACchJS2?=
 =?iso-8859-1?Q?nzfra+eXaQibkSTo7gRua4hVYqzGIFoH/AbTeb8frffTRBKiS/wsyvB3ls?=
 =?iso-8859-1?Q?kbhqStfNBK8TcN5v0wVaXgZpFpXjd49mJzwtTEPxBlFyjN2AWwn0wTgNLM?=
 =?iso-8859-1?Q?Gt/Y2engpoBdxDLIp2NvvxTnYtQHceqxOfM4PKjNrXyv7DNYjR42IpWL9v?=
 =?iso-8859-1?Q?6RfWqacr8K4NBG9LrkbcegnRb2MBgmQkh/3V1k0NLWTUP/NYa4WHC/dopK?=
 =?iso-8859-1?Q?xDddvkcve6NhJsk0kTZ5l9rXCJbMUdKJQKWc0zcRjWXmWU6ipoeXte06cc?=
 =?iso-8859-1?Q?Fmt5neP65Xu2tpNWG4dLOp6sH0ViGzryy8MB3CByTZ1oSbjsCtMVr2quQr?=
 =?iso-8859-1?Q?ka/l/qQ6XKRyWBC5aQjoZL2oUx9+yrcyVP8FsvjVS7eOHgmypKoBJv+bqF?=
 =?iso-8859-1?Q?6oxRlxvaZWeWPMvPcq+ZdARawX4o0gBN/mjrUMiFrE7xK3mj9RfxE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR1P278MB1022.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?QvSy1f2p9z8lA1latHjPCLavzhsOfRLt/9WwK+433kJnDileVSzsvhSQi+?=
 =?iso-8859-1?Q?vbzhjM2+cqSrAn6auh1HZE1FAMGqN8axFd7iIB5y50Z4bP+QrADuj+vprn?=
 =?iso-8859-1?Q?rCt++NofcWosxzmeuq0dcu4NoG93Wcbhxku99AN/iPtDnmQHJo3WqyenLe?=
 =?iso-8859-1?Q?KMcdxjN0IQB8BBLFmcA+K2SsWxUaYr2Vq6iPu8Pnu22921XVD4N0rRxEIB?=
 =?iso-8859-1?Q?rzaY7GkAzn92nblxTjhXcIM3L5MRTNmWb4or0vRplL3QW3G7pfFkd08jBs?=
 =?iso-8859-1?Q?VKqXKU4BHBiPxyEx/vYkGmM++r4aPg6oUVUqLEtQSpQmMjxIog90BlUZBg?=
 =?iso-8859-1?Q?z5Aj+NvjK1shNhzTYR2lER/Dz0f6PoE3MRmPiDZ8uvto8qa7q3DW0sjKL0?=
 =?iso-8859-1?Q?PLqZjN7QyZ8asf02uJJEmIcVq9G0/T+96Lj3uRE7MYWI4oV8D7U7d/C3v7?=
 =?iso-8859-1?Q?ITQ39Elxl1hirZprsfkEWaphSC4HT30tD+B+Pizn+F4z42h+KN6hjaBrri?=
 =?iso-8859-1?Q?JzipId6iPqdM9JVGpZCG/kv2rjwGRQ9aNcUVErKUp/L8aJiUNlj27ALPeM?=
 =?iso-8859-1?Q?L6Y8UR6nufeSLScuwGHx9WnAp8Elrx2B84A2zqlhO+8vCN7+TGzTT+JP6i?=
 =?iso-8859-1?Q?kDllbFnJa2J4Cr6Be7lDVrBuCYTdo76D0b38kql8aToGLLV7107mNo7CW9?=
 =?iso-8859-1?Q?4mOjNHRJfMa93M2sTxIKpfHe1G3jT89eOkvQe33YC8eEY6Ytvox4toottU?=
 =?iso-8859-1?Q?PK/j0HSyvqyC0OI0VMq0GrV4uJf3Y5AMIBqURL/fL/37ypLOZCn+DcwGOd?=
 =?iso-8859-1?Q?lKI14prdWmCOmruCkFiVVsJh5LGRJ8RLNMO0vtA1ROlz9Lz7UykoF22/NK?=
 =?iso-8859-1?Q?tvd+H2LODcpShHbTAyoYmeqoSk2Ei96fvYwJAeFVY/l6KoLkhXu9vLLUEg?=
 =?iso-8859-1?Q?hGUhOWMIk00qtg9N+icGhwcOREyVwCl7opomGKVA1DUVvx7dil9oHe4/qI?=
 =?iso-8859-1?Q?artJkGU23Fpf0rEc7n0gx7mBP5j1Mu7wy0MHXeZsxDLMCSxcZS5NouNFWr?=
 =?iso-8859-1?Q?Up9BIh1vlpn6GwcaYBfh5hzHXF1V2eUO4+4J9tbjjdxVNdi8U7Gtu8lRYr?=
 =?iso-8859-1?Q?NpQiStalvBH5m8+SNSizEbbXNQf+qP6hYo5uvOG+BLmrKCM0+AIwffMiLu?=
 =?iso-8859-1?Q?iueOhUlPxjU2pcrYaroKvBcSMiYlCV6rTC7Rx+8+EZq+6g8hzZlqydu6J9?=
 =?iso-8859-1?Q?eK25WFNgfw3okxoblxOZislbxUS1HYvKmF3TDF7+TEV6HCkmgUPtyC94RB?=
 =?iso-8859-1?Q?AV+YKRJJ8AJq/caTwQMPdL8jiT/aKWtDDoTuOTYGBLI91CHxpBRZZe7VO4?=
 =?iso-8859-1?Q?guXcPpUeFrWIVWjQD8vaNufH2tfzqbgli6XUWVlWpuc0k67CTtFB5TZZvX?=
 =?iso-8859-1?Q?RZde7SlN+JQ12edp/t1UjoLJELvytTf7UI+POuw21Z54iNbace03xmu4oN?=
 =?iso-8859-1?Q?RA5hIIi68JeF0fOtFLw3nBrXpmF9dmBMqJuyzedUQwEQSgawQHscism3C0?=
 =?iso-8859-1?Q?hR2kOXosFpoGujU4h0Yby0TpkEhMEOMU/q0WtY0yQEqxwq47asHTO9olhl?=
 =?iso-8859-1?Q?SyUhPLgaI8AXx7Eodpvn+OvlKFIE6MEha8?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: zuehlke.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR1P278MB1022.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 0106987f-7e9d-4213-8dfd-08dd07d9638c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2024 14:00:41.5765
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ccce7f5e-a35f-4bc3-8e63-b2215e7d14f9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zNEPMRKCoMelSAB5+s2D94DU/P+Li9nLwE1SWVH3OLlMpLUz2W7ZszVpD1TIkdZxVLtTfcLHzzV8HFTMeTgKFhXpJ6aYnaZdQIzDfUAyzv0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB0123

Hello Heikki,

Thanks for reviewing.

> -----Original Message-----
> From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Sent: Monday, November 18, 2024 12:50 PM
> To: Facklam, Oliv=E9r <oliver.facklam@zuehlke.com>
> Cc: Biju Das <biju.das@bp.renesas.com>; Greg Kroah-Hartman
> <gregkh@linuxfoundation.org>; linux-usb@vger.kernel.org; linux-
> kernel@vger.kernel.org; von Heyl, Benedict
> <benedict.vonheyl@zuehlke.com>; F=F6rst, Mathis
> <mathis.foerst@zuehlke.com>; Glettig, Michael
> <Michael.Glettig@zuehlke.com>
> Subject: Re: [PATCH v2 3/4] usb: typec: hd3ss3220: support configuring po=
rt
> type
>=20
> Hi Oliver,
>=20
> I'm sorry, I noticed a problem with this...
>=20
> On Thu, Nov 14, 2024 at 09:02:08AM +0100, Oliver Facklam wrote:
> > The TI HD3SS3220 Type-C controller supports configuring the port type
> > it will operate as through the MODE_SELECT field of the General
> > Control Register.
> >
> > Configure the port type based on the fwnode property "power-role"
> > during probe, and through the port_type_set typec_operation.
> >
> > The MODE_SELECT field can only be changed when the controller is in
> > unattached state, so follow the sequence recommended by the datasheet
> to:
> > 1. disable termination on CC pins to disable the controller
> > 2. change the mode
> > 3. re-enable termination
> >
> > This will effectively cause a connected device to disconnect
> > for the duration of the mode change.
>=20
> Changing the type of the port is really problematic, and IMO we should
> actually never support that.

Could you clarify why you think it is problematic?

>=20
> Consider for example, if your port is sink only, then the platform
> almost certainly can't drive the VBUS. This patch would still allow
> the port to be changed to source port.

In my testing, it appeared to me that when registering a type-c port with
"typec_cap.type =3D TYPEC_PORT_SNK" (for example), then the type-c class
disables the port_type_store functionality:
	if (port->cap->type !=3D TYPEC_PORT_DRP ||
	    !port->ops || !port->ops->port_type_set) {
		dev_dbg(dev, "changing port type not supported\n");
		return -EOPNOTSUPP;
	}

So to my understanding, a platform which cannot drive VBUS should simply
set the fwnode `power-role=3D"sink"`. Since patch 2/4 correctly parses this=
 property,
wouldn't that solve this case?

>=20
> Sorry for not realising this in v1.
>=20
> I think what you want here is just a power role swap. Currently power
> role swap is only supported when USB PD is supported in the class
> code, but since the USB Type-C specification quite clearly states that
> power role and data role swap can be optionally supported even when
> USB PD is not supported (section 2.3.3) we need to fix that:

My interpretation of section 2.3.3 is that the 2 mechanisms allowing=20
power role swap are:
- USB PD (after initial connection)
- "as part of the initial connection process": to me this is simply referri=
ng to the
	Try.SRC / Try.SNK mechanism, for which we already have=20
	the "try_role" callback.

Maybe I'm misunderstanding what the intentions are behind each of the=20
typec_operations, so if you could clarify that (or give some pointer), that=
 would
be appreciated. My understanding:
- "try_role": set Try.SRC / Try.SNK / no preference for a dual-role port fo=
r initial connection
- "pr_set" / "dr_set" / "vconn_set": swap power and data role resp.
	after the initial connection using USB-PD.
- "port_type_set": configure what port type to operate as, i.e. which initi=
al connection
	state machine from the USB-C standard to apply for the next connection
Please correct me if any of these are incorrect.

>=20
> diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> index 58f40156de56..ee81909565a4 100644
> --- a/drivers/usb/typec/class.c
> +++ b/drivers/usb/typec/class.c
> @@ -1535,11 +1535,6 @@ static ssize_t power_role_store(struct device
> *dev,
>                 return -EOPNOTSUPP;
>         }
>=20
> -       if (port->pwr_opmode !=3D TYPEC_PWR_MODE_PD) {
> -               dev_dbg(dev, "partner unable to swap power role\n");
> -               return -EIO;
> -       }
> -
>         ret =3D sysfs	_match_string(typec_roles, buf);
>         if (ret < 0)
>                 return ret;
>=20
>=20
> After that it should be possible to do power role swap also in this
> driver when the port is DRP capable.
>=20
> > Signed-off-by: Oliver Facklam <oliver.facklam@zuehlke.com>
> > ---
> >  drivers/usb/typec/hd3ss3220.c | 66
> ++++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 65 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/usb/typec/hd3ss3220.c
> b/drivers/usb/typec/hd3ss3220.c
> > index
> e581272bb47de95dee8363a5491f543354fcbbf8..e3e9b1597e3b09b82f0726a
> 01f311fb60b4284da 100644
> > --- a/drivers/usb/typec/hd3ss3220.c
> > +++ b/drivers/usb/typec/hd3ss3220.c
[...]
> > @@ -131,8 +183,16 @@ static int hd3ss3220_dr_set(struct typec_port
> *port, enum typec_data_role role)
> >       return ret;
> >  }
> >
> > +static int hd3ss3220_port_type_set(struct typec_port *port, enum
> typec_port_type type)
> > +{
> > +     struct hd3ss3220 *hd3ss3220 =3D typec_get_drvdata(port);
> > +
> > +     return hd3ss3220_set_port_type(hd3ss3220, type);
> > +}
>=20
> This wrapper seems completely useless. You only need one function here
> for the callback.

The wrapper is to extract the struct hd3ss3220 from the typec_port.
The underlying hd3ss3220_set_port_type I am also using during probe
to configure initial port type.

One point worth mentioning here is that if the MODE_SELECT register
is not configured, the chip will operate according to a default which is=20
chosen by an external pin (sorry if this was not detailed enough in commit =
msg)
From the datasheet:
-------------------
| PORT | 4 | I | Tri-level input pin to indicate port mode. The state of th=
is pin is sampled when HD3SS3220's
		ENn_CC is asserted low, and VDD5 is active. This pin is also sampled foll=
owing a
		I2C_SOFT_RESET.
		H - DFP (Pull-up to VDD5 if DFP mode is desired)
		NC - DRP (Leave unconnected if DRP mode is desired)
		L - UFP (Pull-down or tie to GND if UFP mode is desired)

In our use case, it was not desirable to leave this default based on wiring=
,
and it makes more sense to me to allow the configuration to come from
the fwnode property. Hence the port type setting in probe().

>=20
> >  static const struct typec_operations hd3ss3220_ops =3D {
> > -     .dr_set =3D hd3ss3220_dr_set
> > +     .dr_set =3D hd3ss3220_dr_set,
> > +     .port_type_set =3D hd3ss3220_port_type_set,
> >  };
>=20
> So here I think you should implement the pr_set callback instead.

I can do that, but based on the MODE_SELECT register description,=20
it seems to me that this setting is fundamentally changing the operation
mode of the chip, i.e. the state machine that is being run for initial conn=
ection.
So there would have to be a way of "resetting" it to be a dual-role port ag=
ain,
which the "pr_set" callback doesn't seem to have?
	This register can be written to set the HD3SS3220 mode
	operation. The ADDR pin must be set to I2C mode. If the default
	is maintained, HD3SS3220 shall operate according to the PORT
	pin levels and modes. The MODE_SELECT can only be
	changed when in the unattached state.
	00 - DRP mode (start from unattached.SNK) (default)
	01 - UFP mode (unattached.SNK)
	10 - DFP mode (unattached.SRC)
	11 - DRP mode (start from unattached.SNK)

>=20
> Let me kwno wh
>=20
> >  static void hd3ss3220_set_role(struct hd3ss3220 *hd3ss3220)
> > @@ -273,6 +333,10 @@ static int hd3ss3220_probe(struct i2c_client
> *client)
> >       if (ret !=3D 0 && ret !=3D -EINVAL && ret !=3D -ENXIO)
> >               goto err_put_role;
> >
> > +     ret =3D hd3ss3220_set_port_type(hd3ss3220, typec_cap.type);
> > +     if (ret < 0)
> > +             goto err_put_role;
> > +
> >       hd3ss3220->port =3D typec_register_port(&client->dev, &typec_cap)=
;
> >       if (IS_ERR(hd3ss3220->port)) {
> >               ret =3D PTR_ERR(hd3ss3220->port);
> >
>=20
> thanks,
>=20
> --
> heikki

Thanks!
Oliver

