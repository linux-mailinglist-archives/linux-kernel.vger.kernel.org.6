Return-Path: <linux-kernel+bounces-235047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DF8291CED8
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 21:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E29ACB2174A
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jun 2024 19:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF9113213D;
	Sat, 29 Jun 2024 19:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Bv/UKMCG"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2104.outbound.protection.outlook.com [40.107.244.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2424C2032B
	for <linux-kernel@vger.kernel.org>; Sat, 29 Jun 2024 19:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719689295; cv=fail; b=RvhmTbcEz6mA5zCALi/GQ6T/ntqQR6Nqj470rzRc0NdAu2zkzdsLmnR3LQqc83GQPdDSMjrVzeL/qSH2aiaiKUxlZo+CdRenJloCn78es3iIq1sBAf7BI+ywYlG6RN9II1dUbf6uFb5ygzJhPG1AzjJRIWsEYaiRd/MhW6ePxpA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719689295; c=relaxed/simple;
	bh=NbJ8rv1u/yEgu8k1M6CY4Rrx/gfWrEohSZEM1Mo1vbI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Fy0riix2Ql7UTu5Gfhml1za3S8WZgopAcI+N5k3VmhShIo/VXuClKEcHC2lvYsH4sqfHLky3FzQqQP1wq7hdt+ppPqREHyxsKrA1cdrXjPMIG8tPYkFn834TrpnGyQP/ik7RtFBOYYewbfyJotaoS32f/+B2cXmApzQxzCs9rts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=Bv/UKMCG; arc=fail smtp.client-ip=40.107.244.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BRFc8B35Rkkgf5S58sNzZKuo9V1cjd1um97nqFbJzdSdI1DJ3xifKCr/+N9GnLsCGWuYFu2bVavw9FoPfqs58BMeRsH2QarhPCj2IYj842UR7RovDdXOpyJiM2w6zUyB1lzUbu3Sdyj2c7RP2PWZiK/EATGcDl8M2ghr+lG3uMbm3HvRoPxFnjVEHDXs5ZGJTZF7A+d9PRmiZbI9RQ4ejFGS66RBAOA+U/mWitjCpHocsJPCypTfCGQLYMswVkiNFpnxo+HTtb4EYuvhrosbdjWHBhE6SrcU+POKfZJSNRfFn55ayXTwpg0nncOHbP68wWwzO324v/ZxrcOFVx06UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qs7TYLI+N/yeKh1p4nUEQ8CcUcVk7WxkBrxYNsaJ8MM=;
 b=UakXCwO6jHpzaA4kj9NUHwPCRXVPAob+6fJ21cUYQeg4PEfYFXIoQcypQ/CrS49UqJvnaLz5j28ae7FRkwc1XI1BE1ojb4w3ZJEW+o+SXAlZtVv2tdPPivsIJXw5szjgUhaJG/C+eMt16fK3T28Kbw1V61Dokw7dNMIp1IIJQ3KFoIai1nVlrZ2xm4jkKmKTy9cxJRj/ONGxUmEl3d6fRrEYRXPiTM0WoB1s6xS+ZjBIaFgTlZwi+5m+gGKf+MeYp5vjbXB1hn+tOHJr/lGmwd9T/e1VkCA2NdDFeM0Se/R+uFNwx7n81KXiJvgf3WYEz18d5SBImPnmVPst0LHgoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qs7TYLI+N/yeKh1p4nUEQ8CcUcVk7WxkBrxYNsaJ8MM=;
 b=Bv/UKMCGw3gIJyeZB3SJwpWPOvqxnAhhzrijQkn2svZm9cAeNTWw/8A05D6G3gdDPb1Enjfxy4ln99wZX6lLYmLSm0ofTZ7eqkFnUIAELbCdRg7XAZAqQnspXHhvalQ5z2Cd5koJaTlNSCG9AziUWZDRWNqCMT6SyEv393y59As=
Received: from SA1PR21MB1317.namprd21.prod.outlook.com (2603:10b6:806:1f0::9)
 by MN2PR21MB1488.namprd21.prod.outlook.com (2603:10b6:208:203::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.0; Sat, 29 Jun
 2024 19:27:59 +0000
Received: from SA1PR21MB1317.namprd21.prod.outlook.com
 ([fe80::67ed:774d:42d4:f6ef]) by SA1PR21MB1317.namprd21.prod.outlook.com
 ([fe80::67ed:774d:42d4:f6ef%5]) with mapi id 15.20.7762.000; Sat, 29 Jun 2024
 19:27:59 +0000
From: Dexuan Cui <decui@microsoft.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Borislav Petkov
	<bp@alien8.de>
CC: Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "x86@kernel.org"
	<x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Michael Kelley
	<mikelley@microsoft.com>, Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>, Kai Huang
	<kai.huang@intel.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] x86/tdx: Fix crash on kexec
Thread-Topic: [PATCH] x86/tdx: Fix crash on kexec
Thread-Index: AQHayi08OouzMdQ9yk6RhWa7zn+1QrHfHynw
Date: Sat, 29 Jun 2024 19:27:57 +0000
Message-ID:
 <SA1PR21MB1317A2E38083B300256AD5F1BFD12@SA1PR21MB1317.namprd21.prod.outlook.com>
References: <20240629130621.1671544-1-kirill.shutemov@linux.intel.com>
 <20240629135933.GAZoATRVAubo7ZDdKB@fat_crate.local>
 <poxeykijyqrz5hxrey46s6hh2qd6byirbevwuwec2gtbfq266c@npegk7sn3ot7>
In-Reply-To: <poxeykijyqrz5hxrey46s6hh2qd6byirbevwuwec2gtbfq266c@npegk7sn3ot7>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=5ebd1d85-4722-4b60-ad42-e0b045ebd85f;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-06-29T19:23:01Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR21MB1317:EE_|MN2PR21MB1488:EE_
x-ms-office365-filtering-correlation-id: a938176b-93dc-41a7-ad4c-08dc987194e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?3slBpmATJLaChFDFuqXkpVwe1qrF6VG+1KuaIK18AGrIAD7f2eDjV94Cwdsr?=
 =?us-ascii?Q?syxwQZPAuHsx3ucpkrh3DyHS/kLhh+XpCG3fquxsd+fAwnhAJpI609d8qfd9?=
 =?us-ascii?Q?FQ0FDwPQ3jI3LjBgNuEZDFm6g177XOHbcCntPiAOhz8gWWuxSSOjQ1nR8iim?=
 =?us-ascii?Q?vGcXYKmXu3r4g8JbmJGHT9PYi5iZe3Cwgaq0+8eUyyRzcB37xeqTN/YMF3z4?=
 =?us-ascii?Q?vwTwJjYI/TvSJ5uAywW85PqKSKV9U4IUzvkZ5WOq7yC8JKdejMl23Zb9XYv+?=
 =?us-ascii?Q?VeluXt/2DhOrLnqn1j1mMnOG5MfglIuXeaJbNn8LC7MdufGHXgwFSZhBhiyu?=
 =?us-ascii?Q?AzEvbi+3p7DCa5EpxoNP57Wyu3SnqNv2mfxgPdehxqGsqCiKzSKV5w97UvGi?=
 =?us-ascii?Q?KlCnSCzYPDpeoCajg2nP1FmG1245Q8nw7x/46G1Yj2kjfcuF5KswFwBHfmld?=
 =?us-ascii?Q?rzrhmDN4NgmsiGPJB2sQqeJvhvLDDSAMOmr5DLBedEK/MWkF7onXpPXahj7O?=
 =?us-ascii?Q?TCjwzvCM5sqlwofYvi/SBaRz6ucsnqS41KYWySxfnQOpES6g8XQ+Em+ZT2uO?=
 =?us-ascii?Q?2PByyuIZb4ACwqoxN+BUiNN5ltji/zKgTpBFNxhDr/rXcgbSmX4dsqH0G4QP?=
 =?us-ascii?Q?mWF0CihKVjLMqF9OHjc6mKGw829k6yGGXhRKqE9tuKCuN0lfYDCLiRh3gJQW?=
 =?us-ascii?Q?QN0PAiE499qjSyY0DkC/qFzlKIWi+70HVHcMhlCTOVNpGKbrAxXNvmdL29N6?=
 =?us-ascii?Q?+JfGQlKIilGfHDa8NaQt9RwkgugscPvMcuH75O6Rb6B63ClLaUSl8pzJMiRB?=
 =?us-ascii?Q?WLKpGZAMzbi9iDdZFm3S1H/kKW96Ubo8Q/n0FUdxzQpOY56+/hvqzV31eCuT?=
 =?us-ascii?Q?nZ2c9G0xXV0h6bAJ0dkxh76P6ypDMCw/qYgGDkpvefkUvj2p84zi0j78QEHS?=
 =?us-ascii?Q?Yr+oT8c8JwcQtbWzi7UKvsK/Rxx832ZWFkCMbEICfG+TT4gG7O7U74HEP1pH?=
 =?us-ascii?Q?jfwptlV7/VhDbXBT4mfrXTwVzSzMvIEg1is4cgoewZKS3lM8ku/HU4LDRpeR?=
 =?us-ascii?Q?DDpqtyObQNVnmTnVurhyUHrVTFN7jEp8goHP6haPlNXQGWBuxCseA9VR03BF?=
 =?us-ascii?Q?R4oBPONwgY+M6kf2VR8n3mv43T6AVFYtoDiGLiapXLPLMJ21Qxt5AQTIZ4L4?=
 =?us-ascii?Q?0ggVQCXxYLdOhSnvcv7eCNjAwGS+ikIq9regI61WEdL71LaVl+8edaK9G10L?=
 =?us-ascii?Q?+fckvjH03GSh6IyRmg5BtGPGpUBidQaSH4o7VT8buLxDO09n+Wx83M6M2STW?=
 =?us-ascii?Q?znmbUP64sxe259KTMbmGOpNCNhxB28w88tdZ3G/50J+NAAAzUPzY5qxBTwDF?=
 =?us-ascii?Q?MK8fwzi2N0AKK6pNcHU8DHJJU5S7DIrInmR2qLX57aTAmekNFQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR21MB1317.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?lik5hPzyRpJLepb4/UpA928yll7mYq05o/L/FLRUOIX2mlbaZQFRNm/wr8KT?=
 =?us-ascii?Q?udyZ4ZxUPl5Vyo341FyU1lu5Z4CE91IluVcCnTnrzAD+Rn7AW3pO3HXOItgu?=
 =?us-ascii?Q?xnxV81yMJm6L5cycJKbx6aBt+KawxIZz1CNpZKNypK8ZTjHoEHRg2oteflkd?=
 =?us-ascii?Q?lBS+Da+AaSWPIZaHCRs7gOqqy5IiH89q29KTudmefjUGiquHaPtDv2NX2yAi?=
 =?us-ascii?Q?3O7drUBJUJF201EddeOGU1MLDKae5MRtTx0Z0Hr4xStX846txuAEeTjwB5Qe?=
 =?us-ascii?Q?dT8rvF7qxxksOE1OXP0P32biSO8W8+81rMv0yZdvdLRTR51ifpB4PUFps895?=
 =?us-ascii?Q?joZr9ZP2MAPtOcR9uzBcbBlwHL5EECPse9v0MwyaW6EfTs7iQFkxROMVVC0r?=
 =?us-ascii?Q?NxATgL84OoDhP5mohd63FXv8OI422gWxFaZecWAyPTSe88Ar8PDMWLlmqd60?=
 =?us-ascii?Q?75hxcItV26K0hEgSh9moAA1CywOGeZ3dQIkDseBUcDmM7enVS36zIs9hyBqA?=
 =?us-ascii?Q?gXq/dCvF5AE5edUcaw45guWkZvrgZM0HuJxF4uowuZLxWkJ5mRy56yWsJnzr?=
 =?us-ascii?Q?8aqAXYE9Vp1IrquupVQGII74pbUhQzH4W3XtucbshWec6NJnyhNZ3+M4qLVo?=
 =?us-ascii?Q?nESS9WqMOf1TJt7Ep2kCHx4RloSwy8kLRw3ip//TNeXCLmOPS/D3R8KVQjl6?=
 =?us-ascii?Q?0xPHalcVfRCzl7jYk+DP0kYX+bhVDcCN7mB6m2vw6jB+fAyszBto0MqL+RWm?=
 =?us-ascii?Q?wc/6mukjy6HXyj6Ejq7ZEUIuWzYtvVgfiDErzCY2S9VTEi734aVffLsq0vmG?=
 =?us-ascii?Q?su6JWkvhR6bSp2+HOkWP5HZQOAe3L2FF20wXy+1V6zoCMGvhr/RXTwbpGZ8A?=
 =?us-ascii?Q?IQi2fqkeUF23XU4nVu/oR1RiRKsJ/k5+b1pINTlcZm3aV/TLwRYwWvOmgkDW?=
 =?us-ascii?Q?suuu0I+prr/Yn87q2rEnD1XPUJYxSlIPFvYpvI6W3o3JpKo0rgey8ZGHrNA+?=
 =?us-ascii?Q?X0mGsl/fy28YqBqS2eaUVy6dTpkfT+phZgrn3d6uk/cw7P8lZp9DMA5cZT5P?=
 =?us-ascii?Q?ILB23jnHZTMsdwz1KxF32cioGHB8Eib6CMJ52ojAk4cPMSO4Xr+ZvkoCsKlo?=
 =?us-ascii?Q?qLiNSZvsyN+ac2YJUEw/Ss+6JHC3iStlEtLHsKvKm0IvCrP59BS53nIIaV+g?=
 =?us-ascii?Q?w7kAE/GnPihyB/5A4l8XyFro+uRuDhM+biihmBHnt7HMLWX2kaCA+26eKtiG?=
 =?us-ascii?Q?FbT6ySFeLJcv8hEtwIHrRaxZo2oJSmIwP7wSCon7h6vk1r+XG40YZc3H5P4U?=
 =?us-ascii?Q?ION7RUKdiiTwrcBE/W2ENT84UOBJDyb3iCBfCTXU4KF2xhg7NprYfvs6EuZX?=
 =?us-ascii?Q?51/0G+HTYgsxompUExxPaf61DLE6UbiCV+DQ8QhqEXVZQwZzdWsRMsBoJxD9?=
 =?us-ascii?Q?H9OkW5WxcHhphjZZ7exhpalQ2LPu/luHMxY5gwkDZ+pqlGslfLZ9N1IrDXYX?=
 =?us-ascii?Q?HIacE4Mha2DkOhvmnLesVYeiBFvG489jy8NfjkkUcrP08YfvBZEEJcj4G6wJ?=
 =?us-ascii?Q?vQQzrFaJd6qlgBXpFBw=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a938176b-93dc-41a7-ad4c-08dc987194e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2024 19:27:57.6329
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5O8FNW+8GmTLxSEr8RcgF/i6Gez/LEILPaG7Hkpov29UCfvkhgv1xMetXzSuQYIvNDxN2/rxYtMUrWy1g6mhyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR21MB1488

> From: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Sent: Saturday, June 29, 2024 7:04 AM
>=20
> On Sat, Jun 29, 2024 at 03:59:33PM +0200, Borislav Petkov wrote:
> > On Sat, Jun 29, 2024 at 04:06:20PM +0300, Kirill A. Shutemov wrote:
> > > The function tdx_enc_status_changed() was modified to handle vmalloc(=
)
> > > mappings. It now utilizes slow_virt_to_phys() to determine the physic=
al
> > > address of the page by walking page tables and looking for the physic=
al
> > > address in the page table entry.
> > >
> > > However, this adjustment conflicted with the enabling of kexec. The
> > > function tdx_kexec_finish() clears the page table entry before callin=
g
> > > tdx_enc_status_changed(), causing a BUG_ON() error in
> > > slow_virt_to_phys().
> > >
> > > To address this issue, tdx_enc_status_change() should use __pa() to
> > > obtain physical addresses whenever possible. The virt_addr_valid() ch=
eck
> > > will handle such cases, while any other scenarios, including vmalloc(=
)
> > > mappings, will resort to slow_virt_to_phys().
> > >
> > > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > > Fixes: e1b8ac3aae58 ("x86/tdx: Support vmalloc() for
> tdx_enc_status_changed()")
> >
> > I'm going to zap this one from x86/urgent and give you guys ample time =
to
> >  test
> > thus stuff better and longer.
> >
> > Also, what is this e1b8ac3aae58 fixing and why is it urgent?
>=20
> Daxuan, how urgent is this fix for you?
>=20
> --
>   Kiryl Shutsemau / Kirill A. Shutemov

Hi Kirill, Boris,
IMO e1b8ac3aae58  is not urgent and can go through the normal merge window.
It would be great to add e1b8ac3aae58 to the branch x86/tdx.

Thanks,
Dexuan

