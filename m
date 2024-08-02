Return-Path: <linux-kernel+bounces-273215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87FC79465E1
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 00:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E1502817D1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 22:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91B8130A5C;
	Fri,  2 Aug 2024 22:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="YevluH3c"
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11020101.outbound.protection.outlook.com [52.101.56.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601201757D
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 22:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722637425; cv=fail; b=TYFDoDT+b8fvgSWronSW0EyBvtbdqzjXn4B1eSaia/NO24r7ZjJ07wdLj0AFk0EsUJBHsNiAPwNYEyPd/+mM3dYvVY7vQyJ6e/tzcKuz9vnTGMhU/ReIMLxsPIqSloj1y6wnWJ9reYxL8/eYNjDeTnAPHc255t+CbWeHpJaBQVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722637425; c=relaxed/simple;
	bh=8gOHz9DJ1zRtJp59sQRwLYGAizbNvdcWqYLIRWlFQQc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HrvEzFtHOABawdJzzlJVDk+PIm/Z9CxZpasvO21WO1tSD8BcFPt/+iKFOWk2HQnD4YonPGJG1yLcP/NlMTGJcZBZ/zk1Kh2rNsX1x7tvVHlNTyMZV8x4ugzJpcfTn/I5/Ny/J2cSqWGMgo+HppDRQ0RqpodE427oUZhi0GZ3EX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=YevluH3c; arc=fail smtp.client-ip=52.101.56.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sci1f/stPV48LNK411oACUBHhCcDs2vWnxEepSSglYlCvV8c6Y7hxJEJe0jGh9P2UhmW5g4CuInehD3tYszwLFkCpZmdaUeVGhroVWcByXZ2H55fDeRYB8P+Te06ymfqiSdqj00cZRutAYuRV686nbH0OLblbaN8dP2tD5e4UbYWY6i6kdkzF4Sw9ROdNM8/oaX0QVkoqXcPmMaaeZJmr7VpZk/AlZNFKXPnAAr27B+PcPNfWaM2nbo7h6rnLZMVZCJ/BvTEYkZaMxOXKUs1NBiZrxT/m0TCxO1lKhrcSpkZn5fQfxLoa5kZEXWO/b4X0JThW8qMD3McUwGe8Tg96Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=37XzI2iB/fyH2DMy3WiTVstz76ZMJ2FJqHcsjI8y0v8=;
 b=bZzo9RipF5i7zsBsw1KWtCx1zjSx+SiAS5JHhmyjcfaChvmao8VENaqsiZ7315QD8EOkOghE3Wzm8W5/iPqOP8sSVGPye7UQ33GNhkbMbYBq/cR194gUX/Y74qEcafv7y9X4soZFJp2U388HUvzNJd8cD3hCfEvrILxNKTcunzxyIqAKRtE7Sv2KGZdSmmr8qBFjBtmmjoUIaIOSfXRQNFhCY/uOhq48y/8q/qTUZyFGqNe/E3TC6/7PwZnq+qCXbLT6LnXHUAn6dyd2G7KwZ5aMbM1+qnQ1MqoHzUIHfKNROaY20VKjhmi1AdWDeAxE/N5z8hj7VHn/02hrlEoV5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=37XzI2iB/fyH2DMy3WiTVstz76ZMJ2FJqHcsjI8y0v8=;
 b=YevluH3cmNXai09wAg3D08E2hnxbMBFoNqGeX4s6ksHrST2YV4m3PinZifmVKg5DsqhLrnOO8i4BqVPcGVj06SCmJHrUmIV+MQTnt9eQmVVu4wpL1Er7wHG695oktXc08J86YMSruv16WcEwryX2FgUFueV+18/I2qK02CrgExs=
Received: from SA1PR21MB1317.namprd21.prod.outlook.com (2603:10b6:806:1f0::9)
 by BY1PR21MB4395.namprd21.prod.outlook.com (2603:10b6:a03:5c0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.5; Fri, 2 Aug
 2024 22:23:40 +0000
Received: from SA1PR21MB1317.namprd21.prod.outlook.com
 ([fe80::67ed:774d:42d4:f6ef]) by SA1PR21MB1317.namprd21.prod.outlook.com
 ([fe80::67ed:774d:42d4:f6ef%7]) with mapi id 15.20.7849.008; Fri, 2 Aug 2024
 22:23:40 +0000
From: Dexuan Cui <decui@microsoft.com>
To: Ubisectech Sirius <bugreport@valiantsec.com>, linux-kernel
	<linux-kernel@vger.kernel.org>
CC: KY Srinivasan <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
	wei.liu <wei.liu@kernel.org>
Subject: RE: BUG: stack guard page was hit in vsock_connectible_recvmsg
Thread-Topic: BUG: stack guard page was hit in vsock_connectible_recvmsg
Thread-Index: AQHa4V4z8ZX/XtuyOkOyQTVm11ggQLIRwYHw
Date: Fri, 2 Aug 2024 22:23:40 +0000
Message-ID:
 <SA1PR21MB1317D76CCC5F69C56F230423BFB32@SA1PR21MB1317.namprd21.prod.outlook.com>
References: <59b20304-a273-4882-8dfb-fe9a668ec8d8.bugreport@valiantsec.com>
In-Reply-To: <59b20304-a273-4882-8dfb-fe9a668ec8d8.bugreport@valiantsec.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=2c8c949a-b884-4cf1-a7cc-8bb9aabb26ed;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-08-01T03:23:03Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1317:EE_|BY1PR21MB4395:EE_
x-ms-office365-filtering-correlation-id: fd8fb201-5833-4b2f-a93e-08dcb341c2b3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?XSvwcUHUZZnz3zddZkdvOF66YWQgXEPpMJoxPE9KQ8mxb24/Pqh0i3drW4Cf?=
 =?us-ascii?Q?NS19oYHPPS25G0r6FMC647yBWhbK9HHRVj+Hfr6O8+xinVdnRPdQoiCQUP48?=
 =?us-ascii?Q?Rc7oOdVOy+zQxHfDlNc8389Nzwk7+0dll/hfUUINhMEJTLL2CQ+rcRgZHkJ5?=
 =?us-ascii?Q?Y4N6d4DSDKseBHvvnb94GOz2kTXEfrKlqwZLcUnBqof/sOgvZf6jOLs+UPTB?=
 =?us-ascii?Q?IFOAez+l1XGbAJs9tDph1/k9WXYTrKCYzTB9xFUhjQtVhO7U7Nf4DKBSb/HF?=
 =?us-ascii?Q?Xlapt88NRcxNNF8LeUMtJHCGRZjL23eHJvSH+MCcaKNCtgKh+tpUBpn8zq/9?=
 =?us-ascii?Q?kKXhMNvgCpdjLUwywgABBj9O61Js3vM4S0/hO+uBYhtQ+dDj8PyeXOaaJ4R1?=
 =?us-ascii?Q?yhuk/G8ozIMBrZSJxzSEb+MK8F1IquvFoWGtpZzC2YU1OZXUfE+xrrZf44u4?=
 =?us-ascii?Q?LAIdC0aiqMuM4P1PNpH7wK1bXuxHspcEKrVMJIoTQXebnJyMNyB66r9bu76q?=
 =?us-ascii?Q?q/bJCw9CHFOCW6lvH2COk74JV+US57FnWtS/BXLCMfoNqbYGeGa+GgF4tCRS?=
 =?us-ascii?Q?OkR01pi3O2SAMlT8IWQ1NkMFxklnM8RYrqMq7LICl/56ULqNi/LcirPJeqT5?=
 =?us-ascii?Q?VWIAISfxcC8/jpxlV3IQ6/Z8STDOd9KHDIHv/I17xUiLmWsJ5qKCxDHSFyNk?=
 =?us-ascii?Q?obDiK41ofb94vG6QtvYcs5P4esz95r7zCn2AGYxc9JGuVEgrWxhaajKJeImw?=
 =?us-ascii?Q?P8xnM4lUi5Deo/pLHm67ZmutZKGzvLs0gZ11GBzu1TBqwSyoJVbTDrwyum6+?=
 =?us-ascii?Q?rIruUomVd23+CY2h+nU6Ep5b/2DGXoN4WyPAUJR7Mj8/gudJIkMFM3wAF0dx?=
 =?us-ascii?Q?ZxTCPLTr8ecHMaiZZMOus8iDRz3pw2w9ki5BGhOshb//0r0SEZ9FIbg8pwaR?=
 =?us-ascii?Q?kE1OfKkT1uqtRIaUrXatY1mo3MdKI224IE23I4sYYZUvWcoXZ0xkBxna+otQ?=
 =?us-ascii?Q?jxDRxRwkLd5xpMVtLQGgMTJyNcdqKjU0EA2chg1JvlW56ZPDezG/KQmoMFXS?=
 =?us-ascii?Q?Y+wOwso/AG0wziJnDs5Awhflvh1GNi2+BbkmP4H2VWl1zoRio/RBXasGG/yk?=
 =?us-ascii?Q?NbR9LHrZJMWzAkKHG8UrFxY+9E+oanIqRZhMRMNu2Qtkdokoez4wjHM4PJES?=
 =?us-ascii?Q?CLOeF+kt84CSnVxI+whxSFfJiDD5g7CKQW12p1vyt2yG7h9YDok4uWmtP8In?=
 =?us-ascii?Q?3gpwOjYGkUJZVLIJ4Hgge7KJ8Fruu70aCYxqIebs/Cm1Y+URf68vV5BJFSYM?=
 =?us-ascii?Q?20n8YdzGRFB3SwY6zqXesxMWhWYKloTjgeCiUc2oKem9DrnW55PAljtPHY0I?=
 =?us-ascii?Q?4iPeTqZQF1PAgoJYjhlHE1U8RrvbdmXDnbrmgTN89FSmTkgUAA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1317.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ghV04BHJFUpDdygFPRT5gq3bojWdWYZYhADRMdQ8F6i+g/2X081L7t5D8Rpc?=
 =?us-ascii?Q?8faeQkOzstHkEg3HwRJu6z84h3Nu6r5rrXw4nicUqxFIyqvtaXamJUa041mW?=
 =?us-ascii?Q?cZsh3MjomI5rg8i0yKVnDd2IP6DxAKT3eMi7CIyAzyuBO9wiLiSOovnB8fVl?=
 =?us-ascii?Q?UAKDHtdo/8LOfd9I4RhjHNA5RriM4ItxEvksceKOVzxLkqnuTSJZbKRBrqVF?=
 =?us-ascii?Q?yB/yTZJYK72vRn7BCjbm5LFMwakFxbYAoaW+iWOZAEJ/l+Ck28hEvPZG9F49?=
 =?us-ascii?Q?uK3QDFFdlQcelk7TwZFHJ4iOzN7CmurIGFDopoTzrnWGThdcj/4Oi/+j02la?=
 =?us-ascii?Q?I1ONjMi7Ahw1i0DO9OXpp4jNYAZkGhfiDx4rGXEheV7GeagxiWu/JdKYSncv?=
 =?us-ascii?Q?bmdEYWn2ciz6W5fnX7aJ6FYqVVQyn+5JYfBI/e8p/Yv6hLZfLfqv2/f1lBfk?=
 =?us-ascii?Q?ZopRq+Faf8aTBypRKiEqpExh6Duv9IkmvzLHaz8TgZIkyeo2Yji7OPb7bw1Y?=
 =?us-ascii?Q?4p2xqVi8HenMD0oN8RGR+FH89x+WlnHZbgCO8EKElfcp2ikNCtM6WBFDEnyc?=
 =?us-ascii?Q?W/fiNnHhjxKIMrkP16IoB7vE8EO89SBDkM4ICnlzzs843wGzRnFdPgtSN/uP?=
 =?us-ascii?Q?CtrS5lvM3+RwsavvQNMTYhB/S9PY4HBPM0EDSB2G/wvMzFzvfsTeWCucer71?=
 =?us-ascii?Q?KlsIiqxYqpgeHAR+PpZ4I2VQ2jyRt2ixSED64ya5sIz7eHnKcxGPysUOHrrL?=
 =?us-ascii?Q?WoeYdNYqDeTGZ2jo679AAj3cSBz0t8lSkhw5KCgLCykCucB41rqbR0MRHZE6?=
 =?us-ascii?Q?5q9+JjQXuITLTAPmAo7jWx1sClPZgekrBcuHJ1GfsMnX1hv4/FV6FvpDF3bH?=
 =?us-ascii?Q?Vc4xmSWbhhp+++RJtJarFSImcC5/MZWnY3d0IhJGC9JLBrXAmP3eeeqNsU1s?=
 =?us-ascii?Q?4HvLbS/3bhJJS1Y34AWIHU/xl0BXPKahEqfuscQLuGWSbAFC5QiSPakmFmpR?=
 =?us-ascii?Q?7uuqOJgRql2Ez7kOU3zet/+IANdFxJiPRFMOFztC2lJJzeLLUO8rS2ESqXNn?=
 =?us-ascii?Q?hyq09vD27JmqA8nNSVpezxlwSuiCaTgnK5Ny36e/8eL1EhNYn0Zb78ElWTjo?=
 =?us-ascii?Q?P2ZM+rn5Ubm0bjk0mo4j+rhrUPbxw74ewGj3zynC+c84qZMINPeJWUsr/rji?=
 =?us-ascii?Q?/vrBRoZOJuhtLwVO67SjWxEn/hYnxycoI303KM0S3TbvQDDY8RnMoIer07v/?=
 =?us-ascii?Q?baKyaa8Z+9nSlrZRgAvR86voWt4HaI36AfLu0FdM7hmpX8/qBQnmsLP8jG4s?=
 =?us-ascii?Q?fWF+gSoiaOxRQaeUB0Hj5wbsTSYTUAKtM2vINU+6CZ+aMuMc5lCXunjZmKuR?=
 =?us-ascii?Q?BNNVN4kXwK47Z1xxbu1e/0a4uOUe4lZZpJDCsShKIkIkmL52Ipok+IbzjXGJ?=
 =?us-ascii?Q?tjgP1hq7lYaOgIzBE2vQiSO1jWdj0vKT0MCMNXMAfCFnrVuP2THdx1xXfMgj?=
 =?us-ascii?Q?ACynrj3epnma53zZSkqYwavgf0bNx2okyHZry0Roi4nPCjXcHhDHyfGqFhO8?=
 =?us-ascii?Q?Npm/gm0eS7RPgDR9Bjst/WhZvE5q1YeqrbW43Al8elWu6FdxbilkE8QX+k4y?=
 =?us-ascii?Q?7xVrsw0uAcxz57p+iHFjJLA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR21MB1317.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd8fb201-5833-4b2f-a93e-08dcb341c2b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2024 22:23:40.0264
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RiolT/RDPtkDZ3dUPnm/GGBqKwyGINqYkSCxbqm68alw/t0xgkjFylNF4YpeABIr+Vo4mz1SCeTvDmL1wk8HqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR21MB4395

> From: Ubisectech Sirius <bugreport@valiantsec.com>
> Sent: Sunday, July 28, 2024 7:23 PM
> [...]
> Hello.
> We are Ubisectech Sirius Team, the vulnerability lab of China ValiantSec.
> Recently, our team has discovered a issue in Linux kernel 6.8. Attached t=
o
> the email were a PoC file of the issue.

I had a look at the poc.c, which I think basically runs a test in a loop:
    Create a new child process;
    In the same process,  do:
        Start a vsock server via socket(), bind(), and listen();
        Create a vsock connection to the server via connect();
        The vsock server calls accept();
        The sever and the client exchanges some data via writev(), recvmsg(=
) and bpf().

I believe this test doesn't apply to Hyper-V Sockets, which doesn't support
creating a vsock connection inside the VM, and only allows creating a vsock=
=20
connection between the Windows host and the VM.

I suppose this is related to VMWare vsock or KVM vsock.

As Wei pointed out, please Cc the related people/lists.

Thanks,
Dexuan




