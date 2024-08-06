Return-Path: <linux-kernel+bounces-276402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F05949323
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 16:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 218361C21C65
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 14:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B520D1BDA82;
	Tue,  6 Aug 2024 14:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="hJIWvF5V"
Received: from bee.tesarici.cz (bee.tesarici.cz [37.205.15.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95B818D632
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 14:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.15.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722954763; cv=none; b=A3DW3i25yOu+YzMBAqrqI9YYm/HnFj43zaVz244nwNPw8B5nbYbMhpG3H7DWD+HS5bLWBKuxaJ+IaYDgq4PntN13NGgVB4gbY/nWx2y5lQANOy3o/+qO/goo5mr35SSWUkjTjFIqTFv2wJXXMF3IOv2Zec/uY7+myOQd5vBMWuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722954763; c=relaxed/simple;
	bh=h2LzO5/swy7riOzvE+Pwhv9uoG+himOjFdyAkddfjw0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cr8jOxMvEZoqljwm2+Fqawhc40tK47ySaAhTmVyVjNGyBwgerARfaNCDcdVTvhRhM2xunXt2GWXaYqprL1fnYuKCi9UFv7MwS2DjJLWuypJJsfor1kX4Tg/DmcjrEmfiom24RXQvLZLjuICHZad2gFD4znccLYduRuXguc5XygQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=hJIWvF5V; arc=none smtp.client-ip=37.205.15.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from mordecai.tesarici.cz (unknown [193.86.92.181])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 4DBF71D39A8;
	Tue,  6 Aug 2024 16:32:39 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1722954759; bh=g4APhhwhO/eLGnY2rQDpJ8JqIDQ+BR/sG7w6iumGct0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hJIWvF5VxVnXCVSszKyATmb5VsflfmiCBVlHkvL2ZJnogohaJ2O6UJv/cC50pFbFW
	 9S5KRqX6dLiLlLTPi4qvXqsSx8l2R+FqzvGt2zqeXDlUqCRyGNJd3xZLOH9zrodcjx
	 OUjeIiNi6XikKSY1oIfvQVZoi8ciHjYT/+9MmK/iWELoMWG3h0Mu73sC5WQDXdpRjd
	 O/HC/I85BBUNqjW3Hj+v5GnclqRNlKb1WEOxDumT0m1Z0AGnH9S5+GATAv775xx4bF
	 NQWstA9LK/6ZIR+TYIezjR5QMA+bIc81Du/p1/hFbXJN1/uLEhKwF7whIx1TjprNnz
	 dxbrizj6IFQEw==
Date: Tue, 6 Aug 2024 16:32:34 +0200
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, Andrew Morton
 <akpm@linux-foundation.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 02/10] mm: introduce vma_merge_struct and abstract merge
 parameters
Message-ID: <20240806163234.78debfc0@mordecai.tesarici.cz>
In-Reply-To: <654dd596-3875-4ab4-acdf-9e5f547b5551@lucifer.local>
References: <cover.1722849859.git.lorenzo.stoakes@oracle.com>
	<f2d7cc5de8aecc50d353980f62a74a0a6fcec198.1722849859.git.lorenzo.stoakes@oracle.com>
	<20240806144754.447001bc@mordecai.tesarici.cz>
	<ddc4c351-d79f-4654-8e0e-63f22afc146f@lucifer.local>
	<20240806160650.16af656e@mordecai.tesarici.cz>
	<654dd596-3875-4ab4-acdf-9e5f547b5551@lucifer.local>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

V Tue, 6 Aug 2024 15:20:49 +0100
Lorenzo Stoakes <lorenzo.stoakes@oracle.com> naps=C3=A1no:

> On Tue, Aug 06, 2024 at 04:06:50PM GMT, Petr Tesa=C5=99=C3=ADk wrote:
> > On Tue, 6 Aug 2024 14:43:48 +0100
> > Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
> > =20
> > > On Tue, Aug 06, 2024 at 02:47:54PM GMT, Petr Tesa=C5=99=C3=ADk wrote:=
 =20
> > > > Hi Lorenzo!
> > > >
> > > > On Mon,  5 Aug 2024 13:13:49 +0100
> > > > Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
> > > > =20
> > > > > Rather than passing around huge numbers of parameters to numerous=
 helper
> > > > > functions, abstract them into a single struct that we thread thro=
ugh the
> > > > > operation.
> > > > >
> > > > > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > > > > ---
> > > > >  mm/mmap.c |  76 ++++++++------
> > > > >  mm/vma.c  | 297 ++++++++++++++++++++++++++++++++++++++----------=
------
> > > > >  mm/vma.h  |  92 ++++++++---------
> > > > >  3 files changed, 294 insertions(+), 171 deletions(-)
> > > > >
> > > > > diff --git a/mm/mmap.c b/mm/mmap.c
> > > > > index 4a9c2329b09a..f931000c561f 100644
> > > > > --- a/mm/mmap.c
> > > > > +++ b/mm/mmap.c
> > > > > @@ -1369,9 +1369,16 @@ unsigned long mmap_region(struct file *fil=
e, unsigned long addr,
> > > > >  	unsigned long end =3D addr + len;
> > > > >  	unsigned long merge_start =3D addr, merge_end =3D end;
> > > > >  	bool writable_file_mapping =3D false;
> > > > > -	pgoff_t vm_pgoff;
> > > > >  	int error;
> > > > >  	VMA_ITERATOR(vmi, mm, addr);
> > > > > +	struct vma_merge_struct vmg =3D {
> > > > > +		.vmi =3D &vmi,
> > > > > +		.start =3D addr,
> > > > > +		.end =3D end,
> > > > > +		.flags =3D vm_flags,
> > > > > +		.pgoff =3D pgoff,
> > > > > +		.file =3D file,
> > > > > +	};
> > > > >
> > > > >  	/* Check against address space limit. */
> > > > >  	if (!may_expand_vm(mm, vm_flags, len >> PAGE_SHIFT)) {
> > > > > @@ -1405,8 +1412,8 @@ unsigned long mmap_region(struct file *file=
, unsigned long addr,
> > > > >  		vm_flags |=3D VM_ACCOUNT;
> > > > >  	}
> > > > >
> > > > > -	next =3D vma_next(&vmi);
> > > > > -	prev =3D vma_prev(&vmi);
> > > > > +	next =3D vmg.next =3D vma_next(&vmi);
> > > > > +	prev =3D vmg.prev =3D vma_prev(&vmi); =20
> > > >
> > > > So, next is now a shortcut for vmg.next, and prev is a shortcut for
> > > > vmg.prev. ATM there is only one assignment, so no big deal, but I
> > > > wonder if next and prev could be removed instead, same as you repla=
ced
> > > > vm_pgoff with vmg.pgoff. =20
> > >
> > > It's simply to avoid repeatedly referencing vmg.xxx / at least reduce
> > > _some_ churn. Also this will get moved shortly, so it's worth looking=
 at in
> > > final form. =20
> >
> > I'm not a MM maintainer, so my comments may not be relevant, but my
> > experience shows that pointer aliases have a potential to introduce all
> > kinds of subtle bugs. That's the reason I generally try to avoid them. =
=20
>=20
> Right, I understand, I don't want to get too deep into a distracting bike
> shed when this series is doing something quite major.
>=20
> If you feel this is absolutely critical, I can adjust this code that I
> later delete, if not I suggest leaving it as it is.

Fair enough. I missed that _both_ occurences of the pointer aliases are
deleted later.

Then you're right, it's fine as is. No more bike shedding.

Petr T

