Return-Path: <linux-kernel+bounces-187822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE4828CD901
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 19:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E128B1C212FA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 17:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F91B6EB73;
	Thu, 23 May 2024 17:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="LCqnKpui"
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11020003.outbound.protection.outlook.com [40.93.193.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC676EB60
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 17:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.193.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716484125; cv=fail; b=SlrQZaFVcQ3oqyHsMDQNoYNN1ubSHuQLSipcC6u4itCm5LtEjCRc8vx/D8N2jy7l7qHQkRyRnyjk6ig0dkV3lf55aldrzgpJvz1+5HIMyP0qyfYCQmudI7IdreyUXEbqdjuxyEGLPR9fdkvhZwEawrzJ50uiUUfyk16o1L43Zpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716484125; c=relaxed/simple;
	bh=vJoLWyIT2VteW10SnSBLbRekKxzCFn2xyVB/EeuSN1w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ikaB0mQtlz8y61jMpZM8yzbLjYhQHGJ642gi1qiRiKDSxHN73Z8g4IFb0iHo1cE2IzqafLKgbs2fo5CX5rQO+gdacllXBj92q7jzHb/8juyDliIfXbwlgJBxUVHv5sUZ+8IDDzUseHi1UnR42GRo6Fi05yrYcGLLOZQ3K8JYWyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=LCqnKpui; arc=fail smtp.client-ip=40.93.193.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j1zUFTEMzXV5GXfMMeohny63KjvxBBu8bOHqp31yvCYKMBcpwJZid7X/QLz4dkUv+UgHHIa91M0ulWe0RvVH+kr/hxJE/bTLZ0liylHmaIiHadTtrLYWqWyBe2i4KhM48EpH7RKyaCRi6GYneKUoMhcw25jhvoegAhRLFo/3vRrFPWvqCUaeyoh19eZGkUh33+MZC8n/oULIsnkoJKG4Xl+XaCwQFsI2D4LDgbTxQzdT556FrpOCKvbUccqF3O+rO7UiEEvDN0rFam7HkQXMtc45kbWG4NyyZGttM9u4IhgynXcIcHA7VMDlwkP/XqDhauskt3H4LzCtNoaWTAWfPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eUsfgpLLUPEmsslQestXQQ/CTiH6WXhBDlRIbHnv7P8=;
 b=mh294Y/cwhptOerOYHAKyim6f/x+qFb3llBLQk0DbOf9x4A76dne+85ouTgQ8iW8DRRH1rcTK87sPMcc2qASbSaPRzBeoZATEnTtpVIZ9cHMdjKLlV5EToqN500mKnWE2TLsWdalyUVpQ630jArP58fKx2lMhi6OMMiobOh1t3e128RCkwmhWW3HzPOSYPgzUn0MVeyq9QnfrDTvI0BbjKq62l8cO7f5pY/RUDxEo2GJlG8N38enOeF3XWiFOuIjT/HYCScL8n2P338kSfCJE01VuBJIwvx8YrSKXlDFOdF7e1j+x1i2UBs9imJYaYyy5Cxx+lLFyVV6+PyuKgG4Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eUsfgpLLUPEmsslQestXQQ/CTiH6WXhBDlRIbHnv7P8=;
 b=LCqnKpuiCtyvLLxBKghlq320VMIpPwJY5/6o8IRPqX4Vle8LcPmec9eYDJbpNrKfrBYoirwcoAdhpkVnAGZ4011fJzZpCt1R2q1u9wC9N0SrDazD7n5UD9JQmUcxchp9gKqtB2JvR0bwfdWxrel63Te32Xxquiz6z21ETmqSLxQ=
Received: from DS0PR21MB3863.namprd21.prod.outlook.com (2603:10b6:8:122::11)
 by DS1PR21MB4178.namprd21.prod.outlook.com (2603:10b6:8:1e0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.9; Thu, 23 May
 2024 17:08:41 +0000
Received: from DS0PR21MB3863.namprd21.prod.outlook.com
 ([fe80::b7d2:74d2:a9a6:4a6e]) by DS0PR21MB3863.namprd21.prod.outlook.com
 ([fe80::b7d2:74d2:a9a6:4a6e%4]) with mapi id 15.20.7633.001; Thu, 23 May 2024
 17:08:40 +0000
From: Chris Oo <cho@microsoft.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Kuppuswamy
 Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
CC: Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dexuan Cui
	<decui@microsoft.com>, John Starks <John.Starks@microsoft.com>
Subject: RE: [EXTERNAL] Re: [PATCH] x86/tdx: Generate SIGBUS on userspace MMIO
Thread-Topic: [EXTERNAL] Re: [PATCH] x86/tdx: Generate SIGBUS on userspace
 MMIO
Thread-Index: AQHaq4POpB86nlvWk0KLe74GGBU5r7GknPgAgABzPFA=
Date: Thu, 23 May 2024 17:08:40 +0000
Message-ID:
 <DS0PR21MB38631CD53B4355E576DAE385A5F42@DS0PR21MB3863.namprd21.prod.outlook.com>
References: <20240521073505.2190633-1-kirill.shutemov@linux.intel.com>
 <38dec9ee-1dde-4b3b-87c7-a65161d4a015@linux.intel.com>
 <ngl63zhudmeskbcga3i3hsdtensd7bfoztnsiu7yj7pxbyzx47@tj5szegw6qrd>
In-Reply-To: <ngl63zhudmeskbcga3i3hsdtensd7bfoztnsiu7yj7pxbyzx47@tj5szegw6qrd>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=5afe96b0-bb71-442f-ad91-fd850a5f2341;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2024-05-23T17:06:56Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR21MB3863:EE_|DS1PR21MB4178:EE_
x-ms-office365-filtering-correlation-id: 351d6079-e579-4306-1d65-08dc7b4afe43
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|376005|7416005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?EESlB1VVclyLV184ek7bmCvd+TTaRXmvUuuP2TXC+lTi2hx46YNjeYguMZom?=
 =?us-ascii?Q?/60EiisccQlsdJiQZAz9xXF3eiklWtPhOhw2ZakSXWFb5wjhI7R/DWXpbRGY?=
 =?us-ascii?Q?OBNGxNpSdBW/BZvkc1tl9mt8siykgtqyHFvhgTF0r55jeVUtJcB3JPTgS7RO?=
 =?us-ascii?Q?6doprKCvxRrXoFGYbIHGpP8xueohmN3ltt8TGa364nX14IOoL6aSfBRjjOBT?=
 =?us-ascii?Q?liPLGWh2oXV0Vik9GRy65c/WBGc2dTR77VPZaDVYgjUacn2f0cWuN3V8nrdo?=
 =?us-ascii?Q?IC0ivg5Wm5URdAlZEG60kt/nFv0hGF7T6VRlhHpCUAC6BYzPre+w4RCqw294?=
 =?us-ascii?Q?Z3X+TRbsC5H6z3RGNzuUeKKJ2tmVTZ2wajZ9QLRwkWsos0pYC0HY6bZe3gjX?=
 =?us-ascii?Q?Ci177/WoAjprTRatzHChqdR1EiY1qJuYMZgztrEevRJABawgkxPEma3YzlDi?=
 =?us-ascii?Q?ZRhwqJTWZvWFyDPg0F/MH4moZzXaPjsEuYVooIXWNvfpBZEXMVoPgYBSwjTl?=
 =?us-ascii?Q?XR0mh31GatOW1QzQVqafT+te6qAk81JXUT9+pXwz2xehKLcwOKW+cJxR3s9L?=
 =?us-ascii?Q?qHvSz2VBi4lmOizR8d7zIgx0jGRTrIIWiIn051ku9Sj8AZs/AggRByh6988C?=
 =?us-ascii?Q?09714jd3O5m5trQWKqVUsXqi1JIMOR+JfsAdURhosMVbxTt1yVgw5qSfR9/o?=
 =?us-ascii?Q?IlBHnvGWTXwSZxWkcBo5SONDFvxxQLbxNDlfoa9ZKoVo4ljY6HSpCK8qIfJX?=
 =?us-ascii?Q?avF1xWNkSrl5RcmLzamqbeNIWHsyN5B9V5Q6KM5yXrYbXA7qtJAEf6+k41/n?=
 =?us-ascii?Q?4vjFZXBh3kw7ZJoIQbZaEIQ/iST/MWWLL0I8aVxGdW72/5NjN7prgi0QWRmV?=
 =?us-ascii?Q?J9MPbfdRen/z1ECnrC9+rOcxBwFxAXLjlqQYS3Wv9X5j7yf0mhEdDRA02Cqb?=
 =?us-ascii?Q?+N+hC2EnD1Z/WwBNtK7N+tEWS/TuAaJhGEBkvT6FMgCtKiKP589xNCYKoc2I?=
 =?us-ascii?Q?TzvnrupXi7TjRnmNmx2az3X778ij1ZhOtcMnIRVIIZSh8RVGpWtaPPuXqIxL?=
 =?us-ascii?Q?L3bXoYkv9/mCItj/JDlfOfOcZ8rlXPuV2CRjRj7o78MSWGYylTR4fz/R3ScZ?=
 =?us-ascii?Q?k8F8ORGu1RTihlM+rdP3rT0Qk/G5Zc59BxV3eJdCVkZOrwMIPl7Hu/RGFOW8?=
 =?us-ascii?Q?4qJIyGHz7AR2gj82Fq44MRf6F8Hgm584qbQPpF1H3XGcQ8c3dnqkT//kj+Tj?=
 =?us-ascii?Q?cWQMHEny592bcS7r4RpRQ+twgzHLJxmLybTGVzxZNgf+sXfgUzbkmJcjh9FE?=
 =?us-ascii?Q?w91F6TI8+4QJuLpmU5o8OA9I?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR21MB3863.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?joXxTpnkjZ196Qy6RQHBEKpsF2sZTR5B4kXMs/c7/GK0T3iPoJVssn4/Y2fu?=
 =?us-ascii?Q?9Bf0MaM6Xz686aA3pKX+rknols7xyz561UxaOpFpBU0cwFH5s6cqUeMgGCVQ?=
 =?us-ascii?Q?SrSteSx8XgHfiMgVH0JJxblGYdAt/oOdT9RQp1hUrLiKswzMfaN4s/Ivfqcs?=
 =?us-ascii?Q?BYt1Qj/CVqyR4HkfmQwr4zFnN+rXNCY8Kx3NNOuvMw2sOqr3rXK1mVGSWfsZ?=
 =?us-ascii?Q?YHuujqDRts3v551SNQZlwF6UX6JbZSmMp+yRTvWpJayWKThbIH1j2NDTKitI?=
 =?us-ascii?Q?qDBoQMbJQ+YlcGwlM7nfTHHNBgiiVp5ggxYJkSu7q0xhrPH52D0hngvNBOub?=
 =?us-ascii?Q?eYig5veGiZgOD/Xvca/Xut7VWANzRDEM3vmh34f920WcBcQDLJBawmenedib?=
 =?us-ascii?Q?3RQ7jSpXDLC2ox3IFQvFjOF/43HtexM41HxSv2PIsbce8sHEVqn+4358qBAk?=
 =?us-ascii?Q?CX29sHrsIqpLoUizQIk+6+E3CEM3vxFv8KW9tf9Q08hijt+xZDYLopVwidJI?=
 =?us-ascii?Q?0jm0KdjS67y9OJpugTbc6WMSO8RppO2A3KV3E9E/QbRNyt0+VmIwg6H9SYfQ?=
 =?us-ascii?Q?6JwRTVT/iCmoieO74rqbQ6GNooxghyzQNbk/8CUBmlS/+1EiodLntveTKrHd?=
 =?us-ascii?Q?L7FC4oGbODE5m4S6+pvzI1Q8InrDQ4u5bAw7IeAPoYc0dfOy2HzZ1icwgmfd?=
 =?us-ascii?Q?SXHI/nxcKCHL49P7BOc7lHeupHQLWCeq5xPVRtEwGvyB1iq6K/OtpoNhnafq?=
 =?us-ascii?Q?NsDYxlNV2pYrDf5h1YARfGMgBAHvdyVpRlrxIK1AhzrAmcX5vzuWNNnQdPlM?=
 =?us-ascii?Q?/Sc4ledMhKdMDCO0pPACjuJrARBEXhzcFSEfrJQwdZ1HKQf0psKrra6kO3TR?=
 =?us-ascii?Q?NgjJ84Zqpa+A0XCKSM5h51lc3tYNZTyrHl6v+uCws92SxtmD+JLanPaOQKTj?=
 =?us-ascii?Q?Ool35rCP97hVEjcgjDuOBwL4VoZGS9Aq8Xoj+raOcT931PTV5q+rupr9pGaf?=
 =?us-ascii?Q?19fHGt2qYY6NwittcqjGJ/nDsNTWvexFB7AIphg3Ee8CuRfzH3HTKYUmVwWt?=
 =?us-ascii?Q?4YJiUcURXpEHqUPCQV6tWGJEDkNl2Jj0BrVPLe3G1bnbSEzK68oQe+07B+Bp?=
 =?us-ascii?Q?h5VHfebevtVYssLAm+Vsv02p9Dn3N/zn7tANBAKHkBHIM+uIm2E2AJ76irH/?=
 =?us-ascii?Q?Kg3y3Y7T03rjVqkoWDaXn/N2oV/ZYhDUzM0UB5w8DSfrNYStRQ6V3ykMv/XC?=
 =?us-ascii?Q?1XIfV+1hwsHkfHvz0qxzCR4te1U2xf0OdfVS4qNk+aHgvNTMhdpR4mpTnz+R?=
 =?us-ascii?Q?DJ+vMEtrd+Xv/JFl+oT0UgMNJ8AuGUIGc7DWQ4DQbcd5FFQZiqaP13+kNMW/?=
 =?us-ascii?Q?qbl3L5ArNp3P4hVdOZtywOGYCojYzhcAdDPPQyDmQc6tmQ1fU3gxKjoYyunN?=
 =?us-ascii?Q?CDfq7rELW3oviaCXfyc/JBAXNDtHwkZTb/Lej4MxKQrNN7jnOVq1LCSCcvFQ?=
 =?us-ascii?Q?WyldfNQTZv4A3d3hySHKDEkP0M8SrKmChxtLpKzWyKGvVfvFA27vm/XLMFnd?=
 =?us-ascii?Q?t8Ut20kq8AMXqw+vrUA=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DS0PR21MB3863.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 351d6079-e579-4306-1d65-08dc7b4afe43
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2024 17:08:40.3096
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wy+OCTvfZjjtREqFC0uglRYtij/4uQewg5az9SNkNZ2pB57W9UirsjfQRIYRZ3zHfzOXCPAN2ZgCakx5siQCug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR21MB4178

We use this to handle MMIO issued by userspace that the kernel does not han=
dle in a #VE, for devices assigned to a TDX VM.=20

Chris

-----Original Message-----
From: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>=20
Sent: Thursday, May 23, 2024 3:15 AM
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>; Thomas Gleixner <tglx@linutr=
onix.de>; Ingo Molnar <mingo@redhat.com>; Borislav Petkov <bp@alien8.de>; x=
86@kernel.org; H. Peter Anvin <hpa@zytor.com>; linux-coco@lists.linux.dev; =
linux-kernel@vger.kernel.org; Chris Oo <cho@microsoft.com>; Dexuan Cui <dec=
ui@microsoft.com>; John Starks <John.Starks@microsoft.com>
Subject: [EXTERNAL] Re: [PATCH] x86/tdx: Generate SIGBUS on userspace MMIO

On Tue, May 21, 2024 at 06:35:49AM -0700, Kuppuswamy Sathyanarayanan wrote:
>=20
> On 5/21/24 12:35 AM, Kirill A. Shutemov wrote:
> > Currently attempt to do MMIO from userspace in TDX guest leads to=20
> > warning about unexpect #VE and SIGSEGV being delivered to the process.
> >
> > Enlightened userspace might choose to deal with MMIO on their own if=20
> > kernel doesn't emulate it.
>=20
> Any specific use cases ? Like who is using it?

Microsoft folks wanted it. Chris, Dexuan, John, any comments?

But it is generally right thing to do. SIGBUS is right signal to deliver.

--
  Kiryl Shutsemau / Kirill A. Shutemov

