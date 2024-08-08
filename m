Return-Path: <linux-kernel+bounces-279860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1182294C2BD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 18:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70578B2202D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 16:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7063618EFC6;
	Thu,  8 Aug 2024 16:27:33 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85CE646
	for <linux-kernel@vger.kernel.org>; Thu,  8 Aug 2024 16:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723134453; cv=none; b=sN6ZfI4yiu65X/uFYbdU3+WVzn6tq3RuQMoGYoxKtyGXxDV6xycErhsFFox82JIF2x13ZkyTzOxU3dvx8jc2CSdmup/h6EtDMKhP6fxZaFiVz+2mPFno0uWZzJqdugZW4WGFh47Xwg8Rf2cUWTtmBnsPKlyAySwW0yqo3A6HZbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723134453; c=relaxed/simple;
	bh=jDIyH9aokYnOVCogvexan605XgzRSRiBHX7aA0XjmHM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QaZWuLor5782pig0azqsTAoTd8l/fr5U+XxHndESeJpFqGEvJz0Na4ZsReHt8WXbDMv7kV62fmL7ASvxSz5eOqONGllT+nL9/62gRznorkJ+BQp7UEngN3AtqaZOm+T8xesUYzKF2hBUVQMQpKqWvGK65EhHWw9fE7Mf6dq7dfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Wfsnj5C1Xz6K8wp;
	Fri,  9 Aug 2024 00:24:41 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 34A251400CB;
	Fri,  9 Aug 2024 00:27:28 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 8 Aug
 2024 17:27:27 +0100
Date: Thu, 8 Aug 2024 17:27:26 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tvrtko Ursulin
	<tursulin@igalia.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <kernel-dev@igalia.com>,
	=?ISO-8859-1?Q?Ma=ED?= =?ISO-8859-1?Q?ra?= Canal <mcanal@igalia.com>, Catalin
 Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, "Mike
 Rapoport (Microsoft)" <rppt@kernel.org>
Subject: Re: [PATCH 1/2] numa: Add simple generic NUMA emulation
Message-ID: <20240808172726.0000154a@Huawei.com>
In-Reply-To: <54b357b2-2132-4fd6-89db-7a60617dc859@igalia.com>
References: <20240625125803.38038-1-tursulin@igalia.com>
	<20240625125803.38038-2-tursulin@igalia.com>
	<2024062627-curler-unlucky-51e0@gregkh>
	<679a9dda-8e8a-4428-8d57-30b0c60f28ce@igalia.com>
	<54b357b2-2132-4fd6-89db-7a60617dc859@igalia.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 8 Aug 2024 12:56:44 +0100
Tvrtko Ursulin <tvrtko.ursulin@igalia.com> wrote:

> [Please excuse the re-send, but as I heard nothing concern is it did not=
=20
> get lost in your busy mailbox.]
>=20
> Hi Greg,
>=20
> Gentle reminder on the opens from this thread. Let me re-summarise the=20
> question below:
>=20
> On 26/06/2024 12:47, Tvrtko Ursulin wrote:
> >=20
> > Hi Greg,
> >=20
> > On 26/06/2024 08:38, Greg Kroah-Hartman wrote: =20
> >> On Tue, Jun 25, 2024 at 01:58:02PM +0100, Tvrtko Ursulin wrote: =20
> >>> From: Ma=C3=ADra Canal <mcanal@igalia.com>
> >>>
> >>> Add some common code for splitting the memory into N emulated NUMA=20
> >>> memory
> >>> nodes.
> >>>
> >>> Individual architecture can then enable selecting this option and use=
=20
> >>> the
> >>> existing numa=3Dfake=3D<N> kernel argument to enable it.
> >>>
> >>> Memory is always split into equally sized chunks.
> >>>
> >>> Signed-off-by: Ma=C3=ADra Canal <mcanal@igalia.com>
> >>> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> >>> Co-developed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> >>> Cc: Catalin Marinas <catalin.marinas@arm.com>
> >>> Cc: Will Deacon <will@kernel.org>
> >>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >>> Cc: =E2=80=9CRafael J. Wysocki" <rafael@kernel.org>
> >>> ---
> >>> =C2=A0 drivers/base/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0 7 ++++
> >>> =C2=A0 drivers/base/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 1 +
> >>> =C2=A0 drivers/base/arch_numa.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
 6 ++++
> >>> =C2=A0 drivers/base/numa_emulation.c | 67 +++++++++++++++++++++++++++=
++++++++
> >>> =C2=A0 drivers/base/numa_emulation.h | 21 +++++++++++ =20
> >>
> >> Why not just properly describe the numa topology in your bootloader or
> >> device tree and not need any such "fake" stuff at all?
> >>
> >> Also, you are now asking me to maintain these new files, not something
> >> I'm comfortable doing at all sorry. =20
> >=20
> > Mostly because ae3c107cd8be ("numa: Move numa implementation to common=
=20
> > code") and existing common code in drivers/base/arch_numa.c it appeared=
=20
> > it could be acceptable to add the simple NUMA emulation into the common=
=20
> > code too. Then building upon the same concept as on x86 where no need=20
> > for firmware changes is needed for experimenting with different=20
> > configurations.
> >=20
> > Would folding into arch_numa.c so no new files are added address your=20
> > concern, or your main issue is the emulation in general? =20
>=20
> Re-iterating and slightly re-formulating this question I see three option=
s:
>=20
> a)
> Fold the new simple generic code into the existing arch_numa.c,=20
> addressing the "no new files" objection, if that was the main objection.
>=20
> b)
> Move completely into arch code - aka you don't want to see it under=20
> drivers/base at all, ever, regardless of how simple the new code is, or=20
> that common NUMA code is already there.
>=20
> c)
> Strong nack for either a) or b) - so "do it in the firmware" comment.
>=20
> Trying to understand your position so we can progress this.

See:=20
https://lore.kernel.org/all/20240807064110.1003856-20-rppt@kernel.org/
and rest of thread=20
https://lore.kernel.org/all/20240807064110.1003856-1-rppt@kernel.org/
[PATCH v4 00/26] mm: introduce numa_memblks

Much larger rework and unification set from Mike Rapoport
that happens to end up adding numa emulation as part of making
the x86 numa_memblk work for arm64 etc.

It's in mm-unstable now so getting some test coverage etc.

Sorry, I'd kind of assumed this also went to linux-mm so
the connection would have been made.

Jonathan


>=20
> Thanks,
>=20
> Tvrtko
>=20
> >  =20
> >  >> +=C2=A0=C2=A0=C2=A0 if (str_has_prefix(opt, "fake=3D"))
> >  >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return numa_emu_cmdline=
(opt + 5); =20
> >  >
> >  > You did not document this at all :( =20
> >=20
> > That was indeed an oversight. Just need to "copy with edits" some stuff=
=20
> > from Documentation/arch/x86/x86_64/boot-options.rst.
> >=20
> > Regards,
> >=20
> > Tvrtko =20
>=20


