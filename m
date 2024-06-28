Return-Path: <linux-kernel+bounces-233883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10A9691BEAA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 14:34:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB075282BD5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 12:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD241586FE;
	Fri, 28 Jun 2024 12:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="G5cGWo0q"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2053.outbound.protection.outlook.com [40.107.22.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB104D8DB;
	Fri, 28 Jun 2024 12:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719578038; cv=fail; b=haTednKTGysiOJwp4BJmP9EKYntWv+6f816DSWNvH9SR2TBfYnn8lWei4Kh9qEEuB45Ca4UWC4TbrF4z+hZYGGR3JfWmPjWbO3HC6JACvujmC6dwwqqHHWf+aZ40EU/tw1ox3H6czdgWjrvHY6bSlE7jfl8+78xcsCX7ArYSDnE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719578038; c=relaxed/simple;
	bh=JMuKrz6zRCyi7lj838o6tPJX/yvk6B+sQJCFPyGH5zo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AgItKc8yjreDo346R+npxQje96wtpXw0ycR2YIwDnCp1v8UGqAA5PmOUAdGqacbios/IWCT1JlCJzVSsu0YqSbQHZ+6Qzgfg6z236XWiKE/aOwtkzPe3FT1wwPu5d8RM8ewvFEDycMGkWB8/biUGJA+Lvb0x8WfyF2Ts2niKS3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=G5cGWo0q; arc=fail smtp.client-ip=40.107.22.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b7xatxdovw6odc2HAJASNhtVtOV5nJnSW5pwUOm/0nI2qk9hYnbrkcDSDVgFr/qZDxVTkPjx0+ljDE3d1w/MiSAqLhi7OPZT5JJlqCg8yzCqcxDkY8g7MNaajcNivZSsznD5sOK8EqsjukPOcp+SJ6132vZYeQ5c1/ZcfX9t2wwoRlIJR9khKuo4uYVAJffPBuSVImF0W9OJinV96R8ruJ8dFiH+9aQVb4XwP947M178l9zRuPuh5GK4U/lkBEbAz0t0yOirv/oTSZNm+/4UJV8V+Hb10nvQzRUhofy1egxANC6I9GfNCkPAL12DQL2ymLAW8/fwcoSp1mom04IuIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rXrtWTFSMRGU0VFisGTKQDl9B0coaotLGThkY0OONas=;
 b=RtER0ZxWI1NKTffleFNqt2Jtq5fh43dxbXxwJdthJmCpAczBIbQs8hJq98nfbq7k378Wfw/Tdf9n4Ty/6fHUTCEmNhoXZDK744NZNnT2WJSbPnOMyyta/WxZQrY/MWh82j4egkVHmNTpvZtSmfIl2IBjtS6+RmVwco+mCEiqlO2VdBwxn6Ui0G8GbOS/cQj3hkNEDSosCZE+Zf5oPNofxELAOE+ew5+fw8pNo3mBoH5ZndursQ3CKyJy/grzfrC86m/LQKvVDUWteCJMM135Vr+0rEc/7YvSiFS4Du2hWxep6y+atJ5Ubj20stLNf3lDqz4LwdSqkv4ytvhjq3FaIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rXrtWTFSMRGU0VFisGTKQDl9B0coaotLGThkY0OONas=;
 b=G5cGWo0qtuuqtrbVjpKRw/+IsblhIpaScyF/W36/DnMVgKWLOYpWHJjiSZySduBE+8zYty/KcGrV4yeti8MFxAQtbtMdr4yMjbCR4bxCNarmwzMDGE5WKywdB99q74Iyp1gmPEgijw/4EOjw0ZT7IMDnVRzUfCQHMUP2pusQ/tw=
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
 by DU4PR04MB10768.eurprd04.prod.outlook.com (2603:10a6:10:585::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Fri, 28 Jun
 2024 12:33:53 +0000
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256]) by AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256%4]) with mapi id 15.20.7698.025; Fri, 28 Jun 2024
 12:33:53 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Rob Herring <robh@kernel.org>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>
CC: Saravana Kannan <saravanak@google.com>, Michael Turquette
	<mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>
Subject: RE: [PATCH 1/2] of: property: add of_property_for_each_u64
Thread-Topic: [PATCH 1/2] of: property: add of_property_for_each_u64
Thread-Index: AQHaw9ZmlXnGs5ZPSEao+eKKDoQ6w7HcLoqAgAD3VmA=
Date: Fri, 28 Jun 2024 12:33:53 +0000
Message-ID:
 <AM6PR04MB59416E3C8FFC904450F3B02D88D02@AM6PR04MB5941.eurprd04.prod.outlook.com>
References: <20240621-clk-u64-v1-0-d28a611b2621@nxp.com>
 <20240621-clk-u64-v1-1-d28a611b2621@nxp.com>
 <20240627214355.GA601888-robh@kernel.org>
In-Reply-To: <20240627214355.GA601888-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR04MB5941:EE_|DU4PR04MB10768:EE_
x-ms-office365-filtering-correlation-id: 496611f2-5e95-4d3c-a2a0-08dc976e9241
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?mVf9CamlrfjNGdW0XM3ZcyZEF7lAPh06tBSGAO0XsPpvwnPjTw2knwCJw2UL?=
 =?us-ascii?Q?Yvxy4A2QDXwaMQ/xPxIh4TYy/8rz0wShoW2JM8cOIzRknz6/q3W3R6CF1+WN?=
 =?us-ascii?Q?IpcSzLOYbCOdITnd2nner3MvjKUEvR5mAI8LMG0VtGgcgqI5ReX3fppU8/mQ?=
 =?us-ascii?Q?DQ4wgAv8VpkR9KCAeQfIiv9jDc3PUOQ9a4r1Kua83Q9OOeMqyj9zbEwLnUmN?=
 =?us-ascii?Q?mvhJICSZ9pZXH46YL3hqLRDj5JvlEJ93y0lTVTwrnWYGu2nwfrVifE2yMIF/?=
 =?us-ascii?Q?y+nLe9SCE9DWLAX1/C61Ri2CF+zTcuaPXaECW0XbDw9mTWPwRCl0vW6SMQMy?=
 =?us-ascii?Q?fJw4GeuknYG4oWlVtlOP9JDqGiRaIn6C07AkoIsN3QaLsq1JCqQzkeuSooHh?=
 =?us-ascii?Q?fMReNYfWUf8au/xpdA/gZhp7p7Rvt9nU/8fGGJdln6b+zjREkL2zOvG7ugQn?=
 =?us-ascii?Q?Hw5GHvSIKir6Nic/7VPsApC9SBxZfG2ZMfiljOs/cE19hELP7DArdMEPpbyP?=
 =?us-ascii?Q?pxQuMCiRfoCVQ+ViswfmeiYhh8SwqcpZdXp5AzNEGKZFn4iNPQ48abEk6LpW?=
 =?us-ascii?Q?t1dvrfKom7GuFz2PbHYoN2EodoJVULkjSKbgq/ZZN/+nOzcRJh9iJg9YfWdP?=
 =?us-ascii?Q?1qeB8G1AfhTLke0XPIhEicNsol7IK8BFwLCCgg1g+oGCJWRN3flotMO1Kn7L?=
 =?us-ascii?Q?SH0f1A4VWkKLaML3ukjME139Sd/85ZWgaU+aWt6KAjCBJOCqKxmoV/TpfqY3?=
 =?us-ascii?Q?Y7sWW+wyNqd4VTLgj0guJkzH5e6uzrJwU98OfExOryC3+KxeRhUIMcHE+rLo?=
 =?us-ascii?Q?74vUhpGcVJtBzyimXhLtOiAWRcJIV+nDX0QDrQvePaSaN7rxuRryt2JQpCfr?=
 =?us-ascii?Q?LTyCtoAo94vZv8YwLhEvWWKYVfkK8+/3SnI1KTk4bYSs8YLjMpJ9rivbQndF?=
 =?us-ascii?Q?QZiNe5LQkckZ7M4nQR1wPOBQzReBr031fFdf346ctsEets29WolNp5ZavCmm?=
 =?us-ascii?Q?6METbn0I+uQWJze+OTLN1IfNBVmo3yEqF7hQ8mrYil8ne7uW+KbM/ov73xTd?=
 =?us-ascii?Q?ofhfvanI8eeuPvR8ogkdnzINEnWp+JmZJ+bZFBdpS5WtwGJGtMfP6DsoaIdE?=
 =?us-ascii?Q?jIJ2mhB7wnMxJ266s6zYRXxiJa7jy3OifuGudtz6p25BButHyx17WEL8IAJZ?=
 =?us-ascii?Q?3clsf2xaYHK9Cc55UIwRaWTBUKXnvNniuphlH13YVJ558c7Q050l3Iq/i1/b?=
 =?us-ascii?Q?1A2PB1dzUhHxz/L+2noSgbVNvoml7jqKMmgJ7CEXeF0MR9mMRiGzlVEXMgrF?=
 =?us-ascii?Q?yTQ3bAMdrIqAFV2evRBnV7WRTeBrRv9bsCyjDUFNfPbJ5o/bn1/Ri/f1ErqF?=
 =?us-ascii?Q?Dh3F1tU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?IJXIPsXNRdgLYSY2+dAzTdQ17k6kiwSEUL4i8Bh66haecKy1W7RaIGn9b+uu?=
 =?us-ascii?Q?XRv9w0Ffd8Y2BE4imMzBr4nlH0fj0YufFFTX1Dz1JlJx2s+eM7nSxwh70Fqh?=
 =?us-ascii?Q?1+xwDSPprsVtvfReGx+lt1zd8cPNSnSLfRsXYv9HCAdoLIh69pBhuRcU+5Wa?=
 =?us-ascii?Q?0bCt5C5LiHyCEHATEtwC/TLUEqfgCmI0LA5NEdtc8bEcLOx3MIkpiWJMz0kQ?=
 =?us-ascii?Q?kmTyFpMnEHFzyfVLBgUhL5oA6/MaRr6BwhH3soEhDwxVgaceY5oTYxaRu2yV?=
 =?us-ascii?Q?LVOPzvz4aZ3CBvlggqWgsbcLu/snBNEga5C/+uFtLbunUO3/445QZQdulm5E?=
 =?us-ascii?Q?c9DXiOfnp3KQ6mFEPRQOOHIYapfXO8/bdcQgCBdkhN4p/dqs3l3dxunq1YkD?=
 =?us-ascii?Q?pyRBfKYfcF7f+UdA0wKbYS7+W5Iq38fWr96NsdO2Jj4tkDU8moTXWhP+Yrro?=
 =?us-ascii?Q?GG11rXeV9Q3afKtrEDMhZV5rypXgVlg3Ssys6uzMNwg8mgRifO6FRXbeDCJL?=
 =?us-ascii?Q?oSmWv8pQRm+VUNGkHU16ZFW6tAjgfdCVqyC0szlB+kwLNqDI4wdXoSZqOF5g?=
 =?us-ascii?Q?ATd5SSADiA3fiPSDOFyrdFjrVxLUtilqvaQpUkVXYEAUDVa1PTXvMCbBpEdC?=
 =?us-ascii?Q?bQ2Xb2vMHHlAJRCFsAk6Gsusfz7ZHlhshDVHT+mrUjNxUcAcNZYXE5gDzBvo?=
 =?us-ascii?Q?QfrqugIxK8MepbqMtLfQFq65mcpDllZxGdr8U4BYvnYHpAwYuDKWSYi1N02p?=
 =?us-ascii?Q?9c4uAPYLt5LLxlItaYOvYxALhJrg40kgBa0A3PUwH0ofXFuD4wXgxRik4VA0?=
 =?us-ascii?Q?D+lQ4ngfn8snSjFiHqOFy1+LaXz2g2scCDZm5I4gLW4FOjtV0q8RBxBmmorY?=
 =?us-ascii?Q?1N/h++HxNnykF1/aFGHWPxywmDZW2StXnZdTV69weQ6qSAvnI1UZymzEReWt?=
 =?us-ascii?Q?QDgsYqS60VUsajUwXy4AkaPtNbyKoPWSitKlORewDvuOUVCUazCrkVVfTXno?=
 =?us-ascii?Q?nhuiVRdq53xi6f6R4Q8Hk8VxjE1R3GidjHMFboqaV78j1ZGzQg9GrAZGJX1D?=
 =?us-ascii?Q?MiQnksusClRPXgXfR7+9sy5k/uC8O3A0ESs/g3o+1nml3FGj1j3w3zkINOES?=
 =?us-ascii?Q?U8fDkW752vRsI8UD/j0USd5kFpcivhkzxJgjPpbsh8a5kZRYhSyaTQ94ygOQ?=
 =?us-ascii?Q?f4CBrnR6iR1rBypeNpJ6Y0pWcwe8uHXC/OOVDnLHjdD844AqNjJwtYCdyfZV?=
 =?us-ascii?Q?a1XLvGG5i9/P1oJv3/iQIgJWo0bY+Y7BmkB4UdUYGhGIU2GAqzjuaCHqKm0D?=
 =?us-ascii?Q?pHqoU07n40XZoWhBbskyIIl7pLbuEw+uFfvh53cJkX4VLkDl+BHztMc+cdtb?=
 =?us-ascii?Q?rUMkLbFOFaJSLnQSkc4LDJ/fKSRkn5JytNh9wjyZ8DDrYlf7Sd3B7cH8RaL5?=
 =?us-ascii?Q?xwdm0me/42Z/lE85r6dO9QQCr7PHH9PPDYGjAWu7J4pL6Nfn1VYh8jtmYdb/?=
 =?us-ascii?Q?vhYOpW+QkoMnun3YFt5jrjax5Qnom5xAK+fz4xlmUQniTze4vVxErmwYacgu?=
 =?us-ascii?Q?q2z9ybTJaLAbKAtko1I=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 496611f2-5e95-4d3c-a2a0-08dc976e9241
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2024 12:33:53.5670
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mBYmQiGw+Y4H8LsT2PTVexLzxxsE06pFppCTAccs3IPZ3LYBrGVjVLXWalDOcnFYWuLcInhPh0nW5b20ahvNyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10768

> Subject: Re: [PATCH 1/2] of: property: add of_property_for_each_u64
>=20
> +Luca
>=20
> On Fri, Jun 21, 2024 at 08:36:39PM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Preparing for assigned-clock-rates-u64 support, add function
> > of_property_for_each_u64 to iterate each u64 value
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  drivers/of/property.c | 23 +++++++++++++++++++++++
> >  include/linux/of.h    | 24 ++++++++++++++++++++++++
> >  2 files changed, 47 insertions(+)
> >
> > diff --git a/drivers/of/property.c b/drivers/of/property.c index
> > 164d77cb9445..b89c3ab01d44 100644
> > --- a/drivers/of/property.c
> > +++ b/drivers/of/property.c
> > @@ -548,6 +548,29 @@ const __be32 *of_prop_next_u32(struct
> property
> > *prop, const __be32 *cur,  }
> EXPORT_SYMBOL_GPL(of_prop_next_u32);
> >
> > +const __be32 *of_prop_next_u64(struct property *prop, const
> __be32 *cur,
> > +			       u64 *pu)
>=20
> struct property can be const

Fix in v2. BTW, I am thinking something as below:=20

const __be64 *of_prop_next_u64(const struct property *prop, const __be64 *c=
ur,                     =20
                               u64 *pu)                                    =
                        =20
{                                                                          =
                        =20
        const void *curv =3D cur;                                          =
                          =20
                                                                           =
                        =20
        if (!prop)                                                         =
                        =20
                return NULL;                                               =
                        =20
                                                                           =
                        =20
        if (!cur) {                                                        =
                        =20
                curv =3D prop->value;                                      =
                          =20
                goto out_val;                                              =
                        =20
        }                                                                  =
                        =20
                                                                           =
                        =20
        curv +=3D sizeof(*cur);                                            =
                          =20
        if (curv >=3D prop->value + prop->length)                          =
                          =20
                return NULL;                                               =
                        =20
                                                                           =
                        =20
out_val:                                                                   =
                        =20
        *pu =3D be64_to_cpup(curv);                                        =
                          =20
        return curv;                                                       =
                        =20
}                                                                          =
                        =20
EXPORT_SYMBOL_GPL(of_prop_next_u64);

>=20
> > +{
> > +	const void *curv =3D cur;
> > +
> > +	if (!prop)
> > +		return NULL;
> > +
> > +	if (!cur) {
> > +		curv =3D prop->value;
> > +		goto out_val;
> > +	}
> > +
> > +	curv +=3D sizeof(*cur) * 2;
> > +	if (curv >=3D prop->value + prop->length)
> > +		return NULL;
> > +
> > +out_val:
> > +	*pu =3D of_read_number(curv, 2);
> > +	return curv;
> > +}
> > +EXPORT_SYMBOL_GPL(of_prop_next_u64);
> > +
> >  const char *of_prop_next_string(struct property *prop, const char
> > *cur)  {
> >  	const void *curv =3D cur;
> > diff --git a/include/linux/of.h b/include/linux/of.h index
> > 13cf7a43b473..464eca6a4636 100644
> > --- a/include/linux/of.h
> > +++ b/include/linux/of.h
> > @@ -439,6 +439,18 @@ extern int of_detach_node(struct
> device_node *);
> >   */
> >  const __be32 *of_prop_next_u32(struct property *prop, const
> __be32 *cur,
> >  			       u32 *pu);
> > +
> > +/*
> > + * struct property *prop;
> > + * const __be32 *p;
> > + * u64 u;
> > + *
> > + * of_property_for_each_u64(np, "propname", prop, p, u)
> > + *         printk("U64 value: %llx\n", u);
> > + */
> > +const __be32 *of_prop_next_u64(struct property *prop, const
> __be32 *cur,
> > +			       u64 *pu);
> > +
> >  /*
> >   * struct property *prop;
> >   * const char *s;
> > @@ -834,6 +846,12 @@ static inline const __be32
> *of_prop_next_u32(struct property *prop,
> >  	return NULL;
> >  }
> >
> > +static inline const __be32 *of_prop_next_u64(struct property *prop,
> > +		const __be32 *cur, u64 *pu)
> > +{
> > +	return NULL;
> > +}
> > +
> >  static inline const char *of_prop_next_string(struct property *prop,
> >  		const char *cur)
> >  {
> > @@ -1437,6 +1455,12 @@ static inline int
> of_property_read_s32(const struct device_node *np,
> >  		p;						\
> >  		p =3D of_prop_next_u32(prop, p, &u))
> >
> > +#define of_property_for_each_u64(np, propname, prop, p, u)	\
> > +	for (prop =3D of_find_property(np, propname, NULL),	\
> > +		p =3D of_prop_next_u64(prop, NULL, &u);		\
> > +		p;						\
> > +		p =3D of_prop_next_u64(prop, p, &u))
>=20
> I think we want to define this differently to avoid exposing struct
> property and the property data directly. Like this:
>=20
> #define of_property_for_each_u64(np, propname, u) \
>   for (struct property *_prop =3D of_find_property(np, propname, NULL),
>          const __be32 *_p =3D of_prop_next_u64(_prop, NULL, &u);
>          _p;
>          _p =3D of_prop_next_u64(_prop, _p, &u))
>=20

Sure, I will fix in v2.

Thanks,
Peng.

> See this discussion for context[1].
>=20
> Rob
>=20
> [1] https://lore.kernel.org/all/20240624232122.3cfe03f8@booty/


