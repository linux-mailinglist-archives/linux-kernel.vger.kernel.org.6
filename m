Return-Path: <linux-kernel+bounces-276388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15D6C9492E9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 16:25:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAABDB283C4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 14:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D196F18D64A;
	Tue,  6 Aug 2024 14:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="S/DEkhlz"
Received: from bee.tesarici.cz (bee.tesarici.cz [37.205.15.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106BB18D624
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 14:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.15.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722954118; cv=none; b=XO7SsjcmNyQZY019s6L2Ap6M3T1MGacuQ7etQDmNVPi4F8vfE3coiZQj9jTJdUM6GpDuWpoVtbKq2XJlQxkvvyPOhj4WWzncO0Hd+3jA9wuDRw41KesnuwethKqeSgYeljcz4kA+UYykkKQJ3lvzki+Sq0BM1IRpq8s09bKJnHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722954118; c=relaxed/simple;
	bh=QewQbOzbPL0m5b3QP1U4iyrOx1Siqcf1KN+kL7g3o/E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E46zfyGqcIvHcHqjkY7BEzri+pwx/Ji38S/K/4cbFaQc345XEpIq1Bm9w986hT/AAv/rITjK2F7gIKUsfl8PWu2qs2i0i3TSdekjEDBEAbIYTDv2GyQjbhrRlc1OR9xrZW5EAvlhEuvsTbAcEJvAydaLfE2qxjHsQFgHXuy7uw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=S/DEkhlz; arc=none smtp.client-ip=37.205.15.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from mordecai.tesarici.cz (unknown [193.86.92.181])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 4B34A1D0BD7;
	Tue,  6 Aug 2024 16:21:54 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1722954114; bh=v08YXF9LA1d68ac5XDr1akLL9Fn0pTDGFBld6nEjRIw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=S/DEkhlzxdrWiUm/KJQ7gEMMv7PcqeSJuv+DV/Fw32TBB1z2/3M4UvE2Ja9dJNqlx
	 DM0NBGm4U3jeSEbJnI5qeR2wMarxh7UTpowrkHFpa4/1FBul7A34TOSuhXl1RLDq1B
	 iPINN7GStqq7bntmeHoj96sWR1Fc+nku31DMITzBrwFGysfjSzQKfdh7DiVBd6laYn
	 sIN+LILfjAR4vANBWskubXOCxHtousI356YdUiGgOqG4xccgCqYQ1vuShvOdhM5z7V
	 YU+uuN7SAHvrPvUysNrVZnw0azBRvx8TJsSkwUxNYCx4bN15nG1+uqlV834rITJfAu
	 kkRQMkRcHaUtQ==
Date: Tue, 6 Aug 2024 16:21:49 +0200
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, Andrew Morton
 <akpm@linux-foundation.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 10/10] mm: rework vm_ops->close() handling on VMA merge
Message-ID: <20240806162149.5d1de9e1@mordecai.tesarici.cz>
In-Reply-To: <599a5806-5209-4454-8d4c-60e458905f2c@lucifer.local>
References: <cover.1722849859.git.lorenzo.stoakes@oracle.com>
	<0afd85543d46fd743c0c71b6f6520f9580174b4f.1722849860.git.lorenzo.stoakes@oracle.com>
	<20240806155555.1125554c@mordecai.tesarici.cz>
	<599a5806-5209-4454-8d4c-60e458905f2c@lucifer.local>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 6 Aug 2024 15:08:33 +0100
Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

> On Tue, Aug 06, 2024 at 03:55:55PM GMT, Petr Tesa=C5=99=C3=ADk wrote:
> > On Mon,  5 Aug 2024 13:13:57 +0100
> > Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
>[...]
> > > @@ -886,6 +894,8 @@ struct vm_area_struct *vma_merge_new_vma(struct v=
ma_merge_struct *vmg)
> > >  	unsigned long end =3D vmg->end;
> > >  	pgoff_t pgoff =3D vmg->pgoff;
> > >  	pgoff_t pglen =3D PHYS_PFN(end - start);
> > > +	bool merge_next =3D false;
> > > +	struct anon_vma *anon_vma =3D vmg->anon_vma; =20
> >
> > Calling this "anon_vma" feels a bit too generic. IIUC you want to save
> > the original vmg->anon_vma in case the VMA turns out to be ummergeable
> > with the next VMA after vmg->anon_vma has already been modified.
> >
> > What about calling it "orig_anon_vma"? =20
>=20
> I disagree, that'd be unnecessary noise (and this is applicable to _all_
> the fields).

I'm afraid I don't understand what you mean with _all_ fields. FWIW my
comment concerns a local variable called "anon_vma", not a struct
member called "anon_vma".

>=20
> Again we come to some trade-off between readability and inherent
> complexity. I am not a fan of making variable names unnecessarily
> overwrought.

Then call it "a". ;-)

See additional comments below:

>=20
> In this case it's just a short-hand, as the only instance where we'd retry
> the operation anon_vma would be NULL (from mmap_region()), so we reset th=
at
> to NULL, however strictly we should reset to anon_vma.
>=20
> I'll change that on the next respin just to be strict.
>=20
> >
> > Petr T
> > =20
> > >
> > >  	VM_WARN_ON(vmg->vma);
> > >
> > > @@ -916,8 +926,9 @@ struct vm_area_struct *vma_merge_new_vma(struct v=
ma_merge_struct *vmg)
> > >  		vmg->end =3D next->vm_end;
> > >  		vmg->vma =3D next;
> > >  		vmg->pgoff =3D next->vm_pgoff - pglen;
> > > -
> > >  		vmg->anon_vma =3D next->anon_vma;

Here, vmg->anon_vma is modified. Original value is lost.

> > > +
> > > +		merge_next =3D true;
> > >  	}
> > >
> > >  	/* If we can merge with the previous VMA, adjust vmg accordingly. */
> > > @@ -925,6 +936,16 @@ struct vm_area_struct *vma_merge_new_vma(struct =
vma_merge_struct *vmg)
> > >  		vmg->start =3D prev->vm_start;
> > >  		vmg->vma =3D prev;
> > >  		vmg->pgoff =3D prev->vm_pgoff;
> > > +
> > > +		/*
> > > +		 * If this merge would result in removal of the next VMA but we
> > > +		 * are not permitted to do so, reduce the operation to merging
> > > +		 * prev and vma.
> > > +		 */
> > > +		if (merge_next && !can_merge_remove_vma(next)) {
> > > +			vmg->end =3D end;
> > > +			vmg->anon_vma =3D anon_vma;

But here you need to restore the original value of vmg->anon_vma.

Isn't this why you introduced the local variable "anon_vma"? I believe
it would be easier to understand its purpose if it includes the "orig_"
prefix.

Just my two eurocents.

Petr T

