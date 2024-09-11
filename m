Return-Path: <linux-kernel+bounces-325270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E0B97573C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 17:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74EF31C22D12
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 15:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E43931AB6C7;
	Wed, 11 Sep 2024 15:34:44 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CB313D2B2
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 15:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726068884; cv=none; b=kE5UcQlFHsqUCQAbBwT4uPmt3pNPSnaumUKyC2RQcXnS4icugCauEKUOv/1EcffyIwo/tY2LFzq4b3SbJB1IiQa5nyn/CS2dWG8Cstjq6fV3uSpDc1kEgGX/jQgZJ2Ls+MPLzMpfR9FomLJHtIXV+VnEi4E4rOay3dN80ynvC3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726068884; c=relaxed/simple;
	bh=cMsrUjWPpRtEYQ5MM34kgLX3RoHZ1DfwmRja0bg4KDg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CdoH6Q0znWsAnDuAhe/Sh1q6V+zwNusqlHYx2DgTSM3ikAoFIJUewlYWD18mjThgGHtTWPGM6Ruh5HjgPPbDOKjIo+Re6tqtUFoYzy97054SPoqUruIVxP9X8Q5ahmdCHGRrTNRsGFRjxizzv4Kw6QZFEQWoK/MYLeV31fpcJ0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4X3kyl0NnZz6G8p7;
	Wed, 11 Sep 2024 23:29:51 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id D45031400D3;
	Wed, 11 Sep 2024 23:34:38 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 11 Sep
 2024 17:34:38 +0200
Date: Wed, 11 Sep 2024 16:34:36 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Igor Mammedov <imammedo@redhat.com>
CC: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Shiju Jose
	<shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
	<anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
	<linux-kernel@vger.kernel.org>, <qemu-arm@nongnu.org>,
	<qemu-devel@nongnu.org>
Subject: Re: [PATCH v8 06/13] acpi/ghes: add support for generic error
 injection via QAPI
Message-ID: <20240911163436.00004738@Huawei.com>
In-Reply-To: <20240911152132.65a7a219@imammedo.users.ipa.redhat.com>
References: <cover.1723793768.git.mchehab+huawei@kernel.org>
	<2c8970b5d54d17b601dc65d778cc8b5fb288984b.1723793768.git.mchehab+huawei@kernel.org>
	<20240819145136.0452ff2b@imammedo.users.ipa.redhat.com>
	<20240825052923.715f88bc@sal.lan>
	<20240911152132.65a7a219@imammedo.users.ipa.redhat.com>
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
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 11 Sep 2024 15:21:32 +0200
Igor Mammedov <imammedo@redhat.com> wrote:

> On Sun, 25 Aug 2024 05:29:23 +0200
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
>=20
> > Em Mon, 19 Aug 2024 14:51:36 +0200
> > Igor Mammedov <imammedo@redhat.com> escreveu:
> >  =20
> > > > +        read_ack =3D 1;
> > > > +        cpu_physical_memory_write(read_ack_start_addr,
> > > > +                                  &read_ack, (uint64_t));     =20
> > > we don't do this for SEV so, why are you setting it to 1 here?   =20
> >=20
> > According with:
> > https://uefi.org/specs/ACPI/6.5/18_Platform_Error_Interfaces.html#gener=
ic-hardware-error-source-version-2-ghesv2-type-10
> >=20
> >    "These are the steps the OS must take once detecting an error from a=
 particular GHESv2 error source:
> >=20
> >     OSPM detects error (via interrupt/exception or polling the block st=
atus)
> >=20
> >     OSPM copies the error status block
> >=20
> >     OSPM clears the block status field of the error status block
> >=20
> >     OSPM acknowledges the error via Read Ack register. For example:
> >=20
> >         OSPM reads the Read Ack register =E2=80=93> X
> >=20
> >         OSPM writes =E2=80=93> (( X & ReadAckPreserve) | ReadAckWrite)"
> >=20
> >=20
> > So, basically the guest OS takes some time to detect that an error
> > is raised. When it detects, it needs to mark that the error was
> > handled. =20
>=20
> what you are doing here by setting read_ack =3D 1,
> is making ack on behalf of OSPM when OSPM haven't handled existing error =
yet.
>=20
> Essentially making HW/FW do the job of OSPM. That looks wrong to me.
> From HW/FW side read_ack register should be thought as read-only.

It's not read-only because HW/FW has to clear it so that HW/FW can detect
when the OSPM next writes it.

Agreed this write to 1 looks wrong, but the one a few lines further down (t=
o zero
it) is correct.

My bug a long time back I think.

Jonathan

>=20
> >=20
> > IMO, this is needed, independently of the notification mechanism.
> >=20
> > Regards,
> > Mauro
> >  =20
>=20
>=20


