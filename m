Return-Path: <linux-kernel+bounces-276383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B7979492C0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 16:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B9851C216F7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 14:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20CC18D63A;
	Tue,  6 Aug 2024 14:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="F84+kY2o"
Received: from bee.tesarici.cz (bee.tesarici.cz [37.205.15.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2421F18D627
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 14:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.15.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722953610; cv=none; b=mxQDI71pFrz+c/mXakin4aWaU+i7nRz5zqSIIEwyDVZsrPCUgfaCYQ9HGSPPxI4cUZi389nh3TRF1ipHK/XdexKsRcuax0bGooGoO/Y/V9Z6pZ04NHoSN0TY6v5iQ88ZkLqQl1wr/DUXwhm82yoX2tjtTreQG2A9fndGBTDTUVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722953610; c=relaxed/simple;
	bh=rmETCj8KAw9/ybR7EEHJFLAxR3rMzbg7Mlo907cbBqE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=guFfGWD7NstH/EZlK5dw0COGvga5Ub6kO1xOf3u0S2KXcKd5QcoNyj5dLpCE9KYzIcb8VzmI9JHSVAGBDKI5rfeD2NwmXmIMdgZK+ScjF5MthhX0TgrILNPnAWGvxDe6ySFnvdNPCKNIiaKJMw2TNW0WqMup0v5i+c6hXY93qtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=F84+kY2o; arc=none smtp.client-ip=37.205.15.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from mordecai.tesarici.cz (unknown [193.86.92.181])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 4C5471D3CA6;
	Tue,  6 Aug 2024 16:13:26 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1722953606; bh=cJb2Uk7f82JabnNdlQgrJWXTdXU9z5U0J91nQ9WPQIk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=F84+kY2oVmz2zvaw19agogDetBSi1mVwVLvFriSpJlz9se2y7wgYsDMj7uWKW9IYn
	 UAZ456F6HGgzpHJ4NDx+JOHl65iAK0zNQzGNpOE+F/SVk9ro3qt8jC2F54nXxlHjou
	 vBl89hp1QpLi2eyuGK3fMLIsqEtUrbBY39YrHOKROqvFp4byh8BBkWBKvKvRA3cWHM
	 iwUP3tWBe5OVWtY++joboNGXikAgvcXI/NO51mNrYTT+YNFLpfpydMjqwmBYJoMQjA
	 6P0SOWW9g2kq8aKunmv5ZYoEDoGO0wBlvCFJYko/NKGbgrMBBVvzU9sOFb5uDbydw2
	 DsdqoyC39CMcA==
Date: Tue, 6 Aug 2024 16:13:21 +0200
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, Andrew Morton
 <akpm@linux-foundation.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 08/10] mm: introduce commit_merge(), abstracting merge
 operation
Message-ID: <20240806161321.376f0a55@mordecai.tesarici.cz>
In-Reply-To: <415d9d9c-7b63-47f0-9091-678f0d8d1268@lucifer.local>
References: <cover.1722849859.git.lorenzo.stoakes@oracle.com>
	<3b04eb13b499df3ebf50ae3cde9a7ed5e76237fd.1722849860.git.lorenzo.stoakes@oracle.com>
	<20240806154116.015e329a@mordecai.tesarici.cz>
	<415d9d9c-7b63-47f0-9091-678f0d8d1268@lucifer.local>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 6 Aug 2024 14:48:33 +0100
Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

> On Tue, Aug 06, 2024 at 03:41:16PM GMT, Petr Tesa=C5=99=C3=ADk wrote:
> > On Mon,  5 Aug 2024 13:13:55 +0100
> > Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
> > =20
> > > Pull this operation into its own function and have vma_expand() call
> > > commit_merge() instead.
> > >
> > > This lays the groundwork for a subsequent patch which replaces vma_me=
rge()
> > > with a simpler function which can share the same code.
> > >
> > > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > > ---
> > >  mm/vma.c | 57 ++++++++++++++++++++++++++++++++++++++++++++----------=
--
> > >  1 file changed, 45 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/mm/vma.c b/mm/vma.c
> > > index a404cf718f9e..b7e3c64d5d68 100644
> > > --- a/mm/vma.c
> > > +++ b/mm/vma.c
> > > @@ -564,6 +564,49 @@ void validate_mm(struct mm_struct *mm)
> > >  }
> > >  #endif /* CONFIG_DEBUG_VM_MAPLE_TREE */
> > >
> > > +/* Actually perform the VMA merge operation. */
> > > +static int commit_merge(struct vma_merge_struct *vmg,
> > > +			struct vm_area_struct *adjust,
> > > +			struct vm_area_struct *remove,
> > > +			struct vm_area_struct *remove2,
> > > +			long adj_start,
> > > +			bool expanded)
> > > +{
> > > +	struct vma_prepare vp;
> > > +
> > > +	init_multi_vma_prep(&vp, vmg->vma, adjust, remove, remove2);
> > > +
> > > +	if (expanded) {
> > > +		vma_iter_config(vmg->vmi, vmg->start, vmg->end);
> > > +	} else {
> > > +		vma_iter_config(vmg->vmi, adjust->vm_start + adj_start,
> > > +				adjust->vm_end);
> > > +	} =20
> >
> > It's hard to follow the logic if you the "expanded" parameter is always
> > true. I have to look at PATCH 09/10 first to see how it is expected to
> > be used. Is there no other way?
> >
> > Note that this is not needed for adjust and adj_start, because they are
> > merely moved here from vma_expand() and passed down as parameters to
> > other functions. =20
>=20
> See the next patch to understand how these are used, as the commit message
> says, this lays the groundwork for the next patch which actually uses both
> of these.
>=20
> I have tried hard to clarify how these are used, however there is some
> unavoidable and inherent complexity in this logic. If you don't believe m=
e,
> I suggest trying to follow the logic of the existing code :)
>=20
> And if you want to _really_ have fun, I suggest you try to understand the
> logic around v6.0 prior to Liam's interventions.
>=20
> We might be able to try to improve the logic flow further, but it's one
> step at a time with this.

What I mean is: Is there no way to arrange the patch series so that I
don't have to look at PATH 09/10 before I can understand code in patch
08/10?

This PATCH 08/10 adds only one call to commit_merge() and that one
always sets expanded to true. Maybe you could introduce commit_merge()
here without the parameter and add it in PATCH 09/10?

Petr T

