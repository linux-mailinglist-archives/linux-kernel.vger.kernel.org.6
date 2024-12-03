Return-Path: <linux-kernel+bounces-428790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 382919E137A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 07:47:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCA6E28297C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 06:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22931714BF;
	Tue,  3 Dec 2024 06:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dOJ2RV7p"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2066.outbound.protection.outlook.com [40.107.22.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 712F68837
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 06:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733208447; cv=fail; b=jDd61GFiWt+zcN2EXjF8JW+zCSyzH0+nQv6JCy5vUXXqwMrRg/2vRRUIa8ezZslJWSSyCu3iH1u487Om8pjzl433hNVW4oPPCi+Iu7+lQjOmyrZjCjef3uvKNUj3BjVxDTkhCzT91Esbb78zp9p9Ca67fUAPT0qEHLxt7Ng6WL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733208447; c=relaxed/simple;
	bh=lUPJuO1fTSihfDzhy/fB61rhBr/3E9evbUAw6RxtX/Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Hqt1i71Ehdk854+aVSqEly+ArJcwmjqG6id3ZLqRs+mNEj6PZRRNPV0tZzLdgclv4uvA7fWilkh++6Z+rJW12jiWnJ4hYqzRfwvmUc+nQvCwYAcRwVx1kgn5JsUTfq1SJNY29orDWLnNHlcb3NFg+NBmWpUTv5l0vp4lzfzOa9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dOJ2RV7p; arc=fail smtp.client-ip=40.107.22.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MsWWjNDUteQPZ61H0XcgAcgG1y3w9ICDGIPzGMgf8L5T1hUwBYj/W66Q5jwBSANzBwCrbOyfmcLlp7n9A0ZcFMYazKhcBIi+7GeUqi4zBnQni+4lsBkbIJml4dro7w6BlyuRBRkpy+T5VodTj5P8bg1cuIZdsWC+BFdG1LKDkDEekowDaAnGqNw3XB4Mf4yQFGepxqwyqFWZW+0zb0IywX+ZpUpZ89kbmMSN2HatRyztICBCyTLO7elhu7m6Na5nCoRWblfTssS4YvvXoKhFrv1wcZrhaxxj4ijpRIovi104dxG7yjQ4T0539u3uAOE+8WXFlZS6lOwVskRxfz5z/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S5W1pdG1/g1x5Kl5aExxDvEWOMwYFO++dRHej9/5fSc=;
 b=jEdAaFqQxnC/qogvaBDkn6le64oPDJctQvfZhFcLk1UoZk6baOLm/KTCxBKJlqACGNnO038iccFTacJcUFN/CFlq1X3Hwxv3OMvTncD0dB/wo7JkSt3cOVxgD+g4d+3M01jiD1f6bSXMMcf0MkUX7r/Nhrxru1AE2qTIcdfjCnBaERi3PVM4mpZuEhffU6EQhsDzrgzl1fbgfFvKhUJ5wllVrvcZe3TLWYFd7nN5a0ErX3ZYz0Xay/Qpr7TV4+u9xR2WyDRph+IeDaQZqxDxMNx4Fv5D7qza+U3nmnB3d4acOVm0VrZkCOrmLonq4H4rhoUXJuj9BpYZ2Jos0QftWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S5W1pdG1/g1x5Kl5aExxDvEWOMwYFO++dRHej9/5fSc=;
 b=dOJ2RV7pwTEmwRFOix8tDeGGlZUJSLMbLjgxojp9/qV4Gu1i1Qdkjev9BPFzIrsPNsx4qDYVdLDAXjapLQkfaxKWTCE28glfhtQsMM+xRzy9ELDq1pInR+iSspjQzPk4/FT0qx3HHpuh0iJGn/QSuA1McJnk9kcqGlwA6DEPmJCV1FV7iFPPHtTXOy4hRaN5izlVem1/IdHvg/ZjT6b7CgGLSh8VSVFFFz246T0fQIRvGW6N3GQ0pyIJEXHxVGEhpKCwPNXqWncajkBBkjDtp3yXY75iOd0U/w2462pq54ArtWnXLQi9T2ML5MzdLZEAZbdez08t3um1tCa0bszxog==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI1PR04MB7119.eurprd04.prod.outlook.com (2603:10a6:800:12e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.15; Tue, 3 Dec
 2024 06:47:22 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 06:47:22 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Sascha Hauer <s.hauer@pengutronix.de>, Srinivas Kandagatla
	<srinivas.kandagatla@linaro.org>, Shawn Guo <shawnguo@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
	<festevam@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, stable <stable@kernel.org>
Subject: RE: [PATCH v2 0/4] nvmem: imx-ocotp-ele: fix reading from ELE OCOTP
Thread-Topic: [PATCH v2 0/4] nvmem: imx-ocotp-ele: fix reading from ELE OCOTP
Thread-Index: AQHbRKyGyC+sdMxPwU+E4a5ImYqmM7LUFNtQ
Date: Tue, 3 Dec 2024 06:47:22 +0000
Message-ID:
 <PAXPR04MB845905D963FC162FD46D4F2488362@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20241202-imx-ele-ocotp-fixes-v2-0-3c021a97eb5d@pengutronix.de>
In-Reply-To: <20241202-imx-ele-ocotp-fixes-v2-0-3c021a97eb5d@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|VI1PR04MB7119:EE_
x-ms-office365-filtering-correlation-id: cdde9586-8efd-431b-b432-08dd136656db
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?+IGV6wNBB9BKhw1xn8F0vXE3goVB843iIqbwmd6uG+C9wY7bkgp1/DpL5tYq?=
 =?us-ascii?Q?iuRqBkyEEZLf7+LeK29inotvuBCbnklrclxkA8sVMqT6RnX1NQJCvg5ETgPX?=
 =?us-ascii?Q?tbW6TOW5ira+K3k0Vs7ggiXuUw7qIe4/9RP2P+76mVAaAc2J5G1s7THNFnL8?=
 =?us-ascii?Q?DbUVDT0frxF77KoDg55m4kkk6danGvnc1QxBrEJ1AklMYe2Fy6kAx/+R39I7?=
 =?us-ascii?Q?IUaBNDYBWZ9HVXLS9/ISCIPOCeVTmUwApZU4gC/aveH6n3rYrgylwIkZ4GFV?=
 =?us-ascii?Q?bGe8izUaGcKAfLOk93p/ACOfWSY04X7vEqqkbr63JjyfmjddWZ6JLiT+oNrF?=
 =?us-ascii?Q?d7lclKPTUekWYhDIewN2M3vsdQJU1kqC/CdDXK8yp7j8UdWmppdySXiEPPYt?=
 =?us-ascii?Q?9eCQbI1/z7ZNYfdRxD5ILtSvUNBodEQ7UDQEI8qeCns7wlnEjoQZc8ZnTFXg?=
 =?us-ascii?Q?pqEdQCRuXjRna8RFclunJZUKNNN+5YG3n3+C3NDzW6PUD80lCogvlWIfYYp0?=
 =?us-ascii?Q?1NDzyX1bSrMNmidv2QMRtxbRXT74dYQv8ZVPeMjpiZFjrLcFeyRYYPs+HSz9?=
 =?us-ascii?Q?twUPtOqBJTFEckVvo8HlSWtQ73o8f8+mDl8sUdjFOgbBCqY5Rt5FwAec2twF?=
 =?us-ascii?Q?5F6ZWi2Q3yZcgmpjSMqDQVKrQNuHycOpiV5rZE6+NBCnGTBkDUaD4NQZeEpZ?=
 =?us-ascii?Q?2henxUgpXPL0GF13zFpn5evYseBqh/sQtKn8A1qNRZw/Etnin3V7u0Hr4U5B?=
 =?us-ascii?Q?aOxCkZ94Tc5ogj2NAQEmZoQpZFoTSBbxEkWYf4V9I3w2IubtHc/VFHkxL/r5?=
 =?us-ascii?Q?IBvZjt8HTWBIXJs+PAPKZ1eZPWiOwSfJ6fo8wiW+aIYq81ltxhEX7QNS4sXt?=
 =?us-ascii?Q?s/n7N6ge/+Ps6GPG4ikDoh5fHyMcroSGraEGiLYVjuD7oAzEXY1JFAXKrz+I?=
 =?us-ascii?Q?0feZYXsqbS9h7L30qgen1lWn1qHOzE3W/xo9ZuRvDNCOATh2USDdl49R9BEc?=
 =?us-ascii?Q?5F4L1mQ4G3IKjj/S0BWz8G4FOMkYE02L4geyAikL5WslAHxiYpnJtTUHRZQ3?=
 =?us-ascii?Q?s4w1Y+0UL/YUbXsTbX/jTB/241EPZMIZH9mXFCb+sAmeMYqygYr9nFDGHFSq?=
 =?us-ascii?Q?dMI0JdlzhuR673RIOcldhbQr34YarxZsezScWehbP9D+vSwOj+oxiHA6O5+E?=
 =?us-ascii?Q?fDEYjg40P7p5Yea1bzHrsjDSfRQCIYk38y87i83+Q6SedPRciICyvbjXwAT5?=
 =?us-ascii?Q?7D3XjIOztZDPj5b/wXZxETtHYIMuSw2tO2PeGfObI5T8nKH1ogNAFt3WQlLC?=
 =?us-ascii?Q?TDEpwmzEckYBpyabw7+B5UHOjraAUtML10GyE6/aR2gtGul37fKrfTY9nFHj?=
 =?us-ascii?Q?7rm2UewxfJjcwuII0/EkIhc0ZXGFQoIw5YGqA4eYP5je+UZL4w=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?pjD951pb80pwqfwciwEI584eCo3tmt1P08n8jDM2wqBqZX8BcmPXFXnlgKsS?=
 =?us-ascii?Q?JyFa/c5397jy5NffdtZIjQUpvTPqN4FscFyJl5Skzjk497y6pBlei7iS9r83?=
 =?us-ascii?Q?QZLlH2t0PfjLs4Qdhmi017frg+J6QzeXwY5xN2liiQ2pFu4QpRvBRmfzuidu?=
 =?us-ascii?Q?Y3ErK9UmuWIuSJHXpzqyX3G7RdMcTiQ/YLSoK8oYHaMxXWaAvUkI14Ub/rgf?=
 =?us-ascii?Q?1okQQF0itJNwjtqIJgduOahLYr5765bHbuFsdUdooWQf1ZPpbM2xJ7XLvtRD?=
 =?us-ascii?Q?ZMvqJ7Xc/aEVV6DDMx68hEEeqq1pBjjdz6YPO5NF2CcQ+yShR/Xbva3IthOU?=
 =?us-ascii?Q?BG8cX5cJyIWyRTRjyDenJR6v0HLBjBGDOpgARIFlGLj1qbgmYySkazr4pjY9?=
 =?us-ascii?Q?VJv4F1jBpMRzIp2RPy3NQj1OjjfcV/hErJEgUiHUZn/jB8EYnXQUjHBIUUho?=
 =?us-ascii?Q?g3LPOw4xBoMukQfTcxua/YpfTUQvv491wmU8fUc3UFNKzgeB1Hfxt5lM7ocw?=
 =?us-ascii?Q?0I+fHwUWEKPkWqIQpA+EMr9aqY6g/Zy37KNyhn2yAp8R3ve4ot//vHB0+Lpm?=
 =?us-ascii?Q?FO4T2pjVrpQ+aVlNVsu5PW/CB/S/zA1RAjuvUC7t5vKTlMPwe5nPxXc53pVb?=
 =?us-ascii?Q?hE7/Z5NsVjd+nvEb/hJxUlhDE1Abv6a3bVit15ZMVKi3pmZOVDiXmh/Uc7EQ?=
 =?us-ascii?Q?6kiilu9uOezJ7yVxGONA5zBdscf6rOVIUA9IWsWW8fmseZ+BRiWQDlT7EOSj?=
 =?us-ascii?Q?OFP1xDdfvHx5mkpRMJaDhjQTuAMgp8UeOtWaBJElf850Czlde6WID+lyxn2R?=
 =?us-ascii?Q?n5PRO6SL/Nl4BhjNY95wCYyj0hFHS7NZIbjEioWqWO3pUA2YwXQW+JG9cX0Q?=
 =?us-ascii?Q?p2PaLD3XPWT7TeOirFm4WgXkFyYNcd2kCNrzgQph8nxnmBaQBUaOau1IIi4w?=
 =?us-ascii?Q?TxgZr3S/GR+giDBCNrGV6I2wksUZh1mZ9UaY8iopO5Alq8IR94Dlly0/dGRB?=
 =?us-ascii?Q?/u1Si4d1v1FYMwuhjwsKXUod05a3pzbhlWdGUBU7kmVB6F4T74L43Ug4PuXb?=
 =?us-ascii?Q?yFcFXS/YEUCDBRoU0hpolvGWKGl+NNzzu1gv+IR/MuSiaEnOll8UzddBbNeu?=
 =?us-ascii?Q?R3B25B2RScjwlixR1P32kh2Afkv4JeE4zHgbXYpAcxcpR2pUt8XRy38XB4P2?=
 =?us-ascii?Q?0MS/npx3pCvIjKTmnfeMAkR1KSMF2LunDArTcRBzmEAOI2af+fNaGkgJC0xX?=
 =?us-ascii?Q?6W7NpWLlq6vTgfNoGX9xWR67/CMPfhd510qTMp7g8bWKSHlvkCv3CzX/b0MP?=
 =?us-ascii?Q?h1nTgd51nZWk80097Uy+ECmKV06StuWyCtVhBzTMWMTu0Fq8ZMVdbsScOVCg?=
 =?us-ascii?Q?/TMWO5KK6hU+xTqcipxuYQCS4UHvj5xxiVcnhL21BvBjtAK8l0gSV09DHcJO?=
 =?us-ascii?Q?7ToKkqLZJ+EkqvS9vY/mLXKEgZWCEc58E6FnzDiiHhll7Y74yMuhfTbWT1pm?=
 =?us-ascii?Q?l773T8XpKezXjIjkwtJh6JYSfP66IR0sUqsCmPulTd4vuqRc9AGKicGDkote?=
 =?us-ascii?Q?d8FYhRTEgcal2PTLyxQ=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cdde9586-8efd-431b-b432-08dd136656db
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2024 06:47:22.0691
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7NBFNo5o4GMPVTqFqRKupecIE/tU9ICy/vDso+wK42uxNPOc+rJFgg7rQWYn+Wa8G0lr7a3xuECqzqab2WJ9/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7119

> Subject: [PATCH v2 0/4] nvmem: imx-ocotp-ele: fix reading from ELE
> OCOTP
>=20
> Commits b2ab0edaf484 ("arm64: dts: imx93: add nvmem property for
> fec1") and 0d4fbaffbdca ("arm64: dts: imx93: add nvmem property for
> eqos") introduced NVMEM cell bindings for reading MAC addresses
> from the ELE OCOTP. This doesn't work as expected due to bugs in the
> driver:
>=20
> - imx_ocotp_reg_read() interprets the incoming offset as 32bit word
>   offset, but it really is in bytes which means the driver reads bogus
>   values whenever the offset is non zero
> - imx_ocotp_reg_read() reads wrong results when the offset is not 32bit
>   word aligned
> - MAC addresses are stored in reverse byte order in the ELE OCOTP, we
>   have to swap the order before passing them to the upper layer
>=20
> This likely went through unnoticed because the bootloader normally
> adds the MAC addresses to the ethernet nodes and in this case they are
> preferred over the NVMEM addresses.
>=20
> This series fixes these issues.
>=20
> Sascha
>=20
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

For the patchset:
Reviewed-by: Peng Fan <peng.fan@nxp.com>

Thanks,
Peng.

