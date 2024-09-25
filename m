Return-Path: <linux-kernel+bounces-338768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB56985CD1
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 14:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE8201C246CC
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 12:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE731D45E2;
	Wed, 25 Sep 2024 12:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HynoDYPR"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2048.outbound.protection.outlook.com [40.107.21.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2710B18A6D2;
	Wed, 25 Sep 2024 12:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265638; cv=fail; b=qNP6gWyD6XxTlLBcm3IRNVtR5ASchf19iIUYQEhItiimTnDxF2YLqj1Y/cn1fdY6Wi3GwvsSwdpYDrrX5DICaGdOQJTh4k01xcUlKYixLC+TacgqLDMmnaxdcZrC14cYS666Zl9ByRSMC1ehDSDGIQoDXu5ljG2a0dOFlOj4ty8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265638; c=relaxed/simple;
	bh=QW/eubTN75fYmdQArVWz7bLsniFDJrpVdRp35+91o4Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dp9Uym6KceLVQur3f578aeHLWpyq10S3TxA/FMpPKOO8hwAOYn5pniL9SEZFPQuosoSGZnw1Bqu0ZHrtezgfrL4gmAuwemvyznj11Bn0pafZeAaO+ZDQHByc0wClBU6H9rZ2NisbHCVz0g+EBICHFxAPGICQQ3xGg6sUbxX/C94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HynoDYPR; arc=fail smtp.client-ip=40.107.21.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l6H9d52rzC8b7okp+S3OJNqYwPEGjlX3w4Ux04pUdRKXczLPhmEJUWaex4OC1P3cvelw8E+F6NktH924Q52Gvd+ky3M4fsn9KO0uqi2qm/6wUpv4Fr9DGSznUQ4lqinOPSD1MGzfV9eryNRglr1DkbHoruNrGF7XDWTYZT+AkyEPGtgvwrtPlVfv2a4gYvwqqKZI9VzMbhPIcE1rh2BNb7DCWZnTWCJtPBpPqBhEornCc/4qT7RA9P+cgfrF1ym4g+CgLfiEjknLvArjOauupSs/i3zGO4soSBP6RLMdlplfZ20LIdxQIM2WEdkvdSQLZxD7pbTzx9JNzQPu19XpRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QFaaffE7W5HNS1fPoqK8OlRhe+rZTvRnYmdwtxF308E=;
 b=UYO+jYv0tk/9DM7WmUthOqYjR9kt7i08Q+2UTDMGpuB0XBCh/EfYvEhKhdeQUJqiyU1mEHtW3if+AXVBVUvOaJBsWO2aoBT9Gd4rcevT0iLJnFAsNibg8Z14HgM4+WNvnCw/9HOOtYH8SXa4zILXSKhg3onRbaBJhzKYiLHmvVgwkNpVAdngsIwI0POKGsI3xQ0FvWcQR/L7K9r2iMo2ERvBWEtjHelOrfSMj+Nh095Lz/rTUKKwqbAqEAjMqf77xTE2wOP4NrYgumNsoUTljRJxnXOGTqq+VUQ1jZ/QG9ZaM6G5eSYyWAbkxZu1GUCFXkFDWxpfQF7vTWSugrOKwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QFaaffE7W5HNS1fPoqK8OlRhe+rZTvRnYmdwtxF308E=;
 b=HynoDYPRU7IiixvCP3nGOwDOKhErNcvYy6YRUXSGTj/ogmNhFop0Giy9EawJw2JL8a1WPojeX4XE2uHrCXeHTjDYZxYOzOzyLCe6AteCikFBwheeNolYn5vELJ8nQ4qejDEDKPpXsJHEIRNQzB71RF9WcdQDmydt2JdOefXX0Mk++ZL/99V82/gDP3zRLL+G1aX4nDngjOjw+0AHgi4Hzi1DYcsMdWgk2PGSbY6avam832xN0OafDMBrovurDaei4H+OhtB3ZnUIJHTE8sSdXUee9f78+HC+Kh/jkduZhDH2tQ+gc5CUZPmkXziCDN/vWK8VjhjkqSgt0vb7LhdjCw==
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by GVXPR04MB10355.eurprd04.prod.outlook.com (2603:10a6:150:1db::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Wed, 25 Sep
 2024 12:00:28 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::e751:223e:aa3d:5827%5]) with mapi id 15.20.7918.024; Wed, 25 Sep 2024
 12:00:28 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
To: Sascha Hauer <s.hauer@pengutronix.de>
CC: Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo
	<shawnguo@kernel.org>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio
 Estevam <festevam@gmail.com>, Rob Herring <robh+dt@kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [PATCH v7 4/5] firmware: imx: add driver for NXP
 EdgeLock Enclave
Thread-Topic: [EXT] Re: [PATCH v7 4/5] firmware: imx: add driver for NXP
 EdgeLock Enclave
Thread-Index: AQHa/rj+Xxal5gowYku20JmR9i3Hr7JPZ5YAgAqyPACABpKkAIAH1ffg
Date: Wed, 25 Sep 2024 12:00:28 +0000
Message-ID:
 <AM9PR04MB86042C9BF315EF130FF0408A95692@AM9PR04MB8604.eurprd04.prod.outlook.com>
References: <20240904-imx-se-if-v7-0-5afd2ab74264@nxp.com>
 <20240904-imx-se-if-v7-4-5afd2ab74264@nxp.com>
 <Zt7n0AxGEw-ZXbui@pengutronix.de>
 <AS8PR04MB85932B4E47EFC519B0EF6D9A95632@AS8PR04MB8593.eurprd04.prod.outlook.com>
 <Zu1kUDb5dfB5dRbe@pengutronix.de>
In-Reply-To: <Zu1kUDb5dfB5dRbe@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8604:EE_|GVXPR04MB10355:EE_
x-ms-office365-filtering-correlation-id: 81e7cb90-2dfe-4076-c6c5-08dcdd59a5d8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?9fiq5C0xr1vLOMAtei3c/WdAfkYjxUCsXZZyRDGk1NKBgaGzAix6DK2emODv?=
 =?us-ascii?Q?u6whX80gUMLOlhBBeeYUqfnXcjIU3sm0OVW8sNzBEnAHVM0eg8PgOJo3oWSp?=
 =?us-ascii?Q?KoY9BnG/+rHDWtkB/7xbmEcu3NgkvFNQmY/B7Mo2YosQRd601aIXlJ7qiXKo?=
 =?us-ascii?Q?kjM2W8+JeojgMN18k/ITrdZOmxMXgHOsYTBHD49ZpEZZ3rhKjTZyJh57MWip?=
 =?us-ascii?Q?SdwnVp1h/B5Pdl7rB80SW+uKijojg4v1kbXEqbhtvo3m/UwwrM6QO4C7Gt67?=
 =?us-ascii?Q?JuUe8/AHHs5odome+uckig3CNfDq6UihSCu5reFO0+VywvdSMFnvmvX6JhNJ?=
 =?us-ascii?Q?G/lM5LbPx5BA1SiQ2W7wcWd8t5zQ0lPBs+mGSNH/Z3Az6geNFL1uDRqKAwiu?=
 =?us-ascii?Q?cvkuNZvwZf2o9BTJXfaxFoP45OoYI/MXKWAQptTOKnkc4mhPKdGHsQDw5AUZ?=
 =?us-ascii?Q?pbWeDzcHRu9DRG2X1sieUD7n8E6gq8VMfNzIZEmD9lhSXP3N2MtXHtDpfkVp?=
 =?us-ascii?Q?k74Fo0K4M1jrr1O2p+5habgg0r9cF91+xvNxDHGqZvL4kgvHkotSBXUktTlC?=
 =?us-ascii?Q?jb4WFscSBxry6u5rznpvJU7JHyNdpMA4PdvF3jGEMvnFs8k//szsNcsGb/re?=
 =?us-ascii?Q?1QmLrrLfMd9onjrKsRllNgmp8i1Iw3y+3H8dbONYeQswWJNMkzhOpE184+Mg?=
 =?us-ascii?Q?lnXpw1AlO74tbfxWnpNzWl0AeFF8lN25pkgH0JXKbSguYA9ibbNALvkPZGEe?=
 =?us-ascii?Q?KioXK/Wpp4lpLLphfnnlBed6IHrc7IZF4MxR727YLLCU3eO8fFTLPYnLKYkg?=
 =?us-ascii?Q?hkjpstLkXM4Iph3BrRrznY61HmepnQNxkWHLbyfE4Z8ZjoKYrKW1tQF677QW?=
 =?us-ascii?Q?2vsDQU7YGiR2mjSTJTpgOM2Hfrcmm24sFrtpjCcqlDfM4JHEag4jAAsV5lKt?=
 =?us-ascii?Q?s+wtMJw2TicewCnXCvF2OxerRVRmfWfcTUyBcs3HDYkr/Koe0IA2zSNoi/32?=
 =?us-ascii?Q?12BPXnHSN9qaP1Zc9OOYNJP0eMrsODLPJMiew/xj2F17JkGcJGX5s61eI/8n?=
 =?us-ascii?Q?YPp8nCnwpsyiRdaU2NFNeNDCzDRIfST8QFE/Tw/ms0jIIhZ0lPdZRHjUy6Ir?=
 =?us-ascii?Q?U1HhUvoOc1F4yfzOUYEGhykYeEuS64cQuqOpcrxJ5SAOAK8MhXjgDFaoh6II?=
 =?us-ascii?Q?6ky5tK7lrCdveXTbanSv0z/gVtoW8KO3PyYH136DtBYRzj/RkoELK/kZbdG0?=
 =?us-ascii?Q?5Z20wufZUek7Auw7Zjs9cVI3QD3JCIG4iPQcWKRCJQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?YCjwd2br3I4ZrsXchw+/JUX2RQB/fgn6tmx3JYxgcYZjiHSrixvzw6/8EtMF?=
 =?us-ascii?Q?rSSUNPyeu/mER723MDy2LIKnAZXg8oBWZzEtgeqOeeGZ+HdDaMt975LyzhaK?=
 =?us-ascii?Q?jf4fe1hhG3OTil335qhQ5fxZjZy4YJCg0cR7mmlZeEIa+E6U3mJX37EeHXNq?=
 =?us-ascii?Q?WBHZIFOpstasgd0vV0BqRxpZiCI/ruTiI6TxNRpT/N/vgXW6AR1Dih4EbKqm?=
 =?us-ascii?Q?JaCZFg05UOk17dcajmNMvMDMab7s6WrXL5q3Nmz3HE57Ui0hvAoHBEUGQqxt?=
 =?us-ascii?Q?YFmSUPt7UZ6L0IVaBZqUTYYBUhg9boHdulG9LDEeHkjxc6E8z/vybxwUIUCB?=
 =?us-ascii?Q?NWcT/hupVZ3TVjfPRoE55PlNYB49KXgddC+XLAnJViAiN/o5xE+oqMXuZxrr?=
 =?us-ascii?Q?Iqp5xwcMlwmZkz4Jc0ogcG7lfo3GtPpYxGwtcRj4HrzLbcG2hhUEj1Gri7cC?=
 =?us-ascii?Q?Du7ZqOBCpmg96TSZcLrx2w2i6zL3ZQi/HNXJE4QvrkeEUbvcGS5v2JaVNgRC?=
 =?us-ascii?Q?Ty1Whvv+l+AwF59bPxqKItEO3cLe/XDbCRPwx3mcGfSVazCAFKf75jiAsp1+?=
 =?us-ascii?Q?bNgV+kie8LF9MCe671xBRHoW9mOZQghYBIXF3/8T54uXYfQ0C7r3O95P8CkU?=
 =?us-ascii?Q?n30jD2qeiUsN5rek20/I1oYxOT9HG6eK7AbkzsWEMzZf3d/FWShlEVd8Ihjx?=
 =?us-ascii?Q?0bfg3125hU+EOwscJYqle392Ktta60AXeyzwum/LH54XNbxWzNzEgpKeXYee?=
 =?us-ascii?Q?nBWt1VnKfc1DCxpOARq0ZztKEJjc/i9JKXVbb8aKzrNCPCJB/CxPBpEG1auj?=
 =?us-ascii?Q?ScJoyv/ozlvTraCsO6RXXoCVEYhArR6wakkAC92P5h6W2fkVrt5LI22P/x3M?=
 =?us-ascii?Q?Fv2/x7wy+j1AeXELUzOTZCzlOD4RhL4JsUHOdc3VEs7yoxYeB8COz+IoM7gu?=
 =?us-ascii?Q?tTosZb7h6Ha+zyAYtj3Tg2H7Gk97I8crPCB7F4OxjsgYZU6RWWXrCGX6aPH6?=
 =?us-ascii?Q?m7LEw7fWRi0VXZICQ0Vl/EdE8srZ6hNa8vhX72n89uPT+SHIWqw6NMtqd6JM?=
 =?us-ascii?Q?QHUHqb5pNpdDzrzMTgERvvUabjCTnfNGuTTVDeB9UQh3CV8cKnSCj7FxCr/h?=
 =?us-ascii?Q?93szR1ZMV+9NpoeClc0v+uevIqeM1/ZrET/bxehinU7/8nXY/j7eIxiopDyL?=
 =?us-ascii?Q?gYYEoua6vOeZBvnO9Pc+khpeXxOJrFdVMLx1hjPWgDFvfTgtVutWiAjJ9dF6?=
 =?us-ascii?Q?q18YfoLIuvThw7qb+k5uGfT3fKDG3xG4Nu+n1TX73nLt1U8VBM94Mv5EXjZb?=
 =?us-ascii?Q?aFDRTAiueFDMmBFM49YFPMHZAJT7Tl1JA4ftCIY8kqm8CbJeSTgKm5prqO4B?=
 =?us-ascii?Q?H7pkSmBfjlYD7MGkeZiSLvRQ4ig7fbCVg0qUT4Qvlmqo5i8YmasUdm22K6BD?=
 =?us-ascii?Q?Cy5sDeHvX2gK8/+ULOxb4HgmjGR0Qh+A+Pw7rke8PWV0rixZISrltK5zhgLd?=
 =?us-ascii?Q?Vs0Rpm0PlLIPZCfpqSclIFoT6IZqI+celljtDtzpnjYiGQWgrVng0QB+7unL?=
 =?us-ascii?Q?iUvB5GIuBKyqPNiyC503cQewnUmLh8TSfLEB2f+I?=
Content-Type: multipart/signed;
	protocol="application/x-pkcs7-signature";
	micalg=SHA1;
	boundary="----=_NextPart_000_011A_01DB0F70.9C149530"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8604.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 81e7cb90-2dfe-4076-c6c5-08dcdd59a5d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2024 12:00:28.3926
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8uG88eQj6Py5sS1epDplOUAur2cSaTiCxoZdnCD/CV8d1PIk98j04HTtlmDdfA25QqmVwMUzlG69Yis2Avv3AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10355

------=_NextPart_000_011A_01DB0F70.9C149530
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit



-----Original Message-----
From: Sascha Hauer <s.hauer@pengutronix.de> 
Sent: Friday, September 20, 2024 5:32 PM
To: Pankaj Gupta <pankaj.gupta@nxp.com>
Cc: Jonathan Corbet <corbet@lwn.net>; Rob Herring <robh@kernel.org>;
Krzysztof Kozlowski <krzk+dt@kernel.org>; Conor Dooley
<conor+dt@kernel.org>; Shawn Guo <shawnguo@kernel.org>; Pengutronix Kernel
Team <kernel@pengutronix.de>; Fabio Estevam <festevam@gmail.com>; Rob
Herring <robh+dt@kernel.org>; linux-doc@vger.kernel.org;
linux-kernel@vger.kernel.org; devicetree@vger.kernel.org;
imx@lists.linux.dev; linux-arm-kernel@lists.infradead.org
Subject: Re: [EXT] Re: [PATCH v7 4/5] firmware: imx: add driver for NXP
EdgeLock Enclave

Caution: This is an external email. Please take care when clicking links or
opening attachments. When in doubt, report the message using the 'Report
this email' button


Hi Pankaj,

On Thu, Sep 19, 2024 at 06:43:45AM +0000, Pankaj Gupta wrote:
> > +static void se_load_firmware(const struct firmware *fw, void
> > +*context) {
> > +     struct se_if_priv *priv = context;
> > +     const struct se_if_node_info *info = priv->info;
> > +     phys_addr_t se_fw_phyaddr;
> > +     u8 *se_fw_buf;
> > +     int ret;
> > +
> > +     if (!fw) {
> > +             if (priv->fw_fail > MAX_FW_LOAD_RETRIES)
> > +                     dev_dbg(priv->dev,
> > +                              "External FW not found, using ROM
FW.\n");
> > +             else {
> > +                     /*add a bit delay to wait for firmware priv
released
> */
> > +                     msleep(20);
> > +
> > +                     /* Load firmware one more time if timeout */
> > +                     request_firmware_nowait(THIS_MODULE,
> > +                                     FW_ACTION_UEVENT,
> priv->se_img_file_to_load,
> > +                                     priv->dev, GFP_KERNEL, priv,
> > +                                     se_load_firmware);
> > +                     priv->fw_fail++;
> > +                     dev_dbg(priv->dev, "Value of retries = 0x%x.\n",
> > +                             priv->fw_fail);
> > +             }
> > +
> > +             return;
> > +     }
>
> > Are you continuously trying to load the firmware here in the hope that
the
> >rootfs is mounted before your retry counter exceeds?
>
>> Yes.
>
> > Don't do this.
>
>> Shall the retry counter to be removed, to make it predictable?
>>Or am I missing something.

>Either compile the firmware into the kernel or the ELE driver as module.

Cannot compile as part of Firmware.
There are OTA scenarios where the latest FW, that is downloaded to replace
the image in RFS, and FW needs to be re-init with this new image, by putting
the Linux to power-down state.

ELE driver is compiled as module only, by default. But if someone like to
make it as in-line to kernel image, still it should work.

>Sascha

--
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       |
https://eur01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fwww.pengutr
onix.de%2F&data=05%7C02%7Cpankaj.gupta%40nxp.com%7C136e82e202f34606acfa08dcd
96c1790%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638624305558398562%7CUn
known%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJX
VCI6Mn0%3D%7C0%7C%7C%7C&sdata=zx%2FjUGWs2qNnz4clLydY5%2BWNDVZoQ2AdP4ML5BeTjq
Q%3D&reserved=0  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

------=_NextPart_000_011A_01DB0F70.9C149530
Content-Type: application/pkcs7-signature;
	name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="smime.p7s"

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIImZTCCBaIw
ggOKoAMCAQICCE4Rpu+H69FRMA0GCSqGSIb3DQEBCwUAMGUxIjAgBgNVBAMMGU5YUCBJbnRlcm5h
bCBQb2xpY3kgQ0EgRzIxCzAJBgNVBAsMAklUMREwDwYDVQQKDAhOWFAgQi5WLjESMBAGA1UEBwwJ
RWluZGhvdmVuMQswCQYDVQQGEwJOTDAeFw0yMzA0MjEwNjQzNDVaFw0yODA0MTkwNjQzNDVaMIG2
MRwwGgYDVQQDDBNOWFAgRW50ZXJwcmlzZSBDQSA1MQswCQYDVQQLDAJJVDERMA8GA1UECgwITlhQ
IEIuVi4xEjAQBgNVBAcMCUVpbmRob3ZlbjEWMBQGA1UECAwNTm9vcmQtQnJhYmFudDETMBEGCgmS
JomT8ixkARkWA3diaTETMBEGCgmSJomT8ixkARkWA254cDETMBEGCgmSJomT8ixkARkWA2NvbTEL
MAkGA1UEBhMCTkwwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDAWrnSkYP60A8wj4AO
kATDjnbdgLv6waFfyXE/hvatdWz2YYtb1YSRi5/wXW+Pz8rsTmSj7iusI+FcLP8WEaMVLn4sEIQY
NI8KJUCz21tsIArYs0hMKEUFeCq3mxTJfPqzdj9CExJBlZ5vWS4er8eJI8U8kZrt4CoY7De0FdJh
35Pi5QGzUFmFuaLgXfV1N5yukTzEhqz36kODoSRw+eDHH9YqbzefzEHK9d93TNiLaVlln42O0qaI
MmxK1aNcZx+nQkFsF/VrV9M9iLGA+Qb/MFmR20MJAU5kRGkJ2/QzgVQM3Nlmp/bF/3HWOJ2j2mpg
axvzxHNN+5rSNvkG2vSpAgMBAAGjggECMIH/MFIGCCsGAQUFBwEBBEYwRDBCBggrBgEFBQcwAoY2
aHR0cDovL253dy5wa2kubnhwLmNvbS9jZXJ0cy9OWFBJbnRlcm5hbFBvbGljeUNBRzIuY2VyMB0G
A1UdDgQWBBRYlWDuTnTvZSKqve0ZqSt6jhedBzASBgNVHRMBAf8ECDAGAQH/AgEAMEUGA1UdHwQ+
MDwwOqA4oDaGNGh0dHA6Ly9ud3cucGtpLm54cC5jb20vY3JsL05YUEludGVybmFsUG9saWN5Q0FH
Mi5jcmwwHwYDVR0jBBgwFoAUeeFJAeB7zjQ5KUMZMmVhPAbYVaswDgYDVR0PAQH/BAQDAgEGMA0G
CSqGSIb3DQEBCwUAA4ICAQAQbWh8H9B8/vU3UgKxwXu2C9dJdtoukO5zA8B39gAsiX/FcVB9j8fr
Y7OuqbvF/qs5SNGdISMIuXDrF5FSGvY5Z+EZcYin4z0ppwDr0IzVXzw5NvopgEh6sDXgPhCCh95G
Mpt9uHDuav1Jo5dfN9CWB78D+3doDK2FcHWxT6zfBOXQ69c7pioBz5r5FP0ej4HzWWzYUxWJfMcQ
uxwIRfISM1GLcX3LliiB3R3eDUJyvgsPhm7d+D1QIgElyLpUJJ+3SZpXK6ZVkQlLcpEG01Jl5RK7
e0g7F2GGn8dkTm2W3E9qRnHLnwj3ghnewYTOk8SWARN7Epe0fPfeXyS0/gHEix7iYs4ac2y8L0AG
2gbegEAKATWSxTgN/At+5MLPqnQuilUZKlcjgtDMzhnSJK2ArmuEXTEJUa/0fwKsnIQuhF4QONqS
nm8+QSb+/uRm/IWcW5LuCUuxwufQDzto7Xlc1q1dpOggtUJI+IojSlzTfeHkgYNr2XFZ4BrkY0i8
VFVmnqichsJOM2+zqQU4ZGszdFz/RLD4mLMCvmsMzRI7jIg7fkQer3CvIZkBwS1xjl4+ZGrkzyZm
zHyP274V7PSyYztkXvYr/CkTgjIu+JG6vGEN8LuVXt7AmwD7WNF8MKAkPOFIKWHXviyotKGRb0Jl
x2XwYgoaXD5Noa1jwB8kKTCCBaIwggOKoAMCAQICCHIFyg1TnwEcMA0GCSqGSIb3DQEBCwUAMGUx
IjAgBgNVBAMMGU5YUCBJbnRlcm5hbCBQb2xpY3kgQ0EgRzIxCzAJBgNVBAsMAklUMREwDwYDVQQK
DAhOWFAgQi5WLjESMBAGA1UEBwwJRWluZGhvdmVuMQswCQYDVQQGEwJOTDAeFw0yMzA0MTQwNzQ1
MzFaFw0yODA0MTIwNzQ1MzFaMIG2MRwwGgYDVQQDDBNOWFAgRW50ZXJwcmlzZSBDQSA0MQswCQYD
VQQLDAJJVDERMA8GA1UECgwITlhQIEIuVi4xEjAQBgNVBAcMCUVpbmRob3ZlbjEWMBQGA1UECAwN
Tm9vcmQtQnJhYmFudDETMBEGCgmSJomT8ixkARkWA3diaTETMBEGCgmSJomT8ixkARkWA254cDET
MBEGCgmSJomT8ixkARkWA2NvbTELMAkGA1UEBhMCTkwwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAw
ggEKAoIBAQDVSMlM/AT8vRa4mBRQJwL0iYE6It2ipQbMoH8DzO7RQLmGmi82PhZs2XhTRcEWtede
DstWIRWwWC4vQiZvwshmknxltM+OwkFHVcUrpG5slDwe2RllSij7099aHWJmOai6GjOz7C/aywDy
zrftFuzd3+7JsGlBi4ge5d7AT9NtlhBOySz4omF4e1R+iNY8mqq/mfPcBFbAe6sGWQ96+0+UAAVx
BpCZ8NmtwUjeSGvWVSfPDga4IW+VoJdQWFsY0YoDVdglKSmA4n9J0hfq+gErN4nq8/1/Q8AamPaN
qVRwtN1g/mI/1JyHa+J2nmqLiixjtndxIPnwrKdS+sM34VuXAgMBAAGjggECMIH/MFIGCCsGAQUF
BwEBBEYwRDBCBggrBgEFBQcwAoY2aHR0cDovL253dy5wa2kubnhwLmNvbS9jZXJ0cy9OWFBJbnRl
cm5hbFBvbGljeUNBRzIuY2VyMB0GA1UdDgQWBBTlMnr0ZsFHliR//CeAOVjfKxfiuzASBgNVHRMB
Af8ECDAGAQH/AgEAMEUGA1UdHwQ+MDwwOqA4oDaGNGh0dHA6Ly9ud3cucGtpLm54cC5jb20vY3Js
L05YUEludGVybmFsUG9saWN5Q0FHMi5jcmwwHwYDVR0jBBgwFoAUeeFJAeB7zjQ5KUMZMmVhPAbY
VaswDgYDVR0PAQH/BAQDAgEGMA0GCSqGSIb3DQEBCwUAA4ICAQB9ysTcSisP+PmOFcN//fmoimql
EXMtFHPygpRjW4aa0s9GnKk31mO6aKr48BKD4yYRPIy2dWwRI2P2JqNxBPRLVF8vPi/h7sFt9Or7
4marYCgw8GtEDKZ5DWFJpPLCI99UsYY71u/lpQvY1H1TqvAwkjvTGriWmuCzl+M3SueIl1Eu74AZ
Y9tN+codSViZhFjV8s/nWeNhD40npdTEl+cOKHHfkALQlhR+JG33z1vX1blyGIfeXpGldgKX7unN
r05B0DhU1gT9Rb0PvVJjr9zQlVUHA3cklQ8a4xRTB1hpIp2ZkmgFr1IWDS8H21o89gO0AA6LmR0w
C7/aVOg0Ybn3TjzmpggTbDIAiF0jBhO0MffStheqFsZZJ0xd09tUlert+HPemkuNtDRMSd92mr/B
p9iv4obXXR4nwCDE7n0YCeYBeSBOEDwpE7TganD0S6Csg+5bpgmDriIT1eXt40qBgG2fBpYKAzI9
/S5+pnqP25nGVuuFb5ZyHLXhQtXGHk44eyh6kzI750GF2ldN30wu363hDdq53T+KoP2dLvTosA3z
ipknv55JRUU77pn5Y/AEAWedYttK0k6DqE63akxW1AOu+OKMywLXTVz+EWod6ZLrCKrfp93MKbcd
fC2USt3UV04kTeTnXwSWX4e0h0hC57UpBZX6y9rBk8tN5aRQrzCCBawwggOUoAMCAQICCE5+Bsxl
kQBIMA0GCSqGSIb3DQEBCwUAMFoxFzAVBgNVBAMMDk5YUCBST09UIENBIEcyMQswCQYDVQQLDAJJ
VDERMA8GA1UECgwITlhQIEIuVi4xEjAQBgNVBAcMCUVpbmRob3ZlbjELMAkGA1UEBhMCTkwwHhcN
MTYwMTI5MTI0MDIzWhcNMzYwMTI0MTI0MDIzWjBaMRcwFQYDVQQDDA5OWFAgUk9PVCBDQSBHMjEL
MAkGA1UECwwCSVQxETAPBgNVBAoMCE5YUCBCLlYuMRIwEAYDVQQHDAlFaW5kaG92ZW4xCzAJBgNV
BAYTAk5MMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAo+z+9o6n82Bqvyeo8HsZ5Tn2
RsUcMMWLvU5b1vKTNXUAI4V0YsUQRITB+QD22YPq2Km6i0DIyPdR1NbnisNpDQmVE27srtduRpB8
lvZgOODX/3hhjeTWRZ22PAII57gIvKqZCMUWvYRdYZsSKP+4Q+lEks89ys953tp3PI8EeUztT3qU
Tfs7TbgD5A9s+1zCPqI7b/XmXTrkWBmwmmqDHBijwIvzy5uE3MTBunVZFAl2kD/jiBgdj+4O4u59
3Ny1c9c4If6Xvz3+DEIjdvbULrUyGIatwJdvw6FxRt5znmYKe3VyzsY7Zk/8MsOZvzoSPBMSZBWS
Hj/e8fBwDEDKf6XQ0BD7Z27AWTUcddk1sphn38HHOwEpjKfOxNGX7fSXqz2JaRtlamvSoCrd4zrH
5f94hcSVFcP9nF9m3JqRzAmbGYTdzgAjKjPRVWAgaZGF8b/laK5Ai8gCEi767DuzMsXkvj9/BQw8
fyn5xOY55zRmFo2jU8/blWy/jsAwUeEBDo4KPRAuPbSiOt8Jf8NbDOvDGPKwEC8de76SxPi3ulhu
Fb0Qzxsbk39+ET3Ixy347MAZTji/a87GeIDWi+nCWHwZPQSEg0e0LVh7uRNNb1clWILEF/bSMe3z
T3rWKWDmzCiTn3+PicqvYM7cWiZi3srlCkIAeaiav9tMaAZ3XG8CAwEAAaN2MHQwHQYDVR0OBBYE
FJBIUyMqeeqEmz0+uQ7omXRAXqC2MA8GA1UdEwEB/wQFMAMBAf8wEQYDVR0gBAowCDAGBgRVHSAA
MB8GA1UdIwQYMBaAFJBIUyMqeeqEmz0+uQ7omXRAXqC2MA4GA1UdDwEB/wQEAwIBBjANBgkqhkiG
9w0BAQsFAAOCAgEAhIKiXslbxr5W1LZDMqxPd9IepFkQ0DJP8/CNm5OqyBgfJeKJKZMiPBNxx/UF
9m6IAqJtNy98t1GPHmp/ikJ2jmqVqT0INUt79KLP7HVr3/t2SpIJbWzpx8ZQPG+QJV4i1kSwNfk3
gUDKC3hR7+rOD+iSO5163Myz/CzzjN1+syWRVenpbizPof8iE9ckZnD9V05/IL88alSHINotbq+o
0tbNhoCHdEu7u/e7MdVIT1eHt8fub5M10Rhzg5p/rEuzr1AqiEOAGYcVvJDnrI8mY3Mc18RLScBi
VHp/Gqkf3SFiWvi//okLIQGMus1G0CVNqrwrK/6JPB9071FzZjo5S1jiV5/UNhzLykSngcaE3+0/
zKiAP2vkimfHHQ72SJk4QI0KOvRB1GGeF6UrXROwk6NPYEFixwTdVzHJ2hOmqJx5SRXEyttNN12B
T8wQOlYpUmXpaad/Ej2vnVsS5nHcYbRn2Avm/DgmsAJ/0IpNaMHiAzXZm2CpC0c8SGi4mWYVA7Pa
x+PnGXBbZ9wtKxvRrkVpiNGpuXDCWZvXEkx118x+A1SqINon8DS5tbrkfP2TLep7wzZgE6aFN2Qx
yXdHs4k7gQlTqG04Lf7oo2sHSbO5kAbU44KYw5fBtLpG7pxlyV5fr+okL70a5SWYTPPsochDqyaH
eAWghx/a4++FRjQwggX8MIID5KADAgECAgg4IAFWH4OCCTANBgkqhkiG9w0BAQsFADBaMRcwFQYD
VQQDDA5OWFAgUk9PVCBDQSBHMjELMAkGA1UECwwCSVQxETAPBgNVBAoMCE5YUCBCLlYuMRIwEAYD
VQQHDAlFaW5kaG92ZW4xCzAJBgNVBAYTAk5MMB4XDTIyMDkzMDA4MjUyOVoXDTMyMDkyOTA4MjUy
OVowZTEiMCAGA1UEAwwZTlhQIEludGVybmFsIFBvbGljeSBDQSBHMjELMAkGA1UECwwCSVQxETAP
BgNVBAoMCE5YUCBCLlYuMRIwEAYDVQQHDAlFaW5kaG92ZW4xCzAJBgNVBAYTAk5MMIICIjANBgkq
hkiG9w0BAQEFAAOCAg8AMIICCgKCAgEApcu/gliwg0dn1d35U0pZLMvwbNGN1WW/15pqzBcpG/ZB
q5q+ygq4/zkEqQAM3cZsSi2U2tjiKZOEfj4csyEJVZFQiwXMptsmErfk7BMoLtaIN79vFOd1bzdj
W0HaSTb9GkJ7CTcb7z/FKKiwc2j53VVNDR1xVBnUNEaB1AzQOkp6hgupCgnlkw9X+/2+i7UCipk2
JWLspg9srFaH0vwrgMFxEfs41y6iBVD70R/4+suoatXvgFv3ltGZ3x/hak3N1hHkjJq3oa1jSkLm
p6KoQAqbcHTkeKomMOmPUJK1YqDkpdbGuuRkYU3IvCW5OZgldrkigcOTaMNUaeZUAv8P3TTtqN4j
Ip/Hls/26VR+CqdoAtmzypBEyvOFDtzqPqVzFXfkUl2HZ0JGTYEXUEfnI0sUJCyLpcLO1DjnwEp8
A+ueolYIpLASupGzGMGZ5I5Ou1RoF2buesEgwb+WV7HRNAXTmezUh3rWLm4fAoUwv1lysICOfGGJ
Q2VkNe5OXzObvzjl30FYdDWb6F+xIDyG0Awxft4cXZcpFOGR3FH4ZZ5OH+UNl1IxnNwVpGSqmzEU
7xnoTXlyVH3Q/jYDG27HSoILQp/yRMJXWx/Xn57ZVXNm63YrZ35XsX91pMHDRoQdJBMKkya813dg
gmhEszSIBYKqoiFt1HaMK/KnPwSSLO8CAwEAAaOBujCBtzAdBgNVHQ4EFgQUeeFJAeB7zjQ5KUMZ
MmVhPAbYVaswEgYDVR0TAQH/BAgwBgEB/wIBATAUBgNVHSABAf8ECjAIMAYGBFUdIAAwOwYDVR0f
BDQwMjAwoC6gLIYqaHR0cDovL253dy5wa2kubnhwLmNvbS9jcmwvTlhQUm9vdENBRzIuY3JsMB8G
A1UdIwQYMBaAFJBIUyMqeeqEmz0+uQ7omXRAXqC2MA4GA1UdDwEB/wQEAwIBBjANBgkqhkiG9w0B
AQsFAAOCAgEAeXZR8kIdv3q3/VJXsdc8y+8blR9OWqmxjAo40VqPOWLcxLP2PkH3pleOPO/7Eg26
pQzIESYql5pxlw/tL7b4HhjcYpFom8yECNChnIxWeh8L/EfMPmcxi8wts4Zuu9q3bWOJxAcu4zWy
SDzbR/F/y6tzuaLgOZOmYihKTvG4dbRYBsC+0QMkf+6mfmDuB0O/HXE6bP9yf8rYZ1QWIfDp4h0e
MtRuPZ7DeJd15qEqv0AqeAWtuwAdXCQIBxYTYXHJxIwg7sxAMXdkFOXrGc8mCe6J+myQ0d449XIA
FVTpBtKPBjUfAnulbDFY8bEmkEEgyPYSmMALe+gDhOIlL3dJ2jeOd/edEfaIGlMfUPEnfD1s2sDX
PH8O3o9zWHWaU2bevYw+KUK86QiSa+wGussopb+n/cnBhgd9g1iNsO4V29YpaqaUQZVnKhL3EAhu
cecoNPiOJ2MMSboxLKmKtAGALdP2VC2gU7NxmatkzbU/FeZVApqWw/k6SPcO9ugisCOx93H77CHt
0kD6JWcMOn5/fQQmVvk34PESJrHCbYb11pdfzHsSPMwgih/CHik1cWP09mP8zS8qcucbUAloNHlk
kZl/V5eub/xroh4Dsbk2IybvrsQV32ABBfV6lfiitfvNOLdZ4NJ2nbPM8hBQpcj7bPE/kadY1yb1
jgaulfXkinwwggdyMIIGWqADAgECAhM/AAV1goSswyqoLYNbAAUABXWCMA0GCSqGSIb3DQEBCwUA
MIG2MRwwGgYDVQQDDBNOWFAgRW50ZXJwcmlzZSBDQSA0MQswCQYDVQQLDAJJVDERMA8GA1UECgwI
TlhQIEIuVi4xEjAQBgNVBAcMCUVpbmRob3ZlbjEWMBQGA1UECAwNTm9vcmQtQnJhYmFudDETMBEG
CgmSJomT8ixkARkWA3diaTETMBEGCgmSJomT8ixkARkWA254cDETMBEGCgmSJomT8ixkARkWA2Nv
bTELMAkGA1UEBhMCTkwwHhcNMjQwMjA2MTA1ODIzWhcNMjYwMjA1MTA1ODIzWjCBmjETMBEGCgmS
JomT8ixkARkWA2NvbTETMBEGCgmSJomT8ixkARkWA254cDETMBEGCgmSJomT8ixkARkWA3diaTEM
MAoGA1UECxMDTlhQMQswCQYDVQQLEwJJTjEWMBQGA1UECxMNTWFuYWdlZCBVc2VyczETMBEGA1UE
CxMKRGV2ZWxvcGVyczERMA8GA1UEAxMIbnhhMTg3MTcwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAw
ggEKAoIBAQCsljsxzffby7IAt42e7cJH7K+49RL+7i56h3ORt8dS8WNVSdDlejp6uS6mLk/UX0wn
sSxDK1S5KquGJQzaT/3gxE8tdgvfFNBVdrgr48DeCVwWDr1o/UF3RmGcMdxqRz1M/oLDJ03C8n6h
L/0JXiwsNx0KZJoqDrN/48yX5TkoeKJmHFftZ5Op57xV0WkZJ/yLxSC1Om75jOG/UPdqsDzl+wi7
YVj5egV24hoaXgHBxtCeJzUgsHcJlo9nFtGe11j6H1vqFzkPzN9ydjRmhQATV/WLqpG8uot79u0m
6n7Mjwsd/HmJf+8xpovMcHPO2a0axppssKso/3APP6mR1FuVAgMBAAGjggORMIIDjTAOBgNVHQ8B
Af8EBAMCB4AwHQYDVR0lBBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMAwGA1UdEwEB/wQCMAAwHQYD
VR0OBBYEFLNr0DCWM1fCXv4ubOt/elkvcoiaMEUGA1UdEQQ+MDygJAYKKwYBBAGCNxQCA6AWDBRw
YW5rYWouZ3VwdGFAbnhwLmNvbYEUcGFua2FqLmd1cHRhQG54cC5jb20wHwYDVR0jBBgwFoAU5TJ6
9GbBR5Ykf/wngDlY3ysX4rswggFKBgNVHR8EggFBMIIBPTCCATmgggE1oIIBMYaByGxkYXA6Ly8v
Q049TlhQJTIwRW50ZXJwcmlzZSUyMENBJTIwNCxDTj1ubGFtc3BraTAwMDQsQ049Q0RQLENOPVB1
YmxpYyUyMEtleSUyMFNlcnZpY2VzLENOPVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRpb24sREM9d2Jp
LERDPW54cCxEQz1jb20/Y2VydGlmaWNhdGVSZXZvY2F0aW9uTGlzdD9iYXNlP29iamVjdENsYXNz
PWNSTERpc3RyaWJ1dGlvblBvaW50hjFodHRwOi8vbnd3LnBraS5ueHAuY29tL2NybC9OWFAtRW50
ZXJwcmlzZS1DQTQuY3JshjFodHRwOi8vd3d3LnBraS5ueHAuY29tL2NybC9OWFAtRW50ZXJwcmlz
ZS1DQTQuY3JsMIIBEAYIKwYBBQUHAQEEggECMIH/MIG7BggrBgEFBQcwAoaBrmxkYXA6Ly8vQ049
TlhQJTIwRW50ZXJwcmlzZSUyMENBJTIwNCxDTj1BSUEsQ049UHVibGljJTIwS2V5JTIwU2Vydmlj
ZXMsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz13YmksREM9bnhwLERDPWNvbT9jQUNl
cnRpZmljYXRlP2Jhc2U/b2JqZWN0Q2xhc3M9Y2VydGlmaWNhdGlvbkF1dGhvcml0eTA/BggrBgEF
BQcwAoYzaHR0cDovL253dy5wa2kubnhwLmNvbS9jZXJ0cy9OWFAtRW50ZXJwcmlzZS1DQTQuY2Vy
MDwGCSsGAQQBgjcVBwQvMC0GJSsGAQQBgjcVCIWCwH6BjvRVhu2FOILrmUuaklY/hMbNXILljX4C
AWQCAT8wJwYJKwYBBAGCNxUKBBowGDAKBggrBgEFBQcDAjAKBggrBgEFBQcDBDANBgkqhkiG9w0B
AQsFAAOCAQEAWS4IrHXWhCGNWk5vn20xV7mlLkM7JPwltVJzB6MRzwUB438upbyUMwNHcEgAmHcs
xL9hafErN+n9rLL00wEqZsCV732s7YOxSRRjZTE3CmZQ2+TYjXR7A6AzQKo0fv/x43bpSes8ttQ6
Qtt8nzIbGBkDAcI7wfXsUPF5o0NwLOxre+Z+JCPNH0eaOj2J7EKD2ERLCClmvohrYdlmu85iXfyi
nJo42eq9g08FtnxTXVQSIZCtiETiGtXA7+t2Aa8429XXunsijRznaYw2SwI/s4sVmvaK3XHaif0D
QaUYxQp4s2ctzgz3eU6hK68OnNzbhBtF/lx6PHbifqHDzrtUbzCCB+8wggbXoAMCAQICEy0ACwRu
JYOozH+yQuYAAQALBG4wDQYJKoZIhvcNAQELBQAwgbYxHDAaBgNVBAMME05YUCBFbnRlcnByaXNl
IENBIDUxCzAJBgNVBAsMAklUMREwDwYDVQQKDAhOWFAgQi5WLjESMBAGA1UEBwwJRWluZGhvdmVu
MRYwFAYDVQQIDA1Ob29yZC1CcmFiYW50MRMwEQYKCZImiZPyLGQBGRYDd2JpMRMwEQYKCZImiZPy
LGQBGRYDbnhwMRMwEQYKCZImiZPyLGQBGRYDY29tMQswCQYDVQQGEwJOTDAeFw0yMzEyMjAwOTIw
NDdaFw0yNTEyMTkwOTIwNDdaMIGaMRMwEQYKCZImiZPyLGQBGRYDY29tMRMwEQYKCZImiZPyLGQB
GRYDbnhwMRMwEQYKCZImiZPyLGQBGRYDd2JpMQwwCgYDVQQLEwNOWFAxCzAJBgNVBAsTAklOMRYw
FAYDVQQLEw1NYW5hZ2VkIFVzZXJzMRMwEQYDVQQLEwpEZXZlbG9wZXJzMREwDwYDVQQDEwhueGEx
ODcxNzCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAL2JT+kRihW1mBdeZFOoCLGIl4DZ
VL7FWt3V1iFFJJe/bZDw/SUf5z1HeA8xv9+S8rqMyybjlSRHFLgiMm7qrGpVEDniKe8eiqP8Un4Y
3fHgK5FKZIVVn0KlaMuD5G30AMk9HyUdc2MkVRL8YSQCewkQDEVjB8gnx/e6xfbWEVHf5+dOWJoR
aket5+0JKV0l/dPV7cT4hL3BFtiBhq8976Li6rn8gxIi63u0G3qvm9Scqk+EHzemDhw/W+eMmGR4
nwKVLKzumxko8l6EOnnvqqF4vj2hKTpB+2lsEXH1giireMEsvB2RY40lnRUXVQ0FDklOIQV4Qdgi
EJfUdq/ZhCUCAwEAAaOCBA4wggQKMDwGCSsGAQQBgjcVBwQvMC0GJSsGAQQBgjcVCIWCwH6BjvRV
hu2FOILrmUuaklY/gbeCPIPthzICAWQCAT4wEwYDVR0lBAwwCgYIKwYBBQUHAwQwDgYDVR0PAQH/
BAQDAgUgMAwGA1UdEwEB/wQCMAAwGwYJKwYBBAGCNxUKBA4wDDAKBggrBgEFBQcDBDCBlAYJKoZI
hvcNAQkPBIGGMIGDMAsGCWCGSAFlAwQBKjALBglghkgBZQMEAS0wCwYJYIZIAWUDBAEWMAsGCWCG
SAFlAwQBGTALBglghkgBZQMEAQIwCwYJYIZIAWUDBAEFMAoGCCqGSIb3DQMHMAcGBSsOAwIHMA4G
CCqGSIb3DQMCAgIAgDAOBggqhkiG9w0DBAICAgAwHQYDVR0OBBYEFMJ81PK4p3H8Q7gn7u/5OwWx
uAwGMEUGA1UdEQQ+MDygJAYKKwYBBAGCNxQCA6AWDBRwYW5rYWouZ3VwdGFAbnhwLmNvbYEUcGFu
a2FqLmd1cHRhQG54cC5jb20wHwYDVR0jBBgwFoAUWJVg7k5072Uiqr3tGakreo4XnQcwggFGBgNV
HR8EggE9MIIBOTCCATWgggExoIIBLYaByGxkYXA6Ly8vQ049TlhQJTIwRW50ZXJwcmlzZSUyMENB
JTIwNSxDTj1ubGFtc3BraTAwMDUsQ049Q0RQLENOPVB1YmxpYyUyMEtleSUyMFNlcnZpY2VzLENO
PVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRpb24sREM9d2JpLERDPW54cCxEQz1jb20/Y2VydGlmaWNh
dGVSZXZvY2F0aW9uTGlzdD9iYXNlP29iamVjdENsYXNzPWNSTERpc3RyaWJ1dGlvblBvaW50hi9o
dHRwOi8vbnd3LnBraS5ueHAuY29tL2NybC9OWFBFbnRlcnByaXNlQ0E1LmNybIYvaHR0cDovL3d3
dy5wa2kubnhwLmNvbS9jcmwvTlhQRW50ZXJwcmlzZUNBNS5jcmwwggEQBggrBgEFBQcBAQSCAQIw
gf8wgbsGCCsGAQUFBzAChoGubGRhcDovLy9DTj1OWFAlMjBFbnRlcnByaXNlJTIwQ0ElMjA1LENO
PUFJQSxDTj1QdWJsaWMlMjBLZXklMjBTZXJ2aWNlcyxDTj1TZXJ2aWNlcyxDTj1Db25maWd1cmF0
aW9uLERDPXdiaSxEQz1ueHAsREM9Y29tP2NBQ2VydGlmaWNhdGU/YmFzZT9vYmplY3RDbGFzcz1j
ZXJ0aWZpY2F0aW9uQXV0aG9yaXR5MD8GCCsGAQUFBzAChjNodHRwOi8vbnd3LnBraS5ueHAuY29t
L2NlcnRzL05YUC1FbnRlcnByaXNlLUNBNS5jZXIwDQYJKoZIhvcNAQELBQADggEBALwIIuww1PaF
EbpQoy5vgJ/4N3xS+niIpFTKyYNAD0Ar38FcUlSnj0FIHKRj8rUmZP9WTky3U8m5B3LOyhJ14FPh
iy1EwkhZmds9fJiZyEEFiwQWYDG/uknu6zIKOTlLmtlYPfbzfi58keGcjD3T5H8D8DpCGWI1lAwe
clR9fJCbcYnQSQnuicSCfrHjjXiDZ2O8h7WbE1CC6Cj/qwo5nmS0lMv7yoG94rTNBvYe8iqOkcav
7KiZA6SdhXms3ppvFmBukI6pTheMvT39SM0S6E0dgeqZSGSxHrM7dcxUdAL4fnYMv3Sa+GAgyXB6
rihWC11+goz2eawt5TRU2w45TmcxggSzMIIErwIBATCBzjCBtjEcMBoGA1UEAwwTTlhQIEVudGVy
cHJpc2UgQ0EgNDELMAkGA1UECwwCSVQxETAPBgNVBAoMCE5YUCBCLlYuMRIwEAYDVQQHDAlFaW5k
aG92ZW4xFjAUBgNVBAgMDU5vb3JkLUJyYWJhbnQxEzARBgoJkiaJk/IsZAEZFgN3YmkxEzARBgoJ
kiaJk/IsZAEZFgNueHAxEzARBgoJkiaJk/IsZAEZFgNjb20xCzAJBgNVBAYTAk5MAhM/AAV1goSs
wyqoLYNbAAUABXWCMAkGBSsOAwIaBQCgggK5MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJ
KoZIhvcNAQkFMQ8XDTI0MDkyNTEyMDAyNlowIwYJKoZIhvcNAQkEMRYEFAlMENUgNTU0RHfjyqB1
NW7Wi7jDMIGTBgkqhkiG9w0BCQ8xgYUwgYIwCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjAKBggq
hkiG9w0DBzALBglghkgBZQMEAQIwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcGBSsO
AwIaMAsGCWCGSAFlAwQCAzALBglghkgBZQMEAgIwCwYJYIZIAWUDBAIBMIHfBgkrBgEEAYI3EAQx
gdEwgc4wgbYxHDAaBgNVBAMME05YUCBFbnRlcnByaXNlIENBIDUxCzAJBgNVBAsMAklUMREwDwYD
VQQKDAhOWFAgQi5WLjESMBAGA1UEBwwJRWluZGhvdmVuMRYwFAYDVQQIDA1Ob29yZC1CcmFiYW50
MRMwEQYKCZImiZPyLGQBGRYDd2JpMRMwEQYKCZImiZPyLGQBGRYDbnhwMRMwEQYKCZImiZPyLGQB
GRYDY29tMQswCQYDVQQGEwJOTAITLQALBG4lg6jMf7JC5gABAAsEbjCB4QYLKoZIhvcNAQkQAgsx
gdGggc4wgbYxHDAaBgNVBAMME05YUCBFbnRlcnByaXNlIENBIDUxCzAJBgNVBAsMAklUMREwDwYD
VQQKDAhOWFAgQi5WLjESMBAGA1UEBwwJRWluZGhvdmVuMRYwFAYDVQQIDA1Ob29yZC1CcmFiYW50
MRMwEQYKCZImiZPyLGQBGRYDd2JpMRMwEQYKCZImiZPyLGQBGRYDbnhwMRMwEQYKCZImiZPyLGQB
GRYDY29tMQswCQYDVQQGEwJOTAITLQALBG4lg6jMf7JC5gABAAsEbjANBgkqhkiG9w0BAQEFAASC
AQCXXV+JGtID8CBBleViEmLa9peZRnEwP2wYQQ6n38spm3Vd01VraGWAn5FxFoC3vq9aaNZyxOOo
TsQdrh27b56DOv9aLGfCvNwcDs+CbngbHeEDFpLvkzEMZDJTYzzKjSqtz42l0zaghKUKM7mhbRbx
W40Sl98qaqyqRnZNWru1hpEl4bXTrIr/h7i2nTGwDrEstGxOAxsj0rVZJkDS/eLdJVFrh/PlDJ/k
J34XuWfIxH1BBe+sJyFF/lj0wcn0MuGKVEj9oOrKlJMITEKBRs5JG0vZ4oOINyXkDB3k0ExUZveQ
GvF1ZaNK9JODrsA0AiqbPpbKboqF+oKuXmRGHaHHAAAAAAAA

------=_NextPart_000_011A_01DB0F70.9C149530--

