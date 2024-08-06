Return-Path: <linux-kernel+bounces-276417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED7294935A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 16:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 392E928426A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 14:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429B420127F;
	Tue,  6 Aug 2024 14:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="GMlT1K4Q"
Received: from bee.tesarici.cz (bee.tesarici.cz [37.205.15.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF1620127B
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 14:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.15.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722955159; cv=none; b=osuq3A9rEfEeIYiyLuFQRFYvapaxFfwjqQDgzvhnypjCSzGHwEGk0vzW4AIhaWMxib8UdKmy2a++jKmggKORJJk+KMOXdCMBqxRSIhkTKidvnAxObacRjtaR5EpTtT5W10paRe52TMLdHn074MEgjbbDNkgOsxU8oPRFgOSvXfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722955159; c=relaxed/simple;
	bh=h8EQkRC+GliKRB5ksSJd8CsPwKgdtK6CXogtHHOpKb8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m0RhDe3Tyj5/2l8wnyYX37ejxIIJ7WNSTd9jdUXwf0XbsRoge92n0RDX1H2Sm+mZmur2yjNTPQkZ/6P8uol+T2G3kxOBNxD2ufs2MDXTeILdKinzm7EYMm7tcHgCUAeN2qaDLjcuMryige05mT3P0IBbps+ukCEsDxVUH9gaO+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=GMlT1K4Q; arc=none smtp.client-ip=37.205.15.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from mordecai.tesarici.cz (unknown [193.86.92.181])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 3F6FE1D1A64;
	Tue,  6 Aug 2024 16:39:15 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1722955155; bh=1PTYclq5sGfpv3NAMIKIUDYiBHvA3Eo1GiGmYnQbzU4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GMlT1K4Q+3fZxVtkXabhN48mW3V4XmbryxkuKMT2KlQasS4GnS7dtESErsxEhv61A
	 PkIs8uvElHRyHTEa5BUfz5LZnUKyFq5ajJsfvF6BflXDqKHJXSFGwGkZxiTahYkSY6
	 nPY9iSvYF8rLPHUlJhxFrgQUanq5zEYYzsdGZCxJZBFUds2+4bpTgv38iXdFht95dg
	 4QfExY9hq13m7cQz0Ukw4dVZtWQMi7IQAWegKM37O23o0CAq/MhNpIw0SVssabv24f
	 pagnKQ0E3QhcmmozjpFGOJztF6iv2WyV5ZTl0bFOApyEqAdS+PWskuqMZ17bGYe+mi
	 cqqxmuI/Sv8xg==
Date: Tue, 6 Aug 2024 16:39:11 +0200
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, Andrew Morton
 <akpm@linux-foundation.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 08/10] mm: introduce commit_merge(), abstracting merge
 operation
Message-ID: <20240806163911.638cfbb3@mordecai.tesarici.cz>
In-Reply-To: <c60acd5e-e7c7-42ba-9ad3-1b221cec2ddf@lucifer.local>
References: <cover.1722849859.git.lorenzo.stoakes@oracle.com>
	<3b04eb13b499df3ebf50ae3cde9a7ed5e76237fd.1722849860.git.lorenzo.stoakes@oracle.com>
	<20240806154116.015e329a@mordecai.tesarici.cz>
	<415d9d9c-7b63-47f0-9091-678f0d8d1268@lucifer.local>
	<20240806161321.376f0a55@mordecai.tesarici.cz>
	<c60acd5e-e7c7-42ba-9ad3-1b221cec2ddf@lucifer.local>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 6 Aug 2024 15:30:49 +0100
Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

> On Tue, Aug 06, 2024 at 04:13:21PM GMT, Petr Tesa=C5=99=C3=ADk wrote:
> > On Tue, 6 Aug 2024 14:48:33 +0100
> > Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
> > =20
> > > On Tue, Aug 06, 2024 at 03:41:16PM GMT, Petr Tesa=C5=99=C3=ADk wrote:=
 =20
> > > > On Mon,  5 Aug 2024 13:13:55 +0100
> > > > Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
> > > > =20
> > > > > Pull this operation into its own function and have vma_expand() c=
all
> > > > > commit_merge() instead.
> > > > >
> > > > > This lays the groundwork for a subsequent patch which replaces vm=
a_merge()
> > > > > with a simpler function which can share the same code.
> > > > >
> > > > > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > > > > ---
> > > > >  mm/vma.c | 57 ++++++++++++++++++++++++++++++++++++++++++++------=
------
> > > > >  1 file changed, 45 insertions(+), 12 deletions(-)
> > > > >
> > > > > diff --git a/mm/vma.c b/mm/vma.c
> > > > > index a404cf718f9e..b7e3c64d5d68 100644
> > > > > --- a/mm/vma.c
> > > > > +++ b/mm/vma.c
> > > > > @@ -564,6 +564,49 @@ void validate_mm(struct mm_struct *mm)
> > > > >  }
> > > > >  #endif /* CONFIG_DEBUG_VM_MAPLE_TREE */
> > > > >
> > > > > +/* Actually perform the VMA merge operation. */
> > > > > +static int commit_merge(struct vma_merge_struct *vmg,
> > > > > +			struct vm_area_struct *adjust,
> > > > > +			struct vm_area_struct *remove,
> > > > > +			struct vm_area_struct *remove2,
> > > > > +			long adj_start,
> > > > > +			bool expanded)
> > > > > +{
> > > > > +	struct vma_prepare vp;
> > > > > +
> > > > > +	init_multi_vma_prep(&vp, vmg->vma, adjust, remove, remove2);
> > > > > +
> > > > > +	if (expanded) {
> > > > > +		vma_iter_config(vmg->vmi, vmg->start, vmg->end);
> > > > > +	} else {
> > > > > +		vma_iter_config(vmg->vmi, adjust->vm_start + adj_start,
> > > > > +				adjust->vm_end);
> > > > > +	} =20
> > > >
> > > > It's hard to follow the logic if you the "expanded" parameter is al=
ways
> > > > true. I have to look at PATCH 09/10 first to see how it is expected=
 to
> > > > be used. Is there no other way?
> > > >
> > > > Note that this is not needed for adjust and adj_start, because they=
 are
> > > > merely moved here from vma_expand() and passed down as parameters to
> > > > other functions. =20
> > >
> > > See the next patch to understand how these are used, as the commit me=
ssage
> > > says, this lays the groundwork for the next patch which actually uses=
 both
> > > of these.
> > >
> > > I have tried hard to clarify how these are used, however there is some
> > > unavoidable and inherent complexity in this logic. If you don't belie=
ve me,
> > > I suggest trying to follow the logic of the existing code :)
> > >
> > > And if you want to _really_ have fun, I suggest you try to understand=
 the
> > > logic around v6.0 prior to Liam's interventions.
> > >
> > > We might be able to try to improve the logic flow further, but it's o=
ne
> > > step at a time with this. =20
> >
> > What I mean is: Is there no way to arrange the patch series so that I
> > don't have to look at PATH 09/10 before I can understand code in patch
> > 08/10? =20
>=20
> No.
>=20
> >
> > This PATCH 08/10 adds only one call to commit_merge() and that one
> > always sets expanded to true. Maybe you could introduce commit_merge()
> > here without the parameter and add it in PATCH 09/10? =20
>=20
> No, I won't do that, you haven't made a case for it.
>=20
> >
> > Petr T =20
>=20
> I appreciate you are doing a drive-by review on code you aren't familiar
> with, but it's worth appreciating that there is some context here - this =
is
> intentionally isolating _existing_ logic from vma_expand() and vma_merge()
> in such a way that we have a _generic_ function we can use for this
> operation.

The history you make today becomes the learning material for the next
generation of kernel hackers (who will also lack a lot of context).

> I think it'd be _more_ confusing and (surprising given your rather pedant=
ic
> interpretation of churn elsewhere) churny to rewrite this again with a
> bunch of added logic in the next commit.
>=20
> I think this is highly subjective, and I'm not sure it's a great use of
> either of our time to get too stuck in the weeds on this kind of thing.

Yep. We can all agre this is the best way to convey the idea behind the
changes. Don't get me wrong; this whole series does a lot of good in
terms of code readability, even for a bystander like myself.

Petr T

