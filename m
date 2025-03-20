Return-Path: <linux-kernel+bounces-570174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B3FA6AD21
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 19:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E7B2189B230
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 18:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F24E226D1B;
	Thu, 20 Mar 2025 18:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Y5IgrIS7"
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazolkn19010002.outbound.protection.outlook.com [52.103.11.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BDA226D04
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 18:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.11.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742495360; cv=fail; b=PyeOkV9xIzvNSRTX5qYLI5D6bv/47Pv+8vDJSbQeK8US6n5zUtk/Do9Dm4LMuZ6kivF3HPE1YPqzv/KABubi62V6pDl/iidWOx/qwzV3XoCRPkmRPl5TicR4Vd1wiUwz+//oGLanwD41pSEUeenzUWNGj5h2kTOHitPVpZf6qp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742495360; c=relaxed/simple;
	bh=96XN09L+II/nrYdGcapeFhp0XABjqMqdjym86kkLgdE=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=EyReGYUSM4CHhbX6/AlA03yf5oicMCFepH4GeLTDJnh9BXLgDQw0916fIWwOSVn/HauXFYTOM36lJT7B2GVwPSR1sR73o4jK3WyFKu6YdVmSHT4JnLPT9EIeS7zwW8SxkIidycV5wA2PysT4PtkwWeOXeWR6bM3CGYgmRvPZqlk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Y5IgrIS7; arc=fail smtp.client-ip=52.103.11.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nlyv3N9gv4USMeM6+kc+oyMWXcHJpLNcA74e2uGpRF12vyLtreLXru8WBX37kZXpQLD2ClkWDlkdFCVMEV3e8oMjMWvnZDqJvdM78m5h25uLhKtUBH6MlOUZ/OU47NJpYu4Rowyk7tIgD/ZuMvB/0J5xJLKhuTyjIZrid1OLLVV889mZqpDMrHnioSsj3hhiNlvBz01W/WOD1wMp7YYNfCog80/T/cGiOpyIq5ypylXZ5+0O9DJRGo26v2Qo8wi7uq3CZiFElHWomUzelX6JcB9iQos7hkR4LxC0VKijZ9WZmBwC/Az9AS8aYw96k7nXdqwXZbmxhIv7Jgjgc3/QGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qJvftH6zfBJQIzSKXcSEx6fv/gzM+fyoeUPSvf9Kz1Q=;
 b=OItqBEms5ahik5xgW54s8u1fgx9Ucn+YyBwu1ZhEzB5tHz38QJMJ5b/1GxvkgL+IPM8mi0kuPmJJfVZY2BTm2f/gytETbjewnZgGiF3BtFpmIk0XmiMVj1urSooq7WspSIXrU+S3ezQLNbw4sgN+xCvMWa1IW0vauLR4Q04Bzky7YoYZ8jedIP2sdYKN/uatuGWyY7v0hBD6cQBGYoJ0odrTRMcAPjDn3h6RKhoyE6ZKUUw2+trqtAMBP+GY2OngEtJcrRUBLldzeTfAT1TzBv319fLLMxMCdPXgfY1MVD8c+fBB8w7YQ4pewClU9h5J3Eew7qvrleZ5zsRvFht/Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qJvftH6zfBJQIzSKXcSEx6fv/gzM+fyoeUPSvf9Kz1Q=;
 b=Y5IgrIS7duhMZmhSVXV12pjgXxXr9c0KBGcowDq4B9lb+Xzbt3x/KgmiypA6wumjLvxtavtdxcbYZT6a8i6Fnz4FhMyMb1q1QQmXnkWfkI6hoxVBXEwkNwa6DWgiPVRNN0beB23H+9jXd2XLVmC1xPD5xS953Wxp06XOuZA55CNit4RxyM9o+HU5/WfEGr7vG+LaEMB+QyFYSwZLzL8pC2MLSjGU4RooG8tKlwK5oMWGIdFoXQI440ujE1vA9BJY8SvueLAWm6FwrTOLzFA+CSUVLjq279V1hma9p0WlXIIGjyLu+Ibz8bnuNQ3+BaaMfmCLkFdCS8Adammt2Tmqvw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SJ0PR02MB8402.namprd02.prod.outlook.com (2603:10b6:a03:3f2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 18:29:15 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 18:29:15 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: "brgerst@gmail.com" <brgerst@gmail.com>, "mingo@kernel.org"
	<mingo@kernel.org>, "ardb@kernel.org" <ardb@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Compile problems w/gcc 9.4.0 in linux-next
Thread-Topic: Compile problems w/gcc 9.4.0 in linux-next
Thread-Index: AduZw3CVEeBLGArOR7mAlPxdXuU1qQ==
Date: Thu, 20 Mar 2025 18:29:14 +0000
Message-ID:
 <SN6PR02MB415723FBCD79365E8D72CA5FD4D82@SN6PR02MB4157.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SJ0PR02MB8402:EE_
x-ms-office365-filtering-correlation-id: 396891a9-4519-41e1-5f8d-08dd67dd1e4b
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799006|8060799006|8062599003|19110799003|461199028|56899033|102099032|3412199025|440099028|12091999003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?SUUu4Q4kXVTkHUK63zMp2pLqM/GXM0a/kb4se3/cAzEUzWLbkkipCmQPpXH2?=
 =?us-ascii?Q?Ca9tjjnHcr4U13bMj/ODM101Ua3xww3TAgfFTtrgUBzjkBnb4JwQeIK6wcmO?=
 =?us-ascii?Q?vZIHVM49ex3LJPvvAwYcY93dlMM0wmLUCMmQsDG6NsBlfCz8BmM5shZeW/ME?=
 =?us-ascii?Q?+Oqf1WeWnNTZWgsKlOj741i7J3MeHgnNMR51TJL3cYWDHMCIH3yR2TdO498M?=
 =?us-ascii?Q?+8bw4lFW1+vpkWcgkjafKXKTOZDF4LrDzq0WTdT5za07brZ5dDQ076gjnRYZ?=
 =?us-ascii?Q?gQLJU+pzAuo8Z1I9N0kE16P30pTLyAg7J4lkE88F+EPSo/LqS4VZLHOL34FT?=
 =?us-ascii?Q?V5Q+uYp/+Q4zuhRNs9r0hzCXsx8Hp1sfdrTYNWPT5tajgIHysG6TGhU+qEt+?=
 =?us-ascii?Q?BVwUMH3D/UUTwHrq26E22VEFpkI2jGhoxBobJrK4MAgM21VV97Wb6qUFtQy7?=
 =?us-ascii?Q?ycuQ8FWnIRv78vqAIctjbiDG+cB7eyYv5c4zQeiL3aFbEiB3pCUKk+n/wydn?=
 =?us-ascii?Q?Xi0LDVaYi5JBjQgyYEuvuNHjR7jPhc1iiKVwU7pr6N6rf5u/IE0CMZIkV/+u?=
 =?us-ascii?Q?7zOXmON7Bz9JnGB6hjblD0EGDc+CKHd6w00/wH444WYDkCIJDaJ8VEPB+l6h?=
 =?us-ascii?Q?eBpLDtwGJAX7bdjczK3OZWYo4ZSSacF2zNS2qj1fqPW3yTK2gYT8GWFjddJR?=
 =?us-ascii?Q?50yOLKaGZvzvunM0r0mT4fh83BiJllZJkDtRV7eE4KQJYKPW2C11LUHlGF9Y?=
 =?us-ascii?Q?epfduN4wsEu632YcmV8sRVMz+F1FRZbdzvSvrtAscchDuOEv1vLKHk5gCo9q?=
 =?us-ascii?Q?3brsvypQvVD/PLXV6p9SWjS4FRdGrdtyawWp9c8mn+ukzrHdwmAh3rbu2q5/?=
 =?us-ascii?Q?8/wHoB49ILvEpdHQoNBeV4MHJ9I+jhmkvku7Hxi1EgjCzjMkR9OPwBfn3Pwz?=
 =?us-ascii?Q?dtjErGxjqPtYe+1TOe27XHsqWD1yKt2dAQ583hzp15GIjHYQW8UfN8eXwKR0?=
 =?us-ascii?Q?09UvcpxM8OsoneGG9hCOB23MoqScSwU5T2PzPAHpKA7apWkXUY8kx7YGnYMp?=
 =?us-ascii?Q?PPk16U0ZpqIqwdlhBzGVjeV/RgxSyBZjjmFeHzn9u6GPhibHKyFBzRr6i7eS?=
 =?us-ascii?Q?K3PYwV6NElxI?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?S4Ux7wWyHZctoEHJPwENxE7L2n+Tf54P2UMpOn72Lyw5eNomogSwCkx2mDVR?=
 =?us-ascii?Q?cKW8seYHh4B2f/VraEwqt6rwMvhuYXMYnI/NpvOzw1cfnSE2fo9Hg30J1Zss?=
 =?us-ascii?Q?OQgr2BbeR8wxAKM5L9tnHFYJ9LJRl7899rkCXkKhBlW9JO3YKgB/9BSG9UjH?=
 =?us-ascii?Q?m7pDBr+tmZlexxGpmHTo7mv2d2qSysNxnMzsfDrxrW30C5NgnLu0zgL1762U?=
 =?us-ascii?Q?O6CNr6QC2gm7Jdoo/40yu3Cr/cqaudRbGVV3zJePTID5qOfY0dAlpGbM+Sgt?=
 =?us-ascii?Q?k52J5jsZ09uXpnMnR+vQWdkEfVwKA5NCW6eTAXgMmyTCtaB+yayrvS/BeSuD?=
 =?us-ascii?Q?VaDpgd+xWa4Jyvdvuwm6b6qseaV4h6QaD8usrEjblQNbimvBJekdK4Xh9ASZ?=
 =?us-ascii?Q?uWQ8n+Jc9R8vuFj1pCk5YsfmUfunLh5BbKuQQVMwmZ57lzThEJ2Yv7vcWfuO?=
 =?us-ascii?Q?K/VwpscWyaixsJRSTGgfaaT7t9Fqf4H2AnZZ6sgvvnOD0oxsoA2xttwk6cC1?=
 =?us-ascii?Q?QGUg/f1Z3SJ8hfDPWI26e6R+Oa86lz4VFX3/wWLluy1snKX+62g6Yv6KDhX2?=
 =?us-ascii?Q?kSx2Ky5Zv+zIErITV4HK0KM4CRw7G4/G7iyfU+7sHsupD/1opic25lmduAva?=
 =?us-ascii?Q?DoCopX5Tsnjs5hOajkFVa7YkFAixGhr+nDASVrswbeA90z/gClZudwQeMhVK?=
 =?us-ascii?Q?mdqBalxgJjp3DGIZ3/zjSsypM4EDTE/YIqWD9hNHQIJx8N+6PyXjCjJKFg07?=
 =?us-ascii?Q?hkDQEOi8kO14PlddtbpTlvYmwSWeR31J/i+MU7mJvpJBzsAg9OCL4tvr+5/4?=
 =?us-ascii?Q?CTBeaV9VjAMWzyxJc02F3zkpP7Mw62ISxF8T29KzTLrgBjMfuIIT9Kc0bRGW?=
 =?us-ascii?Q?6kY/mVVfxHWg2GyRk5VZUGA6HATKHbMDa3sYWAYUqARIm8o4QSmMmvtnC2at?=
 =?us-ascii?Q?uTlS+dUHvx8dszZmdp29BzH+2RN0k5hx9ntikWsKFV5bWaYNhslqAFKSo1aT?=
 =?us-ascii?Q?T4phTQ2IuY+fskMcTLe8foSJ84oWOtoBHZHOY9326EzjbHbhl2rsRzWvq87k?=
 =?us-ascii?Q?swhaotdhq3D4G6RDl/riVy8O7k11q9f6p8BjSka+aUoYVUM5OsbMnObQ8/bz?=
 =?us-ascii?Q?+fOTaRRhUHli3rIEVZEEILUWuKhIOgeV37+Z0VQeK6zEIuIt2hqMeuhpV/P0?=
 =?us-ascii?Q?LW0i0Y15SoDYQBoeHk9LMSSWoFU6cn0EJzL+3amE+WW/pB1wWiL68J8MubI?=
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
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 396891a9-4519-41e1-5f8d-08dd67dd1e4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2025 18:29:14.9724
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8402

Brian/Ingo/Ard -

I'm seeing a compile problem in linux-next-20250319 with gcc 9.4.0. I've bi=
sected
to a group of 6 commits that you authored:

a9a76b38aaf5 x86/boot: Disable stack protector for early boot code
f58b63857ae3 x86/pvh: Use fixed_percpu_data for early boot GSBASE
cb7927fda002 x86/relocs: Handle R_X86_64_REX_GOTPCRELX relocations
78c4374ef8b8 x86/module: Deal with GOT based stack cookie load on Clang < 1=
7
80d47defddc0 x86/stackprotector/64: Convert to normal per-CPU variable
9d7de2aa8b41 x86/percpu/64: Use relative percpu offsets

As of a9a76b38aaf5, everything compiles correctly.

For f58b63857ae3 thru 80d47defddc0, this error occurs:

    arch/x86/platform/pvh/head.S: Assembler messages:
    arch/x86/platform/pvh/head.S:183: Error: operand size mismatch for `mov=
q'

As of 9d7de2aa8b41 and later, the head.S error goes away, and this
error occurs:

    lib/zstd/compress/huf_compress.c:1033:1: internal compiler error: Segme=
ntation fault
     1033 | {
          | ^
    Please submit a full bug report,
    with preprocessed source if appropriate.
    See <file:///usr/share/doc/gcc-9/README.Bugs> for instructions.

Interestingly, if DYNAMIC_BMI2 in lib/zstd/common/portability_macros.h
is changed on line 61 to always be defined as 0, the compile problem in
huf_compress.c goes away.

I'm using gcc 9.4.0 in an Ubuntu 20.04 install as it's the standard compile=
r=20
for that version of Ubuntu. I'm guessing that getting a fix for that
relatively old version of gcc isn't likely. I have not tested with other
gcc versions.

Thoughts on how to proceed?=20

Michael Kelley=20

