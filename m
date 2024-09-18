Return-Path: <linux-kernel+bounces-332904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A46B97C06D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 21:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED378B220EC
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 19:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886001CB31B;
	Wed, 18 Sep 2024 19:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CMjvgXTr"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204D91CA68A;
	Wed, 18 Sep 2024 19:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726687372; cv=fail; b=OTAcbhTWYWnzrzzd41XHARAY+2j/slUSQO6dLBpyuC+iYizHudiumjBM/vWtHZezIVpgcBFECcYX9LaRuDROJ0wvFe2i62IbPsxv16QuqlXwlwaO77oGHocsXuWi9/Z45yT1KxpHKUaNMmIZdzbWaX5gNP/t01xpkb7s/txCOAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726687372; c=relaxed/simple;
	bh=NDAageeAe3vuPllk3OnCB16zyUuEgS94ZYP0/R2/5hw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oNs0T22xixUCeDjZm8d+yNE9Pr4Ff5zfpfShPYRzXdW5k0+jjPv7Eko1Hekod+pxdbETV7IFN+WYnpSeNqpAAHs+K1qiveZ7gDdtV24T9Pz1GsUkyFkUSVDW8Zc0xgDXa4pk8s9qO2LGwu09Zm3XyiX/jfjN/WdbEvNaHZRQIfI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CMjvgXTr; arc=fail smtp.client-ip=40.107.93.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VEp1Dy7ZBDoT3kF2lLtIwmNrOVsOGNbnouXfy73Orvjb2+R9sl8qoqhVhT98MLoD8hw0MnzSBdA2+WK8Us+QnHej8GRGbWYpAMrerq6+JCpN6NzQ9MMdqin51FVGJFigoest7CV6/SHThPncXvIj5V0rm5ZYicQRp8DA7/O0H4zx9Vk4+tzpCow07dnciRuk+1+uQhYQld+nN1b8wtCxjmnZnAAQiC4LJA1Dq6U6bTvcLsqE8rWihGSGs9nmnZOgZfZiMDbrgVjxpKr+91yPOgiN2hsobGws/SCtBeKzGrM7yyQxUjqEbhuR37ZsJCUU4laHSthJ93TwPDlqW4X1Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ytcV74UW8b9HclyQJZPIH7iaAisv3dBMhr1ljZcukTg=;
 b=zS8BtZa8XWKMPtIDwRx3oZmP+ZPxVo7yomPFJ4lkjrDBrOHQqLUNbQtta8cuLt2gEgpG+f8lz9usucJEyBJihi2amy+RVNNxalLsC8IKdBz2rNr89Bu4Y9L/3FSh9X1gJo/UVbvQuQOcLphbsiIEvRTL6q3mNT0nO3LlysLlSUiZMuFb0BjZqexu90FbZsOzq/x8YHvIP8N0NA0QL+htgQNK+45tbMzQdrIWQs/CxGs0OeuYIPZdNgfkgQ+x7ggUkBPDTYUliTY9xSlEPRhJvMJKcgTstNwl42ivh4yx0j4/wrRbdrqj+Bl7yzAuCdFyYjxRcUG5CP0/BWfst6gx+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ytcV74UW8b9HclyQJZPIH7iaAisv3dBMhr1ljZcukTg=;
 b=CMjvgXTrMKfcHQgs2qgJ7KRwWN36cSZ+b/FzzXOlsOjnt1SFROAFGo1wOEBVAk4C9DArvjX16URLVPjT9oc6KXUspvDtYCFg8rzCl5mq4uaW2V+zXxwogE0ddrVtchR2cyCYtC1AUqEAUImQlsL9sDtSVMzbtacJeUm13axs6g4=
Received: from MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15)
 by PH7PR12MB5781.namprd12.prod.outlook.com (2603:10b6:510:1d0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Wed, 18 Sep
 2024 19:22:43 +0000
Received: from MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::6798:13c6:d7ba:e01c]) by MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::6798:13c6:d7ba:e01c%5]) with mapi id 15.20.7962.022; Wed, 18 Sep 2024
 19:22:42 +0000
From: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
To: Matthias Kaehlcke <matthias@kaehlcke.net>
CC: Greg KH <gregkh@linuxfoundation.org>, "mka@chromium.org"
	<mka@chromium.org>, "sakari.ailus@linux.intel.com"
	<sakari.ailus@linux.intel.com>, "wentong.wu@intel.com"
	<wentong.wu@intel.com>, "javier.carrasco@wolfvision.net"
	<javier.carrasco@wolfvision.net>, "stefan.eichenberger@toradex.com"
	<stefan.eichenberger@toradex.com>, "francesco.dolcini@toradex.com"
	<francesco.dolcini@toradex.com>, "jbrunet@baylibre.com"
	<jbrunet@baylibre.com>, "macpaul.lin@mediatek.com"
	<macpaul.lin@mediatek.com>, "frieder.schrempf@kontron.de"
	<frieder.schrempf@kontron.de>, "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "git (AMD-Xilinx)" <git@amd.com>
Subject: RE: [PATCH v4 2/2] usb: misc: onboard_usb_dev: add Microchip usb5744
 SMBus programming support
Thread-Topic: [PATCH v4 2/2] usb: misc: onboard_usb_dev: add Microchip usb5744
 SMBus programming support
Thread-Index: AQHa/GfAyUa3qy9nHUmC7/PR5nbk5rJFn4QAgAAB7ECAGEAjAIAAH2nQ
Date: Wed, 18 Sep 2024 19:22:42 +0000
Message-ID:
 <MN0PR12MB5953A5341E4E17A08FABCEFDB7622@MN0PR12MB5953.namprd12.prod.outlook.com>
References: <1725192519-3867920-1-git-send-email-radhey.shyam.pandey@amd.com>
 <1725192519-3867920-3-git-send-email-radhey.shyam.pandey@amd.com>
 <2024090312-stool-ergonomic-f2fe@gregkh>
 <MN0PR12MB5953AD101E185462A6CC61BBB7932@MN0PR12MB5953.namprd12.prod.outlook.com>
 <cnzcqfkqrrs5jv3asmyw54ee2wtztxufariwtj2cjsexuzt7th@fh4htlnlmyae>
In-Reply-To: <cnzcqfkqrrs5jv3asmyw54ee2wtztxufariwtj2cjsexuzt7th@fh4htlnlmyae>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB5953:EE_|PH7PR12MB5781:EE_
x-ms-office365-filtering-correlation-id: 855138ff-dbaa-4854-0bfc-08dcd8174468
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?oF0h2YXzqZIlrZVjHwZEfOx83kfXuXr5lY66x1qI2g4P2Asl6/FM/eSy09kJ?=
 =?us-ascii?Q?4zNTA+qGohzSlAudsU97DaIP0AM85GvZQnN3eEyABsY+cBG33YFuNGMWRmHm?=
 =?us-ascii?Q?7beSJhAEoftHI0DG9aUbjKYc8zR0x7L7yCfBdrPXRGEYwBrzi4ctVyDgLo+O?=
 =?us-ascii?Q?0y80ZQFRpxWvep+k4BpSY9qjEGXl1ElnPujoAn+MPjHqan6k5+UIIjo7+yag?=
 =?us-ascii?Q?VJVu0lM7l7Kl66mVy04kq0VJPfC1Psg8UV62Sv/ttm2pgc/1Exlh453/8Trv?=
 =?us-ascii?Q?/G6rxeHXRucx6ik+FFVM3WgdhgOHNKz6gA8qKboeYdjixwMzR5N6+yGqIXYE?=
 =?us-ascii?Q?3S7utEtVNc9mwSmW7xC0sQ78ecdMS9bPMMxnUiZXGR5hZvf4BoQfFArceTQa?=
 =?us-ascii?Q?QBaJQozOUrKZGyq4CeIGpbty18z/MZFRBwu+ZdfUB5FQmG28uj5W5Ok7XYGK?=
 =?us-ascii?Q?gvckptzxtxPVVPBnjoC5456flebJQ8O4MHFgXZ39QG/V3iXHw0oqCrhcJd0W?=
 =?us-ascii?Q?kMrBr7xm2XK8Txq92t62BeRvzoC9mPugKB5CKAdtla025vqM+J8oQ4lEJhoM?=
 =?us-ascii?Q?xPg6SaUPERhvxLs/v7kFQwPOecXczB1tWH3vECWxX+ebojCbxz/qmEuE4mNc?=
 =?us-ascii?Q?bscThJ8sh5poL8EXgLEVmAjttpmq0yFrSFG4wLmBra4GHhCVYXnZr8UyqQbU?=
 =?us-ascii?Q?gvO7SOehypPOlY8yUHsXbm5qh3maA0koPFVQSW+a+zrIfXRLFadK+6e3gXgq?=
 =?us-ascii?Q?I9wLahQAjO6RpHSBfyRziI4B2LxJp4plj4ALLa+xe8yJeNEeS0k1soBruKqL?=
 =?us-ascii?Q?dBYG3UuY5E1Kuv7lJXvhY5b3bQeEX1QEOUxTWbqO+zWxI2QYPKXkuF/NZXEa?=
 =?us-ascii?Q?OpueWAPhSAFGCNb9yROWXFK6+sG908jK0I8UGGRDCBexQksUPhReDDaCajeQ?=
 =?us-ascii?Q?8w2HejrmOeff2pbVomzfGM08nDsOoR5+VrqPmvuQ4K2xOCgDIsNmskA86lQB?=
 =?us-ascii?Q?XOLekaF1aygQQKbCSSLSIr7MJ1JIgR4OKYEYATESuw0VJSCkjoz9w7ld1SY9?=
 =?us-ascii?Q?tsPH6G/ioZcOKuLbnZoA+zoQl0HEBUunpp1mjse9wuqjKWSskW8P2ZIAYfYc?=
 =?us-ascii?Q?0u6/AXUfYhqLXZXZeCTJj0U1mleoTB+zp63p43PmI+qAtlKPso5f4SorHrst?=
 =?us-ascii?Q?ZauHH0lPSt6Qj6IuiMiFer91pFVOnm6ND8akZ3oebazQxuTCbjJ5utKZNxN3?=
 =?us-ascii?Q?2UChjfF9EVb1mgSRujKO5g9fw8FSWYK/h5ZFgTPdG+jj2fk0fUNc2y7C5/QA?=
 =?us-ascii?Q?ZMoqjssodjJYQEmNAxvB6OPGS9nG0e1/5fPTzivDKUfureJMhv7LsZeK3m/o?=
 =?us-ascii?Q?BMpIHiNiiVNBSPPqnLONf0Qr+HGj/VPS8OTsNUOARbzFnetL8w=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?/38b7xftMUT70Bb7+AZKfI3eh0jJTOis/riejeDairNrF+Qr3NWfBgiaqTvB?=
 =?us-ascii?Q?l79diRP0Bg415wy/hgNbIzQcmW/ICTO8+vav9ZPL3R1BZNOaQHulmpCwyStb?=
 =?us-ascii?Q?V8fyGRPWppDceTXJhRfPGj1lpHFyFU7iBtb9wmrajU/VU4glUDq8MhC91XIP?=
 =?us-ascii?Q?1E6d9T7kmK8MrXc9hyz/iKwwvIpoy+8FWRk5bsX35dJkOrUpAvYZ72cQlbOv?=
 =?us-ascii?Q?MiBEgSiDpuEp+t/Z1/niUcntuyFi6h9L96iRAvrXZQZXfqRMwbW1oBRj3MIG?=
 =?us-ascii?Q?VLZjH5AP6a0TxPvmAeU+yVfHdslInqCldI9OoZX339MFvOsXxC7V7O0REyTx?=
 =?us-ascii?Q?HSWPpZqdSSqnxJzzEfhoevBO3VMrrPRXXcx7mnvQ3rYPeiftLZ9nPC46YW1O?=
 =?us-ascii?Q?beJq6RrZ+w3vfUrfIBoGcwz9PiiQXZSFnoo0VcPyG0T/dYqMGidR8Gxf/yka?=
 =?us-ascii?Q?kJjR1ZOPgc9oR0+pZOLDibixroI8ErGXuTub44m5joLLakOk0Yi9UcQ3FXiW?=
 =?us-ascii?Q?/9jliuMt1RccC7rwfKLU69F1lLWB4v25uRNlgEWfYnzIIhFJBjbgd2N2eMUq?=
 =?us-ascii?Q?t4sbe1PbG2BN22JOpy0tqAaicbS8VH53dXTdDTOAxxhfh/0jiVmLuZw7By7v?=
 =?us-ascii?Q?VQSMmu4EMYpu9JeCkLLHPKlfNiZ7mBYjJvs719tgkqWbMAYg5bphL5xtFwYc?=
 =?us-ascii?Q?oeKYARA768cBS+4Cfad+3KsRDU8olVWbYfq/Mbd9wzhyD716gBCnS6hNxhOd?=
 =?us-ascii?Q?Rcb6N3NWDxprDGftw1wTI6BOLRGoqr8Yumpe6VY7AGFM45yc9vvLBwuk73vl?=
 =?us-ascii?Q?BMkW9/8efSzDy42vht19YFktP8gLSMq+3RGobY5js2CLsJCCzkld7+MUBUht?=
 =?us-ascii?Q?mGX3hPFZ68M1kylsBjSc2SUjNN7r8ASYhsxt7+Yl+sMZr2Xx/wSny8KX62/w?=
 =?us-ascii?Q?SgA1QJc9FoUF1MHeitTvm2cesVDXDXquplJ1IL/xFy3fvMokNndTbLSX/xPt?=
 =?us-ascii?Q?ZU/R0H1mZoMamNJ+sVy2PnXj7qyM9jC5caojVUKHcacyKTGr/x8IXwDpsKqJ?=
 =?us-ascii?Q?xkjwJzqIxzlKiC4cfh+0brme9j40skueVKQiXYT+eAIpzLA+ZSKqtpOs3s1X?=
 =?us-ascii?Q?WCkJmkD/pVR07rE5NXtURWwxtTD7nM66BvfUgJO7SrzYwFFfrL8M1nHTGYYc?=
 =?us-ascii?Q?nCiLKHPEcljRIlTvT/9n1XaEUhJe6cS2ZckcDMXovBRN0CN6+3R/jH/k46sh?=
 =?us-ascii?Q?xk6A8GbuEFmw3g9QPFJF5/lHUqDvpNFN0CeBgU4ClH0uK0fyCvg4/kbQ5s5y?=
 =?us-ascii?Q?8S1FTpbGEAGYhpBgISWa6bLQ1GKrUtZbsy2GN2EYW1NMoZUEjeBVcrftOu7B?=
 =?us-ascii?Q?tXgD90RpZOWHbR/MeaKhVwWb7iFMNMbJusWeniNCPrUfpbrwyj3K65nJkqAl?=
 =?us-ascii?Q?gGrq05IZU1Jnsxh+Twt1DsXMC74k0Eg4fId53iOOterQarWshAROgkR0LCX/?=
 =?us-ascii?Q?1FwthVPKIEYtLFvnX6Ye9L/JV7C/9p2VMj1WIfm4+bwYKv3RkAN42sOmZA6q?=
 =?us-ascii?Q?w41J/n5yLkQlAVtSMDA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5953.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 855138ff-dbaa-4854-0bfc-08dcd8174468
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2024 19:22:42.2773
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gI3phLOn6rF6hCwdo3Vnr0K48vJokd9AbsO3ByVh2fxNmLAAI23e90oHpfMl+ATP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5781

> -----Original Message-----
> From: Matthias Kaehlcke <matthias@kaehlcke.net>
> Sent: Wednesday, September 18, 2024 10:37 PM
> To: Pandey, Radhey Shyam <radhey.shyam.pandey@amd.com>
> Cc: Greg KH <gregkh@linuxfoundation.org>; mka@chromium.org;
> sakari.ailus@linux.intel.com; wentong.wu@intel.com;
> javier.carrasco@wolfvision.net; stefan.eichenberger@toradex.com;
> francesco.dolcini@toradex.com; jbrunet@baylibre.com; macpaul.lin@mediatek=
.com;
> frieder.schrempf@kontron.de; linux-usb@vger.kernel.org; linux-
> kernel@vger.kernel.org; git (AMD-Xilinx) <git@amd.com>
> Subject: Re: [PATCH v4 2/2] usb: misc: onboard_usb_dev: add Microchip usb=
5744
> SMBus programming support
>=20
> El Tue, Sep 03, 2024 at 07:19:09AM GMT Pandey, Radhey Shyam ha dit:
>=20
> > > -----Original Message-----
> > > From: Greg KH <gregkh@linuxfoundation.org>
> > > Sent: Tuesday, September 3, 2024 12:10 PM
> > > To: Pandey, Radhey Shyam <radhey.shyam.pandey@amd.com>
> > > Cc: mka@chromium.org; sakari.ailus@linux.intel.com;
> > > wentong.wu@intel.com; javier.carrasco@wolfvision.net;
> > > stefan.eichenberger@toradex.com; francesco.dolcini@toradex.com;
> > > jbrunet@baylibre.com; macpaul.lin@mediatek.com;
> > > frieder.schrempf@kontron.de; linux-usb@vger.kernel.org; linux-
> > > kernel@vger.kernel.org; git (AMD-Xilinx) <git@amd.com>
> > > Subject: Re: [PATCH v4 2/2] usb: misc: onboard_usb_dev: add
> > > Microchip
> > > usb5744 SMBus programming support
> > >
> > > On Sun, Sep 01, 2024 at 05:38:39PM +0530, Radhey Shyam Pandey wrote:
> > > > usb5744 supports SMBus Configuration and it may be configured via
> > > > the SMBus slave interface during the hub start-up configuration sta=
ge.
> > > >
> > > > To program it driver uses i2c-bus phandle (added in commit
> > > > '02be19e914b8
> > > > dt-bindings: usb: Add support for Microchip usb5744 hub
> > > > controller') to get i2c client device and then based on usb5744
> > > > compatible check calls
> > > > usb5744 i2c default initialization sequence.
> > > >
> > > > Apart from the USB command attach, prevent the hub from suspend.
> > > > when the USB Attach with SMBus (0xAA56) command is issued to the
> > > > hub, the hub is getting enumerated and then it puts in a suspend mo=
de.
> > > > This causes the hub to NAK any SMBus access made by the SMBus
> > > > Master during this period and not able to see the hub's slave
> > > > address while running the "i2c probe" command.
> > > >
> > > > Prevent the MCU from putting the HUB in suspend mode through
> > > > register write. The BYPASS_UDC_SUSPEND bit (Bit 3) of the
> > > > RuntimeFlags2 register at address 0x411D controls this aspect of
> > > > the hub. The BYPASS_UDC_SUSPEND bit in register 0x411Dh must be
> > > > set to ensure that
> > > the
> > > > MCU is always enabled and ready to respond to SMBus runtime
> > > commands.
> > > > This register needs to be written before the USB attach command is =
issued.
> > > >
> > > > The byte sequence is as follows:
> > > > Slave addr: 0x2d           00 00 05 00 01 41 1D 08
> > > > Slave addr: 0x2d           99 37 00
> > > > Slave addr: 0x2d           AA 56 00
> > > >
> > > > Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> > > > ---
> > > > Changes for v4:
> > > > - Fix error: implicit declaration of function 'i2c_smbus_*' APIs by
> > > >   introducing a dependency on I2C_CONFIG. This error is reported
> > > >   by kernel test on v3 series and usb:usb-testing 20/25 branch.
> > > >   https://lore.kernel.org/all/2024082503-uncoated-chaperone-
> > > 7f70@gregkh
> > > >
> > > > Changes for v3:
> > > > - Add comment for UDC suspend sequence.
> > > > - Drop USB5744_CREG_MEM_NBYTES and USB5744_CREG_NBYTES
> and
> > > replace
> > > >   it with literal + comment.
> > > > - Move microchip defines to source file.
> > > >
> > > > Changes for v2:
> > > > - Move power on reset delay to separate patch.
> > > > - Switch to compatible based check for calling usb5755
> > > >   onboard_dev_5744_i2c_init(). This is done to make
> > > >   onboard_dev_5744_i2c_init() as static.
> > > > - Fix subsystem "usb: misc: onboard_usb_dev:..."
> > > > - Use #define for different register bits instead of magic values.
> > > > - Use err_power_off label name.
> > > > - Modified commit description to be in sync with v2 changes.
> > > > ---
> > > >  drivers/usb/misc/Kconfig           |  2 +-
> > > >  drivers/usb/misc/onboard_usb_dev.c | 73
> > > ++++++++++++++++++++++++++++++
> > > >  2 files changed, 74 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/usb/misc/Kconfig b/drivers/usb/misc/Kconfig
> > > > index 50b86d531701..cb5e47d439ab 100644
> > > > --- a/drivers/usb/misc/Kconfig
> > > > +++ b/drivers/usb/misc/Kconfig
> > > > @@ -318,7 +318,7 @@ config BRCM_USB_PINMAP
> > > >
> > > >  config USB_ONBOARD_DEV
> > > >  	tristate "Onboard USB device support"
> > > > -	depends on OF
> > > > +	depends on OF && I2C
> > >
> > > This feels wrong.
> > >
> > > While a single device that this driver supports might need i2c, not
> > > all of the devices do, so you have the potential to drag in a bunch
> > > of code here for devices that do not have/need i2c at all, right?
> > >
> > > Any way to "split this out" into a smaller chunk?  Or better yet,
> > > just detect at runtime if you need/want to call those i2c functions
> > > (and they should have no-ops for when i2c is not enabled, right?)
> >
> > In onboard driver I am calling onboard_dev_5744_i2c_init() by
> > detecting at runtime if "i2c-bus" phandle is present. But the problem
> > is i2c_smbus_* APIs are declared and defined only for #if
> > IS_ENABLED(CONFIG_I2C).
> >
> > Do you think we should implement no-ops for I2C smbus APIs (in
> > linux/i2c.h)? OR a simpler alternative would be to add #if
> > IS_ENABLED(CONFIG_I2C) check in the onboard_*_i2c_init() and return
> > error code if CONFIG_I2C is not defined ?
> > Did a grep on #if IS_ENABLED(CONFIG_I2C) and find couple of drivers
> > using this approach.
>=20
> I expect using IS_ENABLED(CONFIG_I2C) would cause issues when
> USB_ONBOARD_DEV=3Dy and CONFIG_I2C=3Dm.
>=20
> Another option could be adding an option USB_ONBOARD_DEV_USB5744 (or
> similar) and make that dependent on CONFIG_I2C.

Yes, theoretically this can also be valid build configuration.

I assume your suggestion is something like below:

+config USB_ONBOARD_DEV_USB5744
+       tristate "Onboard USB Microchip usb5744 hub with SMBus support"
+       depends on USB_ONBOARD_DEV && I2C
+       help
+         Say Y here if you want to support onboard USB Microchip usb5744
+         hub that requires SMBus initialization.
diff --git a/drivers/usb/misc/onboard_usb_dev.c b/drivers/usb/misc/onboard_=
usb_dev.c
index 560591e02d6a..6169780a18d9 100644
--- a/drivers/usb/misc/onboard_usb_dev.c
+++ b/drivers/usb/misc/onboard_usb_dev.c
@@ -311,7 +311,7 @@ static void onboard_dev_attach_usb_driver(struct work_s=
truct *work)

 static int onboard_dev_5744_i2c_init(struct i2c_client *client)
 {
-#if IS_ENABLED(CONFIG_I2C)
+#if IS_ENABLED(CONFIG_USB_ONBOARD_DEV_USB5744)


<*>   Onboard USB device support                                           =
                   =20
  <M>     Onboard USB Microchip usb5744 hub with SMBus support


Here IS_ENABLED will report true either onboard usb5744 is module/in-built.
So, we hit same issue as USB_ONBOARD_DEV=3Dy and I2C=3Dm.

FYI, as this series merged to -next based on our discussion I will send ano=
ther
series fixing this particular build configuration and other coding style ch=
anges
based on v4 review comments.

Thanks,
Radhey


