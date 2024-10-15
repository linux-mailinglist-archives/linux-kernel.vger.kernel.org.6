Return-Path: <linux-kernel+bounces-366470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF06799F5BD
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 20:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18BA91C2082E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 18:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8133A2036E7;
	Tue, 15 Oct 2024 18:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="VFSexgSB"
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazolkn19013081.outbound.protection.outlook.com [52.103.7.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038252036E0
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 18:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.7.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729017521; cv=fail; b=KwsrZrPP15uc6kgrrVQBmpNhLtFBI7umUfOvApuOp1DX+kieHDIca6dncvCbGezAP10sBd8I/2Ed8hcqFEf+POZ6UtX1QLaGWr7aup1+nfoI54wxuiY+AuRAAmUjF3qCtlAeYXp2Wokw2kh+aygOT35gTtn37kfPVMSKXIbXlY8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729017521; c=relaxed/simple;
	bh=BXiSQ3Yi0tTnKZqkA2QoSzmrXirD2ZmFHMZiM7Gzc6E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fqGbMf9TCltVwes0MRwQMRp12j2Q8W8hfPXNgCaxz4yHzS6R6NZFR7RVnJXr4ZuMvq7gFpS9PA36odmQYheh/zcLYHjhOii2NyJwz25CHU8e2gBfbsVI+3qhO2W5WGPyelGaP3EyI3JpwRDcW42xysTYVVkqK4+m5PYyVKpYLMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=VFSexgSB; arc=fail smtp.client-ip=52.103.7.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yGwT/TFUbQpu9FM5ek34nL+OHIpiati/cqevA9s/lqh7je3/vr2Ko0eqoaUzGyoeKLg4Xruqx/c4i5SI56WctpThixHKhjdaojq7Q7ULwab6KKvzkwlqQhYY4MxTi5PrRu1kH1mDDqpDURUyOMG9S4MAy8m4gsoX68fpj/4Ypi514S0PSoVraXzPrqguBjdzcChDzDxU4MjDAJ1o+1oJYS/825V0hIM33XoAXGQRsrCID9gKRjHIx2bA4uGdPaoBDzL7+8JbwBL9UgV6XtFDO4Yw2g8v16gIPKZk6OCOoB51Ma5fv4fhd0DClUX7Qf8iX41XX7R7Ju9K3OgyUxVZkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nlTnpA68u64ryTu7Mp9nuUxQJoItG/EkFkxkWVc4OiE=;
 b=q+Y9X56oyQxyyvSdJy4nTCsdWdD1j7b26SlY/5yvh8NDm50YyP3LdcCc2EO7R9YOrdFufATjoA5OxBWvCyA2VTyDwK6kkLHgs4pDbZidYC8D69TrJeoA+vmxvZ16CRVnVWNTQsqyspdCQbKrTCoDVnvrZkqzx6QembJt9LG91UPgAHnpEuJ4hn2vI2T2aUkVez7Y1UjekC8vdcXMLaiHhj5sVwp4O6Dn8O7R3GiZfpIMg9T6OmzcDAe2U79yrcfz5w7qj1sKx28rc4PhjwzmmAXKRrgEMx/PuEsPANunrtlhds1kB/p8KpwNDKM6ap1a2O9X/Kp4o0IzA3eL7jkC5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nlTnpA68u64ryTu7Mp9nuUxQJoItG/EkFkxkWVc4OiE=;
 b=VFSexgSBM8ketfpHkChfP9xRTMHrkGVgzHGr2lzFk6SIgrUVESYsymX4bg8A4fS73zQt/In6XXXnAGIGae4UeeM2Fei8exh3J8H+slzl+iUpQ+UJedtf7EqSdx2QeDILxPDIon2NLFcmMkt5EEjXCyGWhXia1jlKeiRawK0+LemLCZOQ79FaPrJl8hSKF+Nx9gGHVyFAGglcT1898KOOM2UIjQ8fV1HvlhWTy5bGYtLi5yAg0BPKpD2Xc+8botYLKZ3ZX46SKUX+yEHWt94ZXPCJxLdz/ATlfQoKXhWlb38xUM8rrGgFxqO7Ye0KHvmXVEa5Vky4SH/cys/oKCIvEQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by IA0PR02MB9661.namprd02.prod.outlook.com (2603:10b6:208:489::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Tue, 15 Oct
 2024 18:38:36 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 18:38:33 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Ryan Roberts <ryan.roberts@arm.com>, Andrew Morton
	<akpm@linux-foundation.org>, Anshuman Khandual <anshuman.khandual@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
	David Hildenbrand <david@redhat.com>, Greg Marsden <greg.marsden@oracle.com>,
	Ivan Ivanov <ivan.ivanov@suse.com>, Kalesh Singh <kaleshsingh@google.com>,
	Marc Zyngier <maz@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Matthias
 Brugger <mbrugger@suse.com>, Miroslav Benes <mbenes@suse.cz>, Will Deacon
	<will@kernel.org>, Dexuan Cui <decui@microsoft.com>, Boqun Feng
	<boqun.feng@gmail.com>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: RE: [RFC PATCH v1 00/57] Boot-time page size selection for arm64
Thread-Topic: [RFC PATCH v1 00/57] Boot-time page size selection for arm64
Thread-Index: AQHbHifr7Pi067ctQ0iGvwc5NuWBOLKIIZmw
Date: Tue, 15 Oct 2024 18:38:33 +0000
Message-ID:
 <SN6PR02MB415751CB966BAC5EE1D4FF02D4452@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
In-Reply-To: <20241014105514.3206191-1-ryan.roberts@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|IA0PR02MB9661:EE_
x-ms-office365-filtering-correlation-id: e3cf7cd7-0d61-42b8-b980-08dced48927b
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799003|15080799006|461199028|8062599003|8060799006|56899033|102099032|440099028|3412199025;
x-microsoft-antispam-message-info:
 C3EQXZpWkxXKE3GFDi9tjZaWPrYImILSi7z6MVSQHYwzC15opnUTpYsCj0+qUZ/78UEanN0lXwc8q90i1/olOYhJN2HXCdUgADyxZVvOfWaMb9hIgumnL1WZszBYsvOIYx7HBHh8oKZELhEqEiA0B26h+LZEvOXWPqtGPAbLi0g2w+KDQq9CREd/dG2gGCR92CjAksnXKmUZ/ykW/+uny5zuvuxig1EYmliNpJOSX7jH+HSHVzhCA0Gajva/Z7yELeBku6H50h+zvi9KCoRHHAtQxcAO/vogpRPFMJDYg8v1QtCjq4UAvR+dkog6TR4XfzMmreGItoelreV9QINqhGwS0PHYe8PWdqgThuTCEUmIcMXVQbWuuXwAQFdopF0665sTIPilabdD1nZ0AYA4yR0jgjcDH0/Pin/XgwdihcwRhPcQx9IkvjyuBT+e8Q9joRX8h9xYIJcJbn8bV77K1qboTyLe4T7JyEl/zQLSR5vcOZQ/S2h+xRVgF9aO+4YzxEajiVIVAJriw1HPlJj5utAQxqvV4ZMioMFK5QpxgkDb3Kc4EqjYEwzkDSZQafMlh0H/k2cDnBD7rMxP6bChlASx10mw8FFDpWCmqAf753sG9mZofUovt6LX9vE71zXqcpBx3Z+dUGHAmTJXujNNxj/u8ZC1h20cUaaXj5xNkK5SxME/Gq+SGO4TvMkY5aUJH5/w+vswaJjTp4kaJUyLHg==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?EAgHYz836ws6dWpCeSaAvGXNSLl9H/+ZkoKYjh1Zx2rNDQS6mx4p0+IecW0f?=
 =?us-ascii?Q?dlIBq63Lcp1LChRV0mdaolc50nlZaYDO0J/yUGpFhpvLzSJFusi8L2naVd20?=
 =?us-ascii?Q?s3Hs4kS7JVeCfTs/imPmgd+3W8rzSAy2vDK7zWBnaglk0vrsyY5QCtl4RPMK?=
 =?us-ascii?Q?Hel6nDCYendFDQlVQpUZbazMs+dg+TpEtlGGKN8lOd2cZ52ZaTOsocCsDsEa?=
 =?us-ascii?Q?vMZ2RME+5B/mrPWiNGHs7b9hoc3Wym9ogF9vRMveYOOU/XsSkkhLV5M51nkt?=
 =?us-ascii?Q?JrlmBO7nwJJj9D4JR3iwTpHO8LXBM2lJ2vKyNe2edmuACnnJC8geC/6AfkaX?=
 =?us-ascii?Q?NIBPPU50hxVAbM4X/ENkiaA9IWlrpA54yMylyQfcQ5c1gwuDKND/n8iePqk8?=
 =?us-ascii?Q?CCcu9/+x5y4To/ZTTf+ZBEXM9k+uIYdBM9W1WWLLT4EPy9Q855HLmiiKc7xY?=
 =?us-ascii?Q?oq2g7UPNZfUOxaXw8r4WBHYLtv8MP93ESUf8P3qnQ0rwJz46PPBBGjNetIuW?=
 =?us-ascii?Q?7Qlcv3QfWNuzAcLOPmfN1TZNOzsNNJMD0BhLrYzdiABPhqUl1XJQMLsLdBVe?=
 =?us-ascii?Q?UmqDVU24DP5vcp/jSLoSPAvJ1CmEYGlizHb2iL6zqxfcyzRKu+4H8NicVCyk?=
 =?us-ascii?Q?Os6Da2u8cVNL1loM6AHYIKFumpLXzlV4n+DCrLJ4riYZ7d9fYllAkYVsIniU?=
 =?us-ascii?Q?lCUp8R6upH7fTgxyYqFMktW8Cdq9NWH8PflVrbA2KpFXoT9jdfTcpA1YNPRq?=
 =?us-ascii?Q?4rw55BfBc3lKZxpAYDnfUW1GauBWmHCaVjjDPEYUmbVUEw4AaKXNc4H9BcBo?=
 =?us-ascii?Q?9/FvbR73+p1q7UPPuPf5aM+lnuTrJ/TmEQ2IxTByoCXsBxi57dCgTVJzLwN7?=
 =?us-ascii?Q?6P68IuTDDoU16iQxT0Vl8s/R6YB57ZtHxClwFieBedHutT7C/m7tTSHmi5b3?=
 =?us-ascii?Q?6o4VfMdBYUsh37ZA0u55ykvfvUuQJhpTVfn/w4rfEBorxH6zfOVOI732xWEg?=
 =?us-ascii?Q?pq516JU4WTP02xKLO0brmTr7T080TGBPcT4OfAB3Amy7Zy3zPtlE1NcYE+NL?=
 =?us-ascii?Q?SHWC+/LLkzpspvFZqvry1/wSampXp4uS3Gg05BiRGN1mGri8QHtNBaztRXyA?=
 =?us-ascii?Q?Y87YcAf05JP3oCLznQU86O5XvhfvTHQQ2oEDwy4mNxeIhisD+HAKk+JRUbhe?=
 =?us-ascii?Q?vuq5qQ9rLo1btqGmJcdUqLlSH4GLsZwh52HIUKw/gMewV8ZrxeI0LDccsQI?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e3cf7cd7-0d61-42b8-b980-08dced48927b
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2024 18:38:33.0429
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR02MB9661

From: Ryan Roberts <ryan.roberts@arm.com> Sent: Monday, October 14, 2024 3:=
55 AM
>=20
> Hi All,
>=20
> Patch bomb incoming... This covers many subsystems, so I've included a co=
re set
> of people on the full series and additionally included maintainers on rel=
evant
> patches. I haven't included those maintainers on this cover letter since =
the
> numbers were far too big for it to work. But I've included a link to this=
 cover
> letter on each patch, so they can hopefully find their way here. For foll=
ow up
> submissions I'll break it up by subsystem, but for now thought it was imp=
ortant
> to show the full picture.
>=20
> This RFC series implements support for boot-time page size selection with=
in the
> arm64 kernel. arm64 supports 3 base page sizes (4K, 16K, 64K), but to dat=
e, page
> size has been selected at compile-time, meaning the size is baked into a =
given
> kernel image. As use of larger-than-4K page sizes become more prevalent t=
his
> starts to present a problem for distributions. Boot-time page size select=
ion
> enables the creation of a single kernel image, which can be told which pa=
ge size
> to use on the kernel command line.
>=20
> Why is having an image-per-page size problematic?
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Many traditional distros are now supporting both 4K and 64K. And this mea=
ns
> managing 2 kernel packages, along with drivers for each. For some, it mea=
ns
> multiple installer flavours and multiple ISOs. All of this adds up to a
> less-than-ideal level of complexity. Additionally, Android now supports 4=
K and
> 16K kernels. I'm told having to explicitly manage their KABI for each ker=
nel is
> painful, and the extra flash space required for both kernel images and th=
e
> duplicated modules has been problematic. Boot-time page size selection so=
lves
> all of this.
>=20
> Additionally, in starting to think about the longer term deployment story=
 for
> D128 page tables, which Arm architecture now supports, a lot of the same
> problems need to be solved, so this work sets us up nicely for that.
>=20
> So what's the down side?
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Well nothing's free; Various static allocations in the kernel image must =
be
> sized for the worst case (largest supported page size), so image size is =
in line
> with size of 64K compile-time image. So if you're interested in 4K or 16K=
, there
> is a slight increase to the image size. But I expect that problem goes aw=
ay if
> you're compressing the image - its just some extra zeros. At boot-time, I=
 expect
> we could free the unused static storage once we know the page size - alth=
ough
> that would be a follow up enhancement.
>=20
> And then there is performance. Since PAGE_SIZE and friends are no longer
> compile-time constants, we must look up their values and do arithmetic at
> runtime instead of compile-time. My early perf testing suggests this is
> inperceptible for real-world workloads, and only has small impact on
> microbenchmarks - more on this below.
=20
[snip]

This is pretty cool. :-)  FWIW, I've built a kernel with this patch set, an=
d
have it running in a RHEL 8.7 guest on Hyper-V in the Azure public cloud.
Ran with 4K, 16K, and 64K page sizes, and the basic smoke tests work.

The Hyper-V specific code in the Linux kernel needed a few tweaks to
deal with PAGE_SIZE and friends no longer being constant, but it's nothing
significant. Getting the kernel built in the first place was a little harde=
r
because my .config file is fairly generic with a lot of device drivers and =
file
system code that aren't really needed for Hyper-V guests. I had to
weed out the ones that won't build. My RHEL 8.7 install uses LVM, so I
hacked the 'dm' code to make it compile and run.

As this work moves forward, I can supply the necessary patches for
the Hyper-V support.  Let me know if you want to include them in the
main patch set.

I've added a couple of Microsoft's Linux people to this email's addressee
list so they are aware of what's going on.

Michael Kelley

