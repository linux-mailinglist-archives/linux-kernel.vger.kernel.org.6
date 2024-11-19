Return-Path: <linux-kernel+bounces-414035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 729619D2226
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 10:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01950B22117
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 09:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F020519ABC3;
	Tue, 19 Nov 2024 09:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="eLJBNVQj"
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010001.outbound.protection.outlook.com [52.101.229.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8818C12CDAE
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 09:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732007211; cv=fail; b=mjVKfJ4YtZhswuM1p30gG+/HdT7uMlM6CpmPMq74o5Dexow7H+b+pRQZHdZAqnnaYMUxFUfCrF1OlmyY/q3XnJP9P66mjDN1ljRy9+L9N2VtCC6qpsJ03yrKPr9tPubLcEc6JPfcl3nVpyQOvjjoEDic9+q7+h4l5DpRNc4hnwQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732007211; c=relaxed/simple;
	bh=RBymhdNJ+1IgA0oJKa4Su/287z3BXMfFh87V4Jn7XLc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FO/W5Qh0o2+SJEjDlv4moLiMVLfTrg/8WUaMKi/nRyynEoCsjhZDc/6R9eReRRM8Ww4Jugj45xohH0T3No55pmh+VuXKp0hk+1ijO6OlcjJ8fS5mecH3jnus++nDb1Yz4juv1Hed1qMDWRVHd3GxkNaDJ+JQda/SbcjU5OygYME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=eLJBNVQj; arc=fail smtp.client-ip=52.101.229.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JTuMkfq980V18l6o9D84HryRWYNiKj/4E3cXdl5NvfoRBFCutIJ2vpLS8lMVipj7jDmTm3spK2NUurwb4QEmoiwudOPRl5tXHtupSu56YTFmQGZx+k4jpuxOtF65/9UYw4mLZOWyOvbdlj26uJLTfVaM/KdQL5V7606PIrf5ppuvwoUgOtTZbQ3KxS5OO0nT7KR0qUYp0Z0snBoKPSy0M8GK6eTBL56nRyBUc+6R7sgomgcwQwyAAFQnRUZPtSdi3EtoHQRNr5x7vhmbYsAO6FJ8zCPMTeveBWuGWv0aijHaql110rGwFx8gP48vdlcBKCL7zCxzFuPjq6+kB8miYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x+U3WciYrj4IJbGCwLw5xlTqJAWCi+TfQy1sG+Bgb/s=;
 b=UqG1Dtm8hB6goR8gOQ4bBuUlq6F7HoZtZ+OnUJVIbFjOWlVz+E+otMPHvNI8W0PWp7lJJZiFB9ZswGwRuPeaVqPdkUdF1onE83v4LZfhY0Kxf9iYKgRVdfVIRctJ4p9Ennhjj2GSFyB/mgnhCwXj/f7CULU/0Jkpwo+3eiiG0noA60ikK6LF2yiERhFSdpKfCyymzp/44ZPkDY7Tc1AuEF1/JkGs5F1JeCApSxSKEt4czqmBESyBOUQtGJSAyQNPQcDQlbcdo1S9/zAnaYqm3AnOIeC2HcibrN+TbfTuohV2Xo1U7DrJI00S6sXqLfh0jPzY4k3rr9g6i4o+DqUCHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x+U3WciYrj4IJbGCwLw5xlTqJAWCi+TfQy1sG+Bgb/s=;
 b=eLJBNVQjXtIeVGal5LIV7ibY+fUOfedqnuCMad0Yv8UYmblBXIuvMZsQfUyjJlugdqw+uBlhxwjAERJ6x5aM2xMSNhjBQePFTw9lOOB72JU4s8q0S5PlX1cdQC+Cqts6Qhtd7WWW0hH+cAGMDNQyLksBXCHrRGcER+NeJbtmInc=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYYPR01MB6825.jpnprd01.prod.outlook.com (2603:1096:400:d0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.24; Tue, 19 Nov
 2024 09:06:40 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%3]) with mapi id 15.20.8158.019; Tue, 19 Nov 2024
 09:06:40 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Claudiu.Beznea <claudiu.beznea@tuxon.dev>, "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>, "broonie@kernel.org" <broonie@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"jbrunet@baylibre.com" <jbrunet@baylibre.com>, Claudiu.Beznea
	<claudiu.beznea@tuxon.dev>, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: RE: [PATCH] reset: rzg2l-usbphy-ctrl: Assign proper of node to the
 allocated device
Thread-Topic: [PATCH] reset: rzg2l-usbphy-ctrl: Assign proper of node to the
 allocated device
Thread-Index: AQHbOmEO4WpuDveF/0m6fUTtmlqMerK+T67g
Date: Tue, 19 Nov 2024 09:06:40 +0000
Message-ID:
 <TY3PR01MB113469C850289353DD9C28F7C86202@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20241119085554.1035881-1-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20241119085554.1035881-1-claudiu.beznea.uj@bp.renesas.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYYPR01MB6825:EE_
x-ms-office365-filtering-correlation-id: b2cf58ab-74d3-485b-d57e-08dd08797b0f
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Dj7lDY2LKC0QFRxwmTVQjosWDKLvEXdGlYweRgbb+6ODEbAIWdEsUDTKZRfS?=
 =?us-ascii?Q?oOfFFT5b7rwddt/5pR1thWTH11h0LH8IvlrT7OIQKR9xb4OESkYdwAtu7WBx?=
 =?us-ascii?Q?CT4LpBqI+oJBP4K+yPPNjA64yG9iPBnv4mB5xpOhcIC2rMaEE9viYFn+MEAn?=
 =?us-ascii?Q?O2BNNjLHxqNTsOUk3q0370fW8sq2IF48XvBNmpqD41gZO0XhMgnVc+iFJV8s?=
 =?us-ascii?Q?csfDcJaV/SIdBaJYc9aC7E8b0ImzSeNqSDCGCi2fu1C+lTGgGbW5KYzeORHb?=
 =?us-ascii?Q?XyEEhmvXIPJAmKRA4Oa1YSsF+BFvQN6eop41itoFcERXXIFXKpHP03MXvUBn?=
 =?us-ascii?Q?AAjxnoK4jSZccWiQl+Mg3906F9OlG5r3fdWbOiIa0ksh6A+o/C3HpgiYPqmr?=
 =?us-ascii?Q?iLDM2Uf5QvS7C9Vh7fxwv403EEyzWKVIzGIrQrHMmUU4LUptvxaVaEEltDC9?=
 =?us-ascii?Q?//6APMaqFGiqXA3mL8JiqzemqfKndDrP2glKBYl6D7W1I4N5di2gLM1tIeHu?=
 =?us-ascii?Q?YlpXwK2k0han0xmVH8fV5wzdmFhD+/iKLu9sNT8s7wZumiMp7z044TCNPKTn?=
 =?us-ascii?Q?HmdCPqOBACxzUpor3bcYoiDtNng+UPbqsc+sg64//b2PIZA9guf3TcsZCaOM?=
 =?us-ascii?Q?shFAtozu3BesJiGP0qTXXa8g0aDDxsuEeUsXqXF+q5CaGXQsjBBpYGc4k1dF?=
 =?us-ascii?Q?S2neBMnPusI4d8XqsueXSEV6WJ0JqeWnH0vM0YC0sdMRy5AS5x0J9U9PuXx7?=
 =?us-ascii?Q?WnElxeylUgoLg0vxriXXrPVVpOmQ+RjVrsJjRKIQmLu09+2k0bqRGrm1PYNe?=
 =?us-ascii?Q?E149xjx92TEzMwyxQGML+KOpoDNWzSic8rpGQy47AymBOqMX2xfD7DKKwt7p?=
 =?us-ascii?Q?vUS5OTlujZ8KqyTn+B3kFlYE9dphztcScMMc5LsGb9DfVuqciOAaEKxj6Eai?=
 =?us-ascii?Q?NhlkuOdfTKGifMTnD73QCiEVjoIAHUDBzFYCmefh9Xcz94Kri/ppAzH/7573?=
 =?us-ascii?Q?s1OOg/Nb0ZgzpwQT91TXSy6tqLS+RcU7nwwXpYnUsAgJzQ60CBEAvK0uytHV?=
 =?us-ascii?Q?oEcmkZeynu2fFs5Hp3PhAOVdIbt7aAS8ATD/5bGeX/9vQ/pXqzjNy2RKMv2V?=
 =?us-ascii?Q?GxRIXABWQm+vHk1TwpE8Tb7I+YRsdATyXhIQW06vnY2+giVmwBa0nfCILT6X?=
 =?us-ascii?Q?O28BM1CrvHsKf5DEijzCbVSkyjzj088AENF3bx1HRDaRNP3wQIRyOdsCV3jB?=
 =?us-ascii?Q?gl/8ZA2AatBFTpQDIEYrhfHbYSHKGOR9zVkgyZe7KtuCdcn4skqHDxvoIPek?=
 =?us-ascii?Q?x2/qma1CaZAdf5rX2hFI2vQHmdsSvepsYOGog0VodZn/IFeGTzq+tIHdK6LM?=
 =?us-ascii?Q?j2eGAl0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?lbnsxQzA2oSFpoW29cocer+kQhBrudaGSAOh3ryA6rQHZ8ljggIyTR0fViuh?=
 =?us-ascii?Q?zjCAughlyZy8aRnlFI9U5B2d/d5dpQODevhiL1AGeGwecs5Ez53zBYkb7sqs?=
 =?us-ascii?Q?yBFQrI+HlEluu3yuzgjFLX6N85AOCE1o5qC6zGPKtqBHQB/HAa7MXhtRJqO/?=
 =?us-ascii?Q?89GrqE/3gn6s/Rg4XP5ioQVVuFMJ6lbfvuxR41tk84u4D2yMMJv6uWvB09Er?=
 =?us-ascii?Q?ZDyaDnWM9GqYeI+Um+VpPsttgERMpahb3fkGx9wkSUPz1gCWTSV0tR6oTazM?=
 =?us-ascii?Q?Gs+yT8hFiT7luK71DTU24TIkt+R2IIsprVHNW8LCpZ7OFErlfrHBX5/m0DLK?=
 =?us-ascii?Q?95VXg8VH+mFQ3BGobBU2ZoNax3GYQHBCNX7xPrwW9pbQ0IG7QOQX36tDte2e?=
 =?us-ascii?Q?lX+swqxrKiZd9m8p2M5iX6FtBdmOP54CzYWRmI24l0V5v3TRNnc5rivNiN8R?=
 =?us-ascii?Q?ADBzKSJZhS1AFJz/w/WO/rNdTP5ceH9PT3hdoeBdYtnHR6iGvtDXs8qXAQbY?=
 =?us-ascii?Q?elJduMf3rGgwZQwm2n6XpLjxO4aDcADrNFGYJgmk4i/CO4EgiwpjtSkebF5Q?=
 =?us-ascii?Q?TGAJBD5RF1pYG3god3GqDydL42CVzbEzEq2UHuzWq/WLNO5s820MnNsamvib?=
 =?us-ascii?Q?QpeDtJc1KRRbhKa1qxLVnCjZ3fzV9jjD0sBVQJd9vEqGcoDxl2/FFOiNTm1O?=
 =?us-ascii?Q?QtegPH3XY+fpHD847RQwZsvgd7QN7UB0NwyYsUmE8uEXf/2mE4Ufdesc7yCR?=
 =?us-ascii?Q?8vX0+uk+dxoH56680Vcc/enSbPGWacfvj9N7tHg2wZwtdgVqVaAf+IsWunz2?=
 =?us-ascii?Q?+zra+8ZOntdtV2MrExfmJeiN58YvIflLRbEVMr5pEuM0xr0SMqr1J6TYMwOA?=
 =?us-ascii?Q?jpo64T+5eWEGEP830gIKVeA+CY6Bh2O3vFDnJCzlF4eX3O2ICEOLreHF0wj+?=
 =?us-ascii?Q?9txr5Ohl3oY2AfR5Egvel9GaAXjrrlFB3mC/Lwd5wnUmYGRkL7OgQ6fNAmk6?=
 =?us-ascii?Q?W7qiER0blBG4iHJmSfrsBWWp4FlABXHyTXO1jFlG8mnal7NAPckxEb70hdEZ?=
 =?us-ascii?Q?pG5kF3vsTdeU1KmnAJFJQfDtE+fbNKS3YADvUfC+zlcxqIh53YkVLqzE6pjG?=
 =?us-ascii?Q?941TAV4GbzswdUqZ8bfWTnFz/PFuJj11Gqy9I4fxIlMrjs4JTxnA+zCp1os6?=
 =?us-ascii?Q?yv7qPQjLEzjfkQCOCzdeU2u56mPtl39tVFfBnqDUPfd+KLYJM2BeL3ikZWER?=
 =?us-ascii?Q?W2c0bpacOMvapHUO2d/se149L58joYViGITX9vx3p/fxGaymjnJM94mc9m+b?=
 =?us-ascii?Q?bbS7wgb8QXNvr0g3EmIa7xWAeruXH4bnsERoi6vzdWtIiKK51VPo5SJlfnSa?=
 =?us-ascii?Q?LBb/h9KBWuxvYDQusKOZ+L+N7TzfALTK1/cmTdQQxno/Zi/AzaIVOH6kaL7G?=
 =?us-ascii?Q?UdfPi9KY4Cx3NwKtV4SyiKBdNaw3Y1Qni0H4aduqeXLjIG7y1F4BPQPOwQSZ?=
 =?us-ascii?Q?mK0KW1dEXbCYMXe8Jyv/xIETYsMcGmPgtQvZ5r+GXzdxK6pNg0ohEjb1DmpC?=
 =?us-ascii?Q?8LogO7eCwOAHs+XMLxxll6iI45QjzSZyoFXLskr2C21ETmVu4B7F/jQTiNP8?=
 =?us-ascii?Q?9A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2cf58ab-74d3-485b-d57e-08dd08797b0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2024 09:06:40.5035
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fdnFdUKEJCfIoHuYyRWQR1ohVGX4pJH3OqyZYfRSlAAWClubUtpAW75KQ6LS4WcDMb7VOj1M3I05Ron+oOQIqAGYvaK1lhIguthUhoeaNJg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB6825

Hi Claudiu,

Thanks for the patch.

> -----Original Message-----
> From: Claudiu <claudiu.beznea@tuxon.dev>
> Sent: 19 November 2024 08:56
> Subject: [PATCH] reset: rzg2l-usbphy-ctrl: Assign proper of node to the a=
llocated device
>=20
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> The platform device named "rzg2l-usb-vbus-regulator", allocated by the rz=
g2l-usbphy-ctrl driver, is
> used to instantiate a regulator driver.
> This regulator driver is associated with a device tree (DT) node, which i=
s a child of the rzg2l-
> usbphy-ctrl DT node. The regulator's DT node allows consumer nodes to ref=
erence the regulator and
> configure the regulator as needed.
>=20
> Starting with commit cd7a38c40b23 ("regulator: core: do not silently igno=
re provided init_data") the
> struct regulator_dev::dev::of_node is no longer populated using of_node_g=
et(config->of_node) if the
> regulator does not provide init_data. Since the rzg2l-usb-vbus-regulator =
does not provide init_data,
> this behaviour causes the of_find_regulator_by_node() function to fails, =
resulting in errors when
> attempting to request the regulator.
>=20
> To fix this issue, call device_set_of_node_from_dev() for the "rzg2l-usb-=
vbus-regulator" platform
> device.
>=20
> Fixes: 84fbd6198766 ("regulator: Add Renesas RZ/G2L USB VBUS regulator dr=
iver")
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>

Cheers,
Biju

> ---
>  drivers/reset/reset-rzg2l-usbphy-ctrl.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/reset/reset-rzg2l-usbphy-ctrl.c b/drivers/reset/rese=
t-rzg2l-usbphy-ctrl.c
> index 1cd157f4f03b..4e2ac1f0060c 100644
> --- a/drivers/reset/reset-rzg2l-usbphy-ctrl.c
> +++ b/drivers/reset/reset-rzg2l-usbphy-ctrl.c
> @@ -176,6 +176,7 @@ static int rzg2l_usbphy_ctrl_probe(struct platform_de=
vice *pdev)
>  	vdev->dev.parent =3D dev;
>  	priv->vdev =3D vdev;
>=20
> +	device_set_of_node_from_dev(&vdev->dev, dev);
>  	error =3D platform_device_add(vdev);
>  	if (error)
>  		goto err_device_put;
> --
> 2.39.2


