Return-Path: <linux-kernel+bounces-241032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E2692761C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 14:33:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A60CF1F2244E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 12:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA3701AE848;
	Thu,  4 Jul 2024 12:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Vgwn6VzE"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2043.outbound.protection.outlook.com [40.107.21.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751961AC439;
	Thu,  4 Jul 2024 12:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720096395; cv=fail; b=RixZxWBdyZWjV5SpdFwu/+gQP/hkFs3aV9hQzkm2eMGKBEiibfv95SM1CAsbJmbx9VDCJCo3leXTZgW18L8NQy4joW8wBRPAFraydiTwyTsXfIkGo9C/H7kbqpclorGAUfnlRj4seV2YJqxfNcDpyW3G3V5ysbMah/r/+nWMTS0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720096395; c=relaxed/simple;
	bh=ZR7MI9Btfh18i8sbstQ1edT7wMnH4YVKJa8/8VNIQW0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hk+pmRLdYSRtC36+Vkv17CwjqaNKAVBz0pWWVTCdFSMBxH9LYtqJhhpmtOjYJg4cSoOlGgJgpFpcoz8COBidyA9Dtm6mnxKT+hnuXZnUYVnEKFHHDtgKakfZA/r7NrFQBST1qiYTCKP+YnF89mRPCDMnaL2HW8jlXxEtbHTlFWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Vgwn6VzE; arc=fail smtp.client-ip=40.107.21.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gZVSQIUu1VdiamalBj3u6cSbxfcAokcEdARlSlVFWI5HLCSii88DhbaMMgCsbvwMrQQ3qa8+IO14G7swyYAWuy97gsldtxRVkFTfgkFNHjh8ZaKrE32lTC6b0RR7E0kaE6a3wUjlSQwcLWcSrhHQTA1YRau8MAeAOCVHIqOWQ02hQ+I5W6LVnVzznagR9ZpoaVxnkV6vsGsA2H4zi2YZ2T2Aaz7qubHCXe7+EftiUiaikZ7+zr5+LODPYYZv30pMz0EihIBj76BNVgVQHmZq0V3YSbw5OvESDlqYLlIoy/OkjKn3EhFLPOJG4TB/ukmn5lwboJ/DVUpqqTWPWDfhug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xzZl3RBrE3hghWaKgQ+NKCqQWZ///+bckMQ/36psILQ=;
 b=KSBdLj2y6rNHwk1C5pamKj1s4QDkZ67yBhgLn3INwqkEreR8Otvp/LIM2F0gRb95427qnAFxvPUqGAnSCP1LfenxS4Hz+gkrWMqq7Wwq4gPcR3Sqepz2zkK4tiORarhus6Q0fF7+ktdY3/FAeKEwA9vN4wYkrnLD8S244vlgeFtLaqXZdk2fzwFPgs7uboDD/OKJ8lh1MKS15AalFl0DKqXKOD4TE4QnIIHHs4ONNFwfiKvw13NL3aVq6Ez8dm2hw3n9WwacApaDtmi+Kzkkkut1boVqp/oI/XaBYIKjnhQMBc/GrWS73aABTmG7ZhVkJzQhovYY8j0Y0r35+q6CAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xzZl3RBrE3hghWaKgQ+NKCqQWZ///+bckMQ/36psILQ=;
 b=Vgwn6VzEJIdv3uosM/m92yDdIEpRNMEu6V5L8xaPB3y/9G1IQpxpMRIUuxDBzkZV+e4mfoYLbeeowbqUtQUGjpJQ8Mw3ZfoOXWiQpsoSpEumQow5SJcjsNC/FKMzW1e5mJG/8g8zIUSut7CQDJVwskdFCDuMXNZTyvL+Y0LI1AI=
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
 by DBBPR04MB7531.eurprd04.prod.outlook.com (2603:10a6:10:20c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.29; Thu, 4 Jul
 2024 12:33:09 +0000
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256]) by AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256%4]) with mapi id 15.20.7741.017; Thu, 4 Jul 2024
 12:33:09 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>
CC: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, "cristian.marussi@arm.com"
	<cristian.marussi@arm.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "arm-scmi@vger.kernel.org"
	<arm-scmi@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: RE: [PATCH V2 1/2] dt-bindings: firmware: arm,scmi: introduce
 property mbox-rx-timeout-ms
Thread-Topic: [PATCH V2 1/2] dt-bindings: firmware: arm,scmi: introduce
 property mbox-rx-timeout-ms
Thread-Index: AQHazPZCUnP/ehpH2Em9HKMSjtmmz7HmYioAgAAAeBCAAAFAgIAAHstg
Date: Thu, 4 Jul 2024 12:33:09 +0000
Message-ID:
 <AM6PR04MB5941F61DFB15AFDA384C153A88DE2@AM6PR04MB5941.eurprd04.prod.outlook.com>
References: <20240703031715.379815-1-peng.fan@oss.nxp.com>
 <ZoZ7NCSaG0YRK-60@bogus>
 <AM6PR04MB5941A61736496B9850A3B52C88DE2@AM6PR04MB5941.eurprd04.prod.outlook.com>
 <ZoZ8pfi5KZZGY1wd@bogus>
In-Reply-To: <ZoZ8pfi5KZZGY1wd@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB5941:EE_|DBBPR04MB7531:EE_
x-ms-office365-filtering-correlation-id: d26a0cad-943d-4b38-8302-08dc9c2576aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?GhjcYYQBsyvZZjsNel4CI9h3BhT9aOF+7qxej6Qv5c6w+WW0mfg/m8vJp9Jl?=
 =?us-ascii?Q?e7TGEtVpevkrrNDWdOtUsAoftWsoVK9UKrmkiAGKawSFpyWbUwjbtTnLzClw?=
 =?us-ascii?Q?ajcatAwI34RhnK4iEhZdBTZhCyy2HCvrdirp/YTZ+OFRNIGQjE0sM8ZE0Kpj?=
 =?us-ascii?Q?zfZsBUScNJHAO1kl3JOIx1eeypLYF08WOE1ps/5cDo8jSpYhvbh+Htojvhsv?=
 =?us-ascii?Q?tNN+pDVhbeKWK1UoQuNuXqXJ7BaqRm3YE7RsUe+2oVNe4sZYBs6rFkBgbyk7?=
 =?us-ascii?Q?/Snznc7RoARfhDH1x1DYyPzohIeyDL6xQdnIrkaUAW9OfESr951EJ7PCbqYz?=
 =?us-ascii?Q?DV3DY8ATOTyeYNAlLILjbTr96Agoae8k7dxnhwHLOE6rm98zfyA632WUvjM5?=
 =?us-ascii?Q?m6L5yD4V5n4ohEaEucgSpzKr6stwDlIpUEmkFS2g78+nwJUVFsUJ6IvWPUMe?=
 =?us-ascii?Q?kIzvdefgtpG+DIvQlfEJRG2dxyBLNFinsXdC4eJxdTrusQYifF6BlMNl9HAp?=
 =?us-ascii?Q?ndD5BdBbFwxRxHw7WE7iIPQhT2Znk6z/nTpW5FpyrhPHbvqhUz6dEL+8e/Kk?=
 =?us-ascii?Q?wMjTAUZTc8XxLc7eP+/wE55GHqwlDD600PTelfbQY/BCPu5ef5xGEONTL9tW?=
 =?us-ascii?Q?WgKuj6SrVNdS6LPQRXr0mR7u18q0jR+F7RdDRnAjo3Xwrf6plOnbheybjKh5?=
 =?us-ascii?Q?d+RAclApW7nL2y3VJsyxZ4e+4zYlyumCGI2Dyg/btZCOK/4f2jNQCCTBmtNP?=
 =?us-ascii?Q?LkIHV59NYAcC0GF5wbuFS3TC1tUSUHjpptkn5HpUaMc/l7CvRQMniEUZ9VGL?=
 =?us-ascii?Q?vS/6SkAHcOzkDTHGVjk8h5kKoJOLK9NfJoZMEBb9CvfUccVy4nGUfQEHx9ZO?=
 =?us-ascii?Q?4XmQ/5jzZXumidSk20vPQ51xich4H7oCGlByaDAJd4M7ADo1c1QTw0DAO/gr?=
 =?us-ascii?Q?71/M5MDc7uRETfd+c100uLnVXui4PElV6nQW/MgU+/l/WVKC+tjop/DEdKXt?=
 =?us-ascii?Q?op8WWwtmQ4lbKHujYOtNluVMgBeK+bFeJ+Hdi5yfKj984Wn/uD1ev9I7VqzA?=
 =?us-ascii?Q?6xsmofqi6F21228NI1aIwASVuaXcrm71NS+RojWFiwiMxnrSJzJ2tE6/8/5a?=
 =?us-ascii?Q?In/mBVZVrgdiIob4e5fby2bdlreP8BZI1ONP6bM2FqkIoU/o5lU4zKfA8erX?=
 =?us-ascii?Q?nqtUCe4hLvq3o6gcNJzwwgqyvxmRz2NkjOi2Y4CV7pUI8Pv3du0CEHMvkJfA?=
 =?us-ascii?Q?YEZSWuTN3qYW/G3hTO7a6Kq6GB0J4D0C3j4n7mNzWsOTHUSQB9EGvLVyRPiy?=
 =?us-ascii?Q?Czr2cyumWRlxYP255zaTHDftc9Qz/HXVUp0TrQGQoKyAc7IPpxwrHtsWk+Gi?=
 =?us-ascii?Q?tNpyRk/KVz/XxycI4Wi45tOhV9woKtEu58qlQu6JHPKqeDblQw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?OIC4QoytIldBGuGVFSxP9zBntYlA1ZPTNGoJ19NE75L/cme63pp2df5EbJFr?=
 =?us-ascii?Q?EorNfObmCp450bIR5xiwGobwb4vyExic8G1Kx6t5qbQY7DJD6hWaxQypBH99?=
 =?us-ascii?Q?eWGUI3eizFxCtgKJ8uMSLodOf4JyrbcubKyMd0+8fCcWOEnpDSTys5peDu8M?=
 =?us-ascii?Q?kOWAaCC4Sd6Wi48hxhVZC93Wpyx12eFp3FMJPQnRbaGmhgyy/SAS2DlPrON9?=
 =?us-ascii?Q?NQsRQ9VO3Zf+T6CDfK54IWTc2BJsliZle6iD1d8Lx5QI70ZhlGKkm5GsU5iY?=
 =?us-ascii?Q?keRQXv+R33EYd6pcJ4kRdIQLooVf1hAu/ZFfTrt5bBKl50bocYB5vzI6RqU8?=
 =?us-ascii?Q?SX2gNTktMI7LlpFiB2Ac1G7IOKJh/43gF/cztL5of9F2pSRcHAP7djOy4UpY?=
 =?us-ascii?Q?SMc5HI4HJ2KAG96hLTShNhzmVzzhfmDu/A1qoDm4jgdiOPvPVcBh3KRgkyFI?=
 =?us-ascii?Q?6RNHUzhKz6tBCPREH4ylZiC51a2uTGNjxVUWibBSZ8AxqeJLumOs8zFbmHFV?=
 =?us-ascii?Q?e7m69uoN1LdZnJIMZAkM8V60rl0BRc4hOe30M/lw9c6wCpktHcCX2sUf4AOP?=
 =?us-ascii?Q?ADxvrtAzRmIWcBJu2sPMUzHTllCGAESVo7Lm9eMb/yi4nacM/SaqmpCUZfCL?=
 =?us-ascii?Q?bVq0ZX5KPhfEtbqYYB580jrdaLtEGZa4YNroj6oviRJXL7W5CJU978l3BDs6?=
 =?us-ascii?Q?6sf8MR0hg+7bLfyvz1ahYMOWKqv2v/t6Y2dICwKWMdYc7DjOk4xtig9RiKzM?=
 =?us-ascii?Q?Jl85t3PkH53ltLdU6jny/qym/t0AnUQHauKM8Zbdwdrgy2MJN3lEGeoVzoL2?=
 =?us-ascii?Q?MZNeg9aINsFtDjPOOPN0nLcz8bSDe3q4l5I9eThGs95ddNVEDcT6FXpWGcjk?=
 =?us-ascii?Q?huwRaYEHbM8z6ORqwGRPXsLjsmNYQGWyO4H+KZupYXnuhJCvtOQphjw7KTb4?=
 =?us-ascii?Q?eMu8HjZWcgrxXivwf5SoTFPLItqvlvZGIGHObM1BkuLmhq9oYxnYHiNFkAnV?=
 =?us-ascii?Q?3MyWsqwmHjYspINwRr6JPMdLexQeJ+YsLniJrzBvZV0JXgmyGFRh274wnVGd?=
 =?us-ascii?Q?0vhATWlrhJNn1xr3NYon7nZvPTUBKB+BgM+9KcZvuiR2yQGUtyF1ka8aKB2l?=
 =?us-ascii?Q?gNXWzIIIzsDdvSzaLy78kSoyAbvpNFjj6E3z40HdiRvObIJveKvoVVN3MFbU?=
 =?us-ascii?Q?JjqOCE/zHvg+M/oK2XkxWo4uivzIEVJN8u5v68tacEvlvjqQKNd4qgHvwOli?=
 =?us-ascii?Q?kd/a8i51gfszBJrTuMEawHzACmgyIjDAaoy6q2ED+TE61cHCd37bonlji6dA?=
 =?us-ascii?Q?tgEb3NxaZUBquno9TZqQWm0+0HLC14KVpZX7PPJKOqoxJwf+KQClcnzr45RE?=
 =?us-ascii?Q?YQ8LE+reOZ3k8jOF4fJDKIwFvJJu34tAgUcPtP2votvv8qRTp1ZIjsBhTcWs?=
 =?us-ascii?Q?WOxf3QwL2N5g+w/Tun5WjfJhTm6FVZ60q4DaD3RtUROi4t3CV8qzKkaNLDQR?=
 =?us-ascii?Q?x26osyv/xrle3K1jXsl6u6aUGDdU4ZWQZDi7zqoK3Kkv9jGHPzHrt6iDUuAK?=
 =?us-ascii?Q?7uiH0dIPxXIQkrxfHIw=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5941.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d26a0cad-943d-4b38-8302-08dc9c2576aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2024 12:33:09.8198
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4ANr+5kvSPPnlEF+CEG2n7T+jLEzM7xwMiM0BGXNn82R/oVSSBwuKKI1F8/zdZ77DNnSuhbdaFV81lj2v6si5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7531

> Subject: Re: [PATCH V2 1/2] dt-bindings: firmware: arm,scmi: introduce
> property mbox-rx-timeout-ms
>=20
> On Thu, Jul 04, 2024 at 10:39:53AM +0000, Peng Fan wrote:
> > > Subject: Re: [PATCH V2 1/2] dt-bindings: firmware: arm,scmi:
> > > introduce property mbox-rx-timeout-ms
> > >
> > > On Wed, Jul 03, 2024 at 11:17:14AM +0800, Peng Fan (OSS) wrote:
> > > > From: Peng Fan <peng.fan@nxp.com>
> > > >
> > > > System Controller Management Interface(SCMI) firmwares might
> > > have
> > > > different designs by SCMI firmware developers. So the maximum
> > > receive
> > > > channel timeout value might also varies in the various designs.
> > > >
> > > > So introduce property mbox-rx-timeout-ms to let each platform
> > > > could set its own timeout value in device tree.
> > > >
> > > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > > ---
> > > >
> > > > V2:
> > > >  Drop defaults, update description.
> > > >
> > > >  Documentation/devicetree/bindings/firmware/arm,scmi.yaml | 6
> > > ++++++
> > > >  1 file changed, 6 insertions(+)
> > > >
> > > > diff --git
> > > a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > > > b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > > > index ebf384e76df1..dcac0b36c76f 100644
> > > > ---
> a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > > > +++
> b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> > > > @@ -121,6 +121,12 @@ properties:
> > > >        atomic mode of operation, even if requested.
> > > >      default: 0
> > > >
> > > > +  max-rx-timeout-ms:
> > > > +    description:
> > > > +      An optional time value, expressed in milliseconds,
> > > > + representing
> > > the
> > > > +      mailbox maximum timeout value for receive channel. The
> > > > + value
> > > should
> > > > +      be a non-zero value if set.
> > > > +
> > >
> > > IIRC, you had the min and max constraint in the earlier response.
> > > You need to have rushed and posted another version before I could
> > > respond with my preference.
> > >
> > > So there is no rush, these are v6.12 material. Take time for
> > > respining and give some time for the review.
> >
> > Sure. I just not sure what the maximum should be set, so I drop the
> > minimum and maximum from my previous email.
> >
>=20
> Worst case we can just have min constraint to indicate it must be non-
> zero value as you have mentioned above and drop that statement as it
> becomes explicit with the constraint.

I'll use below in v3:
  max-rx-timeout-ms:                                                       =
                        =20
    description:                                                           =
                        =20
      An optional time value, expressed in milliseconds, representing the  =
                        =20
      mailbox maximum timeout value for receive channel. The value should  =
                        =20
      be a non-zero value if set.                                          =
                        =20
    minimum: 1

Put the binding away, when you have time, please check
whether the driver changes are good or not.
BTW, since our Android team is waiting for this patchset
got R-b or A-b, then the patches could be accepted by Google common
kernel, we could support GKI in our release which is soon in near
days. So I am being pushed :)=20

Thanks,
Peng

>=20
> --
> Regards,
> Sudeep

