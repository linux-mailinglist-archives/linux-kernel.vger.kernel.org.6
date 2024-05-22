Return-Path: <linux-kernel+bounces-186481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 672518CC4B7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 18:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5101B22B62
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 16:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3AE14198A;
	Wed, 22 May 2024 16:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Uaq/GF7R"
Received: from AUS01-SY4-obe.outbound.protection.outlook.com (mail-sy4aus01olkn2169.outbound.protection.outlook.com [40.92.62.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B27D6CDA3;
	Wed, 22 May 2024 16:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.62.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716394298; cv=fail; b=fQFHcESfk01WN5I0dtvU0AEXS3sDHhFJSlOIYI/34eANcX7jQzltW4YGAGBMwFjTgelfN9bkvQ5XaYaBUjVez88FyHNML5iSMeqtUbF8AyPlG4UZbZPH3L55eDqypT2EjFZRsOO+w0e2LRc1EefDQ6CWPH8vJL8zRCSOdG5yQ6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716394298; c=relaxed/simple;
	bh=KXFjCYbp9xs4bWdwZp5uarbw0wMWe6eYSMre5zg7XIk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=k6neos09EtwTqE9MoHmpOtAYPnCpFNHK2jcmiEm9JD+/FGLhlO1B2jJNlt6XJviiTD/YpOEeLodx5bQAC8GHLazqwW3XveT5GtzslLsqh+bm8mDHzDoLBXuIcKgz1rMU+C61fccnyO6JIH5NjTNseg/I2pp5RMdq74/MDD8EXgs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Uaq/GF7R; arc=fail smtp.client-ip=40.92.62.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qy+6wIPZbJ7XLFkvjTBw0gI0JzFIetjiDbjt2tihCH0kQAdJ/G8ltn8uZCNCUEPQe/NnJ991uSSOqiBU6R89+2PX5DQf9zPnJdGpHlxDHYImBs2/3dOLiAz1QzEqBInUel+vJRmJ8qVC/1EZl4tj2CcL/t67mrK3QmERru8wPkO+XGVJerwn8T4WXFrw8vy40jIO+neeWVNOhQLL+6ixBYLHMJ+Peeqaz/KqJdxcb1nHk+9A19GDHfTBV8tEOjlXtvnCNCHcD9MXeYbKFUEc5t3aAC10MT4A9nSupOnpWcFZydPSPqVoMb+dFXXE393GyIL+DGbiisOulZqJCS7aEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KXFjCYbp9xs4bWdwZp5uarbw0wMWe6eYSMre5zg7XIk=;
 b=ITyE3r3zSgj2sB7nxF9H1HDs0mt7/VTReOgwMvZdQkj9+doZt1zQreDjrbv3hz5mo2qVLsaEv3i02SwaCaIoe5J5BUeH1f6W+XUBvK/4PZfYGk2/VSVIn8Vt/iFyxE1GWlxefCNoEkVKjUAByX+HmeFqAcv8Q4WjqYaIHnf/NgKR2Ho/BTG72w3g6d3A7M+bRKYyv24NiVEFyN0tU2vdp6E8sJPj5XA/r/29bMaGNmG+lw1KEP15QjURtMLHGvAolztYuQlogxYKaahpgRRNNkoz8pf44Yt10TTYYmzDgkv62V8ifRqrLuGdPgCYGb8ZE7e2g9IBZw1LuHBtQ3b3Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KXFjCYbp9xs4bWdwZp5uarbw0wMWe6eYSMre5zg7XIk=;
 b=Uaq/GF7RQ7bNX7sUumd82iM42Q1tBjSvbYL+WWioKuNZTcdQamMJq+YhfWHxE1WyHufWG0PtZpHtN/jzGmLrTwoC6lIZX32vUhlaYEb8eMC8B1ndnVFysUCekDOWpy4+IpGdw0BfMqTmTJQCnQ44mX4Hz6eHi5FnDinDg/wC9n38xIzk1usuANWKGzhpH5E3RPSfBKJSn9hjroXCnLpfk27IwnhJmNvKf8EnNFkdgzOKtLrB1SV7H13b7yDvApbP9usFONWch0+0k5z2fYqYighy9rLIhHi570brkzo+yR/YNpEIBnPot4jo4zLO/SlvekKFNmhxTBkcDi2BRlNELg==
Received: from ME0P282MB4890.AUSP282.PROD.OUTLOOK.COM (2603:10c6:220:228::21)
 by SY4P282MB3710.AUSP282.PROD.OUTLOOK.COM (2603:10c6:10:1c2::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Wed, 22 May
 2024 16:11:32 +0000
Received: from ME0P282MB4890.AUSP282.PROD.OUTLOOK.COM
 ([fe80::d384:a02f:2370:f33e]) by ME0P282MB4890.AUSP282.PROD.OUTLOOK.COM
 ([fe80::d384:a02f:2370:f33e%7]) with mapi id 15.20.7611.016; Wed, 22 May 2024
 16:11:31 +0000
From: Roland Xu <mu001999@outlook.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "ojeda@kernel.org" <ojeda@kernel.org>, "boqun.feng@gmail.com"
	<boqun.feng@gmail.com>, "rust-for-linux@vger.kernel.org"
	<rust-for-linux@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] rust: kernel: make impl_has_work compatible with more
 generics
Thread-Topic: [PATCH v2] rust: kernel: make impl_has_work compatible with more
 generics
Thread-Index: AQHarF8coE4PoIOd2k6IcQOC1yqiIbGjaL8AgAABlAs=
Date: Wed, 22 May 2024 16:11:31 +0000
Message-ID:
 <ME0P282MB48903BD06ACC00C372A9602ACCEB2@ME0P282MB4890.AUSP282.PROD.OUTLOOK.COM>
References:
 <ME0P282MB489023110AAF1163F0A4B2E1CCEB2@ME0P282MB4890.AUSP282.PROD.OUTLOOK.COM>
 <SY8P282MB48866A68C05C6444F0340A00CCEB2@SY8P282MB4886.AUSP282.PROD.OUTLOOK.COM>
 <2024052258-trifocals-engaged-8d80@gregkh>
In-Reply-To: <2024052258-trifocals-engaged-8d80@gregkh>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [W4uqE9M4emq3hq2Ni6AwIobktTl56Q3769W7wgfQm9w=]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ME0P282MB4890:EE_|SY4P282MB3710:EE_
x-ms-office365-filtering-correlation-id: e3cdd099-bf60-4a4f-a798-08dc7a79d85c
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199019|102099023|3430499023|440099019|3412199016;
x-microsoft-antispam-message-info:
 Qr9hFGK36dIHbbC8aEU8yonwQNpDYSuO13W6c41FGhXYbQx6F6y3hfkG+1yf+6p46Mld5i1cDiiY98VlXf+8V5vy/8EliHxOoach/1yHpUdJEt6FEhNb3C4dHqJTi3RZGGRO+sSWv/0tx+Zo5wd6MrxSHM0KbGN+BsDo44zflCTwyrnYl6v7QcfFpVEu8V6U7DgjTpoado88w00uiyEjzViz/df9QFYGeGseiKUnn8SjrvLDrflaCpHczUkkTKoYr9K0vEbh1nKRVD7CnZP5G2NdJY5509QRJpvl7BSpOCV3/2XtTyypAFyJjt1+x//Zzmv4/AT4VJhHGgC9CDTNBLZ0TJk8u3CYIWdo/TavO0AXi3j/JYCWBJOSJXljrxG+WRls4v43CXDM6g/wTNlol0W77uFOIJkE+Q7oVRaudn7eFGAeYDeEsftRRT0evaakoQDtGb3oZx5/VB5eTLZ+TdlIsxk5dRnIahcNW7KUOywrJbWIcTq5MkbKRIc7tj0Nvpb3JLO7xk53edMXo2dS4i9r659+n75Sp5ZY8iaCj5KnXPnxzo5m+CXIXOQfS/rV
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?lYgzBws4Gs53ay83WtXQh2spjqj9iaIonlrSBbg8QG5zTjuHk9TQCtENdHwR?=
 =?us-ascii?Q?oCKcxCPbod40H/UT/XRXKq3BM4biav/tOY5APBVm36Dgadiaq0ocOIHifPsS?=
 =?us-ascii?Q?VLlUaBxwlCB5dXaHD5xkXAy2SsGczOFgVWan86Dv2nBBUiuPoQdUuWiHfPyf?=
 =?us-ascii?Q?r/DuqB7mkADidQulfRWfnQYPd/oR4Of+S7fNXHbbxSeG7KU1FK+xOSx09tD3?=
 =?us-ascii?Q?8tL5ilGkApsyOx7YFmnZFwgCH/YTncmT2uEzq0aJn8IghpZ1E4bPdFigtpCN?=
 =?us-ascii?Q?7Jf7/cvfCvKA2KZn3h1f2rTNaSmV/wXV8BlVNEy1O5Z6w2u7o5sOt97CdH1v?=
 =?us-ascii?Q?OKeRHHHkSL3/aLCiEw3uQ/8UOOp2jiPeO4vH6ND/R7LOPpKpmXm2vuEU7wKn?=
 =?us-ascii?Q?1jPXPtDXFNiKPtUr1rXhb0ktPMJ743UVzhdiG/ehTuH5F8NBXBCitQeUV1FG?=
 =?us-ascii?Q?ash0BsqSyF4wwOz0uAZ5tP6bPz44HrlorDLb3HxqY34pLWSd/XSsqh61Z47L?=
 =?us-ascii?Q?VSIU3Ke9wvAYt1L3AYHtk9M6PhTDAO9ryJs608jjgzTdgwAEo8nrnGLm9HeI?=
 =?us-ascii?Q?t415gySwUe6JOfftitsjiKWRl5+ILEIp+RUm7skRY0xO24Z/jW9NUs7HnnIb?=
 =?us-ascii?Q?S2XvHTsOxaDsagDeZvCuw8eFUChtAJubLbAFPpRtuhNtVyfswiV/134nI5zL?=
 =?us-ascii?Q?Z3XRUn16oIrtvuqGhYurNLuy8bbA8mb6OecJ2cjAwj/cM4yWWBh4Ao3DqgDo?=
 =?us-ascii?Q?GLWgjuBFKYK00tATrz2wcwsXAywLUdEVVb1bSrW6MRrmlh7v1ihNXUNOXn/c?=
 =?us-ascii?Q?yQlwTQ+vZBWFhC6OcwgiDmmSyuF/DCTcQbSceY9VtwFfUBvfg6S3JnwIEU6v?=
 =?us-ascii?Q?R3+RqCj5SXCTaT/BFfYjVTuGY8qx0MdVoRPdCip6ih4uohIxOAQXkajIkkxl?=
 =?us-ascii?Q?2ePEXspK6sKp+Tm5cieKIh7SFxfBTew0uY26+LXRD6xMgl6s0Orog1pzSdn+?=
 =?us-ascii?Q?bgEUHoQmn59UbLSb4eQ0U8hAgjrQMhEuJ+Aqnctu76N+QVNahhNOYFHiOVSv?=
 =?us-ascii?Q?jtLNx5PFwQZYTisDdMG+9dwgqJBcyHg9SPzFpg6ifgcKoWIF8XDWeEQxiVj/?=
 =?us-ascii?Q?rxz5yxfufZzABCL40MF3sgulSURoB6BhIh++kchd0b4b4LOPjpxLKYuGpmEg?=
 =?us-ascii?Q?zu/LpRtPieecwHHihqIjtVgsHs3tZpgwF+1xHkLxOGESHZGrWMz2XkgkJuc?=
 =?us-ascii?Q?=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ME0P282MB4890.AUSP282.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: e3cdd099-bf60-4a4f-a798-08dc7a79d85c
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2024 16:11:31.9261
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SY4P282MB3710

Greg KH:
> Columns are still not wrapped :(

Oh, sorry. I used `scripts/checkpatch.pl` and it only told me the commit ti=
tle is too long, that's why I only change it.

________________________________________
From: Greg KH <gregkh@linuxfoundation.org>
Sent: Wednesday, May 22, 2024 23:57
To: Roland Xu
Cc: ojeda@kernel.org; boqun.feng@gmail.com; rust-for-linux@vger.kernel.org;=
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rust: kernel: make impl_has_work compatible with mo=
re generics

On Wed, May 22, 2024 at 11:45:33PM +0800, Roland Xu wrote:
> v2: apply comments, wrap lines at 72 columns
> ---

That goes below the --- line.

> Make the impl_has_work macro compatible with more complex generics such a=
s lifetimes and const generic arguments.

Columns are still not wrapped :(

Look at example submissions on the mailing list for how to structure
this.

thanks,

greg k-h

