Return-Path: <linux-kernel+bounces-272060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7ACA94565D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 04:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E89F61C22677
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 02:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360A51C698;
	Fri,  2 Aug 2024 02:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="h5wze3mo"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010033.outbound.protection.outlook.com [52.101.69.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F328A3D68;
	Fri,  2 Aug 2024 02:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722567077; cv=fail; b=JHMI/iWiP/53ErnOQ5bAMAzzR6eI/ds0HavszEHHWSjcflLrKZVtGe/JgzSzRiYG+Uy2kIaQK+0bK4JAXhgQJd1MwlYg0LKEGVMWtzvzGvWKWjq/Ty+gC8wyNIPJKzqDYqCEYjLoPpdGPnLjor2fIcnV6I5a+TMlNOdDXE/2rKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722567077; c=relaxed/simple;
	bh=r6VNYYYq2WJt8cknXyU/q/hWu3o+NhyBattu99Re0F0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OTygX6M8cj9guYfYGlRNNfwFOkzKm0GimHvswfd2e72VaDyekbAmNWuWNZLcGAAKJT7q/QCuRVJzhy/6qhMwA/qhJfviTZem68Y+WN2TO5vikbbQNBSnNJHfCf3BBzu+LG7nEhoOgVHZfSK1EQJ8lg8VhoQ3EzGcxOd2ueNaqZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=h5wze3mo; arc=fail smtp.client-ip=52.101.69.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jC84en+vzf/ZnScEtY2uskHKdOfS7p+cMWhw6uKajlpAGksVlCwDrrQxuLs/kzycb1TnwMIYuMVAzmou8hWMTXHHkGn2ztqDAPSUwgEsD22kOr7l/IifCrkqr8Pv15m4ZcJ8PFZp7y6fFuFCLOn6B/xQgPFfVe8m03vPfox7otd3W+TvDR8UVrkrO7Qm5ruBpOVxQVbtEqagFGiEAcS65BSainYJR5IW90faWZdjxId5N+iRmn80Km8RjyL1OAlorO+Vsq3OxhWY6KdSh9PLFFytnTXXnebjSqzNhrd2RBEblMLFPvVOAZ/VxqC9d7h2XlAdAobqkt98AjqxeAyr4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r6VNYYYq2WJt8cknXyU/q/hWu3o+NhyBattu99Re0F0=;
 b=jzSDCQiF7tihc/lTKCTdQE4csXePguxOn+PjQuU0dEmP70pGbIDUFNeKZdG+Wf+RMFdM+vt6QCzAOHXAJlmVK25cF+27iZNHiwCicG6+Rlck4sLLDqU/sTnfv6bN8L6F1rHWh2cG0waptTA2mvX9m/FzvieU1GAt7xNLWv7RnIpNBz2XCbNW++6CkyDhSuyzpVebTVk0xSZNIjykGN3Lnu65fQJ3GakVYcGG0+8T/A+tyF+nsRLulntZvIK5ooHCo0ctLlAKECZyGu0BGhttUmqPghY+ftPdwQqD2IbPX7yanbuI1zGmt+pPaVelxpFmGI/q5r8jofxKjKNX4SwaaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r6VNYYYq2WJt8cknXyU/q/hWu3o+NhyBattu99Re0F0=;
 b=h5wze3moDaPTmgexHUMzcfo5XAvBk0HGiZC0/t1C7xyaYkkiP0DEmDFzFKtMWYoB1XkOQlZQUzqLifcayh1okuVwtMqDjW2MKTl8dqoDDyJV+xFscxIVkAPFX9s0zYSMVharXFwhGucraWwkXmJma6+EcWSIvxUB/RowcedK52ztnBnC2cc45yQEcwxuyFMxghUcM/3UDyw470oDHB4Iv6Zp3/2NiGj1aksv7ssFhmxOXsWwHtgx88BwGPXHBm4gb/W0JtBjhKpI+tvc56cMK0xXbaloCHEO/XGbg91iMFI82PvZtz1/dVegznuSM+XxEHUGoFWoKcAicPfDzQmtWw==
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by PA4PR04MB7536.eurprd04.prod.outlook.com (2603:10a6:102:e1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Fri, 2 Aug
 2024 02:51:11 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%5]) with mapi id 15.20.7762.020; Fri, 2 Aug 2024
 02:51:11 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Sudeep Holla <sudeep.holla@arm.com>
CC: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, "cristian.marussi@arm.com"
	<cristian.marussi@arm.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "arm-scmi@vger.kernel.org"
	<arm-scmi@vger.kernel.org>
Subject: RE: [PATCH RESEND] dt-bindings: firmware: arm,scmi: support system
 power protocol
Thread-Topic: [PATCH RESEND] dt-bindings: firmware: arm,scmi: support system
 power protocol
Thread-Index: AQHayQZ1IfM9c75gwUa881/OgdwbCrHmazqAgAAAwWCAFhnOYIAALGYAgBbJCgA=
Date: Fri, 2 Aug 2024 02:51:10 +0000
Message-ID:
 <DB9PR04MB84619D581E540351FBA73ECD88B32@DB9PR04MB8461.eurprd04.prod.outlook.com>
References: <20240628030309.1162012-1-peng.fan@oss.nxp.com>
 <ZoZ8Mxjv9cIzivtk@bogus>
 <AM6PR04MB59419639315434DBFF2F13B688DE2@AM6PR04MB5941.eurprd04.prod.outlook.com>
 <PAXPR04MB8459EB8FC25AFF6D7C912F2A88AC2@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <ZpksMAYaAkemr9dd@bogus>
In-Reply-To: <ZpksMAYaAkemr9dd@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB8461:EE_|PA4PR04MB7536:EE_
x-ms-office365-filtering-correlation-id: d2ac9bef-cf06-4932-6f9b-08dcb29df7c1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?QofG6I1nplu1dgLFWmrk29ORIXBa3Q/FWJZgwfoMikRwWCneMvV0ENZo8v20?=
 =?us-ascii?Q?VHrS49I2eLojEDZq/2sfM+EmljiLcpRsDiE28GV9/zIWU4zGWP40Tzb2xg0f?=
 =?us-ascii?Q?sUAym4AKinI+6fE/FJTdMtV/25yaedRo7wiK1N9A0Hae/pIGImNsMO6wgeCC?=
 =?us-ascii?Q?EEbVDvfLokC3BOB/UHjZMpcWKDjliHgTYmfC5vgCS57HfNePimqsN+JhkMIM?=
 =?us-ascii?Q?j+g1piGLtDHaHlIff2gmigLbVJmfjgJR/Gpo2h35Cf4pz4cYgyI4YUPUh1g9?=
 =?us-ascii?Q?50Ef9DcUbWa+LLX3PildbKS/vhdBRi3jpfWWhvKCsEXMdBuNTiEyzRvcWTMU?=
 =?us-ascii?Q?IuFFdbVNzZkAjA9rLodRn8DZO+8tYAG3+dnGpte9Ioz+nhy3jAuuVk4Kz2eZ?=
 =?us-ascii?Q?PTAKAGmOBgdc4bGVy2wZdOEY5/DSmz6FCID1QMh4BwC4/U4VhZOq5oI9wk1m?=
 =?us-ascii?Q?MfvF17+G+lkWcnarv29zBe9ea2Y+LbJEDtWDlNdUXmKXErFeiFsNCcwNUV9J?=
 =?us-ascii?Q?zOA4JJJz95G+1cg2YR7PszJ9IK2GLOQQh0LJh9Xi6a2O4SOWiqtMyL2P7DTO?=
 =?us-ascii?Q?j6EhQ2+RN84EFtxdf9/SEV8Jwk0BVsxrlITEfAErctx1fLVQV33U+c1eEWP+?=
 =?us-ascii?Q?/7RgOQjM7hu9gYRefu1Re46pW03vfQVcM+QwSulThTDQPsFeV0B7H23wfOgo?=
 =?us-ascii?Q?TqXwfxpdWc6pPE0Wtvy6f9hC400tqo/mMAtANj8QMq87OfJNUh3prC7ldOy1?=
 =?us-ascii?Q?0fiRXC5nZK57U9QIupoSOfIgESRrTZWmiJr5itqYSdOrjdy9DxD/st+lhDES?=
 =?us-ascii?Q?5D1VbUR/VjJdOYud/0T9pe0dajhn4Ks/LNsNFdz/B2BRk+jDB9HulXRrSRIh?=
 =?us-ascii?Q?MKRdl5thmbus0Xj6oWybo+1Jg54mlVaxVymT4u/OHsIqpMvGdqVq7wDQtZip?=
 =?us-ascii?Q?oG7k6W47CyxLO4NVjERuEJhggdjPz36+Obhkj/YtuO0VZoJWWihnlOBjtbuz?=
 =?us-ascii?Q?F12poOdaXYvyALe/mvExxYjo3cgYNb4phsmn/qgkH2Xr2MctYxt3m3SaP0EB?=
 =?us-ascii?Q?b+XvH2UasRsppnhnLJsh6ZqSkuhv0dke3FCPnOAJ4afFLGkqyATMy25nT+YO?=
 =?us-ascii?Q?ISN8FrbV4AKiEuMvyZfUAL10GTgV72eV/LDN17GtItrdcgZEwQLnIi2xNfdE?=
 =?us-ascii?Q?atOxMG5Zb3KxRpR7ODpZkc4f62G4v5m0P8+xE3DElLM0w+6n383DYENje2VK?=
 =?us-ascii?Q?UNmETbmGWVgOMyLQl1Wg8pHEtqzUa1YTZ+wtN34L/+wWrYwFbT1UUOkjrose?=
 =?us-ascii?Q?hgl4xde6VP6DNHkyUmlrtpr73mgylvZk7Fw9pldVAmPgzffFhNQ+KfCFtplx?=
 =?us-ascii?Q?kRXzszw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8461.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?DRfYeIoH8V25qGfJLan+m/p7DU5CB/+0YnMO8iS4GExgYkdcG8r+TTggaREJ?=
 =?us-ascii?Q?McXqnLjEPNN9BbgpaVAvVWBeGRCG/ITSSlNFioR1XxGyLIlk6CM1bO726zoK?=
 =?us-ascii?Q?ygn6y5qQgdtIKB743hHQG5iZSuU7dyBuXIPH4Kp0Ch73ozQ5GgVWt9BslhNV?=
 =?us-ascii?Q?5oRHLIQZ6JXFdnWkikydSh4U8kd5UJ2BW9ZlLXdj0KjlPAPO4+QiGnMrKGEe?=
 =?us-ascii?Q?t1VtEiOylIr002MP69iojNUkEPk5PW8LNj1GFZEnxuWYBEt0Qw3v7VQkTIHB?=
 =?us-ascii?Q?UbLTLr4wsxb+oal7aYZSli3AfJw4awS7JpeK6rrw2OHkqi3YLuhge3Yf88+S?=
 =?us-ascii?Q?m1lACeoQ8HkTN2SsHM1vaaCqoF32mjAhyCOWbhDcqlgfNaXtv3I8B9rcYiXL?=
 =?us-ascii?Q?5NgqpUO5/pOtq6AGp1aBO0oTFmVo9Fbr1EV2/CwZTeoS9A0jAZOTYa1k3ihs?=
 =?us-ascii?Q?+VZOur2jgF91n8f4upr+w4JVAZ707tQXoGHdUNDq0l1iZBz7Rj9Bh37iX5GX?=
 =?us-ascii?Q?VvmuSNuha3UaZ8q3UKMxAhNZ/oWx1TFpK1gEvwsLG7ZU/jXBu4eRYlQmI/WF?=
 =?us-ascii?Q?bnZ/ORoCw+GhZ1cjtC/26wRwZr9tEM5kwZiWCtjI0wAK21HGtXe42uug8hFr?=
 =?us-ascii?Q?qdg1kwTLvZa6VwuAmrY6rw7ukxe9EkVBQlqjKsbzfJXT1Ri6thxS2bmtVswN?=
 =?us-ascii?Q?3ELVNuLa3Ht9yJ67JEqm9hZu8oHohzGMfEgq/MntgDLrfp/V+uaLDec/XcXC?=
 =?us-ascii?Q?0gbND15BHeKaEiA/SQU8IGl4wURkwYAe36Ik1Ekyde38r/25PdT6Yqa+T8ff?=
 =?us-ascii?Q?QJSGu2cmS9UnG3zIwVgL7EG/UKSHKornXG/qGakWewFnsvHQSVGGxpLnS51I?=
 =?us-ascii?Q?FRP2ljBCYci2NZdkP3t28RCeNazHcgB2SJtM8qLiYSoVvx36LE6M8jToGZuV?=
 =?us-ascii?Q?RMUUAb0Fh9KTyqDm6pVdJu9EcINl9gc0gEA0oWubkvJwS2S9z/svW0kva9c8?=
 =?us-ascii?Q?Iu3rci7dvh+IShWcNeTRW60mvZUdq6WjsKfX5Vccgye5n1JpadHz5tysJtyE?=
 =?us-ascii?Q?mOBmjQwVcMafLJz5v9TXU2jEyd9V57MrYtFmj47LC2vbyHzZK4R84fJl9RGW?=
 =?us-ascii?Q?zTAvK7x7UatM3is2Bu5QHmLj5nJOubwDCN9NknROvpFKLRLgHXUOt3GmjCr/?=
 =?us-ascii?Q?tzBBfk+8XEVtcTqgmKS6yZ6B3zC+6iw8qX0hH2ahf5YO8v8lt8AZE91fZPxR?=
 =?us-ascii?Q?3rW9SEEDKugpvVHSf1fgwQ62mY6uVzyQZfzOSPbUKMK1lDfw9gYKz+siLvwT?=
 =?us-ascii?Q?QpZNpSiXv3X/HR1BzjIMLGxxysPfNRCPQqvhdNo6Rj2m9MjwXuPSFPx3La4v?=
 =?us-ascii?Q?fUUZOljX8AydXT04MyqdRF4+ZwqxrEtm04sGbnBL/hY5LF0Iy1cbfffa3KRD?=
 =?us-ascii?Q?swDaG3pveZcP/XKeKB3uqix+3WOjIwIcjqkfMOb1hkAjrFsAhvMvpWeBA59X?=
 =?us-ascii?Q?RISwDB7fqS5e+hOACSAxRmieGcFIlXaH+S9AEp/zHWZuhKT5Vj2XeJevjl+K?=
 =?us-ascii?Q?qUc195VvAP9dBXWX54g=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d2ac9bef-cf06-4932-6f9b-08dcb29df7c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2024 02:51:11.6005
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bXuoLjLdba99ne+JY15yLy0EsR86Q4uvgWCjwALIQVgmamKydh1CPwarAPrJjr1lwh3eHSebUf0dUIrfMBDEGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7536

Hi Sudeep, Cristian,

> Subject: Re: [PATCH RESEND] dt-bindings: firmware: arm,scmi: support
> system power protocol
>=20
> On Thu, Jul 18, 2024 at 12:15:20PM +0000, Peng Fan wrote:
> > Hi Sudeep,
> >
> > > Subject: RE: [PATCH RESEND] dt-bindings: firmware: arm,scmi:
> support
> > > system power protocol
> > >
> > > > Subject: Re: [PATCH RESEND] dt-bindings: firmware: arm,scmi:
> > > support
> > > > system power protocol
> > > >
> > > > On Fri, Jun 28, 2024 at 11:03:09AM +0800, Peng Fan (OSS) wrote:
> > > > > From: Peng Fan <peng.fan@nxp.com>
> > > > >
> > > > > Add SCMI System Power Protocol bindings, and the protocol id
> is
> > > > 0x12.
> > > > >
> > > >
> > > > I think we must have this node only if it has dedicated channel or
> > > > any other required property.
> > >
> > > I posted a patchset to support nodes not in device tree. And
> > > Cristian gave some comments:
> > > https://lore.kernel.org/all/Znv1p3FDiPSUNmBM@pluto/
> > >
> >
> > Please suggest what should I do to avoid the dtbs_check issue.
> >
> > Should I switch back to
> > https://lore.kernel.org/all/Znv1p3FDiPSUNmBM@pluto/
> > or else?
> >
>=20
> Sorry I need to discuss with Cristain and decide. I might have already
> discussed but I can't recall the details or decision(if any) made after
> that. He is away now, will get back once we discuss and see what is the
> best approach.
>=20

Do you have any update on this?

Thanks,
Peng.

> --
> Regards,
> Sudeep

