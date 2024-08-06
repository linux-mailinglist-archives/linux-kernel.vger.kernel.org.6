Return-Path: <linux-kernel+bounces-276372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 593A494929F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 16:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FBE12820D2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 14:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6A018D62C;
	Tue,  6 Aug 2024 14:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="CEi4ESP2"
Received: from bee.tesarici.cz (bee.tesarici.cz [37.205.15.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D7918D620
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 14:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.15.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722953220; cv=none; b=Gy4R1LjWbYXFq5XsqHVEhiY8Yf7DMOov/NgnmBQ7EMzZ4MUzqHzKuoZLg1nqEPIROZoYYcIuvWT+aVduuv2nE23KxVypHbbv+HES1hoJ4vijlKgxIZ2n8TfKiAmrl7pRAY1WCW276fUZSKGsglWZMhjVNw2zGeUqy1vsoiKAvdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722953220; c=relaxed/simple;
	bh=g6gbME84mQ9Ddy1RVeUcBxts5xWe7ZGf89X2qXAp+Mw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WZEu9eQwqBB3t0JdZIGhe6KUUL8lXlNrvVcS9r1G4H+p+Y7hsDf49Jyv1toQEfvTu0+NKBccuRUkaI+5waWlsHeUbOH+vxgD9aYn+k9ar2oJDTLP6yb24zQWLeV+jCWJSagr8p1+8Ue/hG36FYho205oGeIVzGsP93/TmVNTK2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=CEi4ESP2; arc=none smtp.client-ip=37.205.15.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from mordecai.tesarici.cz (unknown [193.86.92.181])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id E490A1D24AA;
	Tue,  6 Aug 2024 16:06:55 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1722953215; bh=cOHujA6IrGjJd4Lbx+6HxgNPOKdyvZkTA/pJBm2vvrk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CEi4ESP2LEyhOXPQf/jnyr/zxk9gjk0a8wyFG/DJgmq6IB9X4kNJUBmpYOiXnlgcS
	 vCWppvg9IqfQiiOSUELvDQvE4tPPO5aKQiM0vlqtqXQ1l6mM5jfLTOIoFSE3F9lmri
	 m30R4G86Y9sdhd/gPC/akoGb0QG5edbRdPslDTbQSRtwR9sjg9NgY6RhbJNeeOdw6s
	 QIt5/3o3ky/deIaX1PjD5ibqHhtnPDOoCKhmkeHxjOLVtfmtSh5/KseHEn4aVPGma7
	 TPK0xya8jcN5mXm71+rsSCzVmrScufqQYdRegi7mcN9q5kl+qkXuk/06VxZQlMiO6S
	 Umnj7uDuwVyUA==
Date: Tue, 6 Aug 2024 16:06:50 +0200
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, Andrew Morton
 <akpm@linux-foundation.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 02/10] mm: introduce vma_merge_struct and abstract merge
 parameters
Message-ID: <20240806160650.16af656e@mordecai.tesarici.cz>
In-Reply-To: <ddc4c351-d79f-4654-8e0e-63f22afc146f@lucifer.local>
References: <cover.1722849859.git.lorenzo.stoakes@oracle.com>
	<f2d7cc5de8aecc50d353980f62a74a0a6fcec198.1722849859.git.lorenzo.stoakes@oracle.com>
	<20240806144754.447001bc@mordecai.tesarici.cz>
	<ddc4c351-d79f-4654-8e0e-63f22afc146f@lucifer.local>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 6 Aug 2024 14:43:48 +0100
Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

> On Tue, Aug 06, 2024 at 02:47:54PM GMT, Petr Tesa=C5=99=C3=ADk wrote:
> > Hi Lorenzo!
> >
> > On Mon,  5 Aug 2024 13:13:49 +0100
> > Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
> > =20
> > > Rather than passing around huge numbers of parameters to numerous hel=
per
> > > functions, abstract them into a single struct that we thread through =
the
> > > operation.
> > >
> > > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > > ---
> > >  mm/mmap.c |  76 ++++++++------
> > >  mm/vma.c  | 297 ++++++++++++++++++++++++++++++++++++++--------------=
--
> > >  mm/vma.h  |  92 ++++++++---------
> > >  3 files changed, 294 insertions(+), 171 deletions(-)
> > >
> > > diff --git a/mm/mmap.c b/mm/mmap.c
> > > index 4a9c2329b09a..f931000c561f 100644
> > > --- a/mm/mmap.c
> > > +++ b/mm/mmap.c
> > > @@ -1369,9 +1369,16 @@ unsigned long mmap_region(struct file *file, u=
nsigned long addr,
> > >  	unsigned long end =3D addr + len;
> > >  	unsigned long merge_start =3D addr, merge_end =3D end;
> > >  	bool writable_file_mapping =3D false;
> > > -	pgoff_t vm_pgoff;
> > >  	int error;
> > >  	VMA_ITERATOR(vmi, mm, addr);
> > > +	struct vma_merge_struct vmg =3D {
> > > +		.vmi =3D &vmi,
> > > +		.start =3D addr,
> > > +		.end =3D end,
> > > +		.flags =3D vm_flags,
> > > +		.pgoff =3D pgoff,
> > > +		.file =3D file,
> > > +	};
> > >
> > >  	/* Check against address space limit. */
> > >  	if (!may_expand_vm(mm, vm_flags, len >> PAGE_SHIFT)) {
> > > @@ -1405,8 +1412,8 @@ unsigned long mmap_region(struct file *file, un=
signed long addr,
> > >  		vm_flags |=3D VM_ACCOUNT;
> > >  	}
> > >
> > > -	next =3D vma_next(&vmi);
> > > -	prev =3D vma_prev(&vmi);
> > > +	next =3D vmg.next =3D vma_next(&vmi);
> > > +	prev =3D vmg.prev =3D vma_prev(&vmi); =20
> >
> > So, next is now a shortcut for vmg.next, and prev is a shortcut for
> > vmg.prev. ATM there is only one assignment, so no big deal, but I
> > wonder if next and prev could be removed instead, same as you replaced
> > vm_pgoff with vmg.pgoff. =20
>=20
> It's simply to avoid repeatedly referencing vmg.xxx / at least reduce
> _some_ churn. Also this will get moved shortly, so it's worth looking at =
in
> final form.

I'm not a MM maintainer, so my comments may not be relevant, but my
experience shows that pointer aliases have a potential to introduce all
kinds of subtle bugs. That's the reason I generally try to avoid them.

>=20
> >
> > Is the resulting code _too_ ugly?
> > =20
> > >  	if (vm_flags & VM_SPECIAL) {
> > >  		if (prev)
> > >  			vma_iter_next_range(&vmi);
> > > @@ -1416,29 +1423,30 @@ unsigned long mmap_region(struct file *file, =
unsigned long addr,
> > >  	/* Attempt to expand an old mapping */
> > >  	/* Check next */
> > >  	if (next && next->vm_start =3D=3D end && !vma_policy(next) &&
> > > -	    can_vma_merge_before(next, vm_flags, NULL, file, pgoff+pglen,
> > > -				 NULL_VM_UFFD_CTX, NULL)) {
> > > +	    can_vma_merge_before(&vmg)) {
> > >  		merge_end =3D next->vm_end;
> > >  		vma =3D next;
> > > -		vm_pgoff =3D next->vm_pgoff - pglen;
> > > +		vmg.pgoff =3D next->vm_pgoff - pglen;
> > > +	}
> > > +
> > > +	if (vma) {
> > > +		vmg.anon_vma =3D vma->anon_vma;
> > > +		vmg.uffd_ctx =3D vma->vm_userfaultfd_ctx;
> > >  	}
> > >
> > >  	/* Check prev */
> > >  	if (prev && prev->vm_end =3D=3D addr && !vma_policy(prev) &&
> > > -	    (vma ? can_vma_merge_after(prev, vm_flags, vma->anon_vma, file,
> > > -				       pgoff, vma->vm_userfaultfd_ctx, NULL) :
> > > -		   can_vma_merge_after(prev, vm_flags, NULL, file, pgoff,
> > > -				       NULL_VM_UFFD_CTX, NULL))) {
> > > +	    can_vma_merge_after(&vmg)) {
> > >  		merge_start =3D prev->vm_start;
> > >  		vma =3D prev;
> > > -		vm_pgoff =3D prev->vm_pgoff;
> > > +		vmg.pgoff =3D prev->vm_pgoff;
> > >  	} else if (prev) {
> > >  		vma_iter_next_range(&vmi);
> > >  	}
> > >
> > >  	/* Actually expand, if possible */
> > >  	if (vma &&
> > > -	    !vma_expand(&vmi, vma, merge_start, merge_end, vm_pgoff, next))=
 {
> > > +	    !vma_expand(&vmi, vma, merge_start, merge_end, vmg.pgoff, next)=
) {
> > >  		khugepaged_enter_vma(vma, vm_flags);
> > >  		goto expanded;
> > >  	}
> > > @@ -1790,25 +1798,31 @@ static int do_brk_flags(struct vma_iterator *=
vmi, struct vm_area_struct *vma,
> > >  	 * Expand the existing vma if possible; Note that singular lists do=
 not
> > >  	 * occur after forking, so the expand will only happen on new VMAs.
> > >  	 */
> > > -	if (vma && vma->vm_end =3D=3D addr && !vma_policy(vma) &&
> > > -	    can_vma_merge_after(vma, flags, NULL, NULL,
> > > -				addr >> PAGE_SHIFT, NULL_VM_UFFD_CTX, NULL)) {
> > > -		vma_iter_config(vmi, vma->vm_start, addr + len);
> > > -		if (vma_iter_prealloc(vmi, vma))
> > > -			goto unacct_fail;
> > > -
> > > -		vma_start_write(vma);
> > > -
> > > -		init_vma_prep(&vp, vma);
> > > -		vma_prepare(&vp);
> > > -		vma_adjust_trans_huge(vma, vma->vm_start, addr + len, 0);
> > > -		vma->vm_end =3D addr + len;
> > > -		vm_flags_set(vma, VM_SOFTDIRTY);
> > > -		vma_iter_store(vmi, vma);
> > > -
> > > -		vma_complete(&vp, vmi, mm);
> > > -		khugepaged_enter_vma(vma, flags);
> > > -		goto out;
> > > +	if (vma && vma->vm_end =3D=3D addr && !vma_policy(vma)) {
> > > +		struct vma_merge_struct vmg =3D {
> > > +			.prev =3D vma,
> > > +			.flags =3D flags,
> > > +			.pgoff =3D addr >> PAGE_SHIFT,
> > > +		};
> > > +
> > > +		if (can_vma_merge_after(&vmg)) {
> > > +			vma_iter_config(vmi, vma->vm_start, addr + len);
> > > +			if (vma_iter_prealloc(vmi, vma))
> > > +				goto unacct_fail;
> > > +
> > > +			vma_start_write(vma);
> > > +
> > > +			init_vma_prep(&vp, vma);
> > > +			vma_prepare(&vp);
> > > +			vma_adjust_trans_huge(vma, vma->vm_start, addr + len, 0);
> > > +			vma->vm_end =3D addr + len;
> > > +			vm_flags_set(vma, VM_SOFTDIRTY);
> > > +			vma_iter_store(vmi, vma);
> > > +
> > > +			vma_complete(&vp, vmi, mm);
> > > +			khugepaged_enter_vma(vma, flags);
> > > +			goto out;
> > > +		}
> > >  	}
> > >
> > >  	if (vma)
> > > diff --git a/mm/vma.c b/mm/vma.c
> > > index bf0546fe6eab..20c4ce7712c0 100644
> > > --- a/mm/vma.c
> > > +++ b/mm/vma.c
> > > @@ -7,16 +7,18 @@
> > >  #include "vma_internal.h"
> > >  #include "vma.h"
> > >
> > > -/*
> > > - * If the vma has a ->close operation then the driver probably needs=
 to release
> > > - * per-vma resources, so we don't attempt to merge those if the call=
er indicates
> > > - * the current vma may be removed as part of the merge.
> > > - */
> > > -static inline bool is_mergeable_vma(struct vm_area_struct *vma,
> > > -		struct file *file, unsigned long vm_flags,
> > > -		struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
> > > -		struct anon_vma_name *anon_name, bool may_remove_vma)
> > > +static inline bool is_mergeable_vma(struct vma_merge_struct *vmg, bo=
ol merge_next)
> > >  {
> > > +	struct vm_area_struct *vma =3D merge_next ? vmg->next : vmg->prev;
> > > +	/*
> > > +	 * If the vma has a ->close operation then the driver probably need=
s to
> > > +	 * release per-vma resources, so we don't attempt to merge those if=
 the
> > > +	 * caller indicates the current vma may be removed as part of the m=
erge,
> > > +	 * which is the case if we are attempting to merge the next VMA into
> > > +	 * this one.
> > > +	 */
> > > +	bool may_remove_vma =3D merge_next;
> > > + =20
> >
> > This variable is used only once. If you want to clarify the double
> > meaning of the merge_next parameter, consider moving this comment
> > further down to the conditional and merely renaming the parameter.
> > =20
> > >  	/*
> > >  	 * VM_SOFTDIRTY should not prevent from VMA merging, if we
> > >  	 * match the flags but dirty bit -- the caller should mark
> > > @@ -25,15 +27,15 @@ static inline bool is_mergeable_vma(struct vm_are=
a_struct *vma,
> > >  	 * the kernel to generate new VMAs when old one could be
> > >  	 * extended instead.
> > >  	 */
> > > -	if ((vma->vm_flags ^ vm_flags) & ~VM_SOFTDIRTY)
> > > +	if ((vma->vm_flags ^ vmg->flags) & ~VM_SOFTDIRTY)
> > >  		return false;
> > > -	if (vma->vm_file !=3D file)
> > > +	if (vma->vm_file !=3D vmg->file)
> > >  		return false;
> > >  	if (may_remove_vma && vma->vm_ops && vma->vm_ops->close) =20
> >
> > AFAICS this is the only place where may_remove_vma is used. =20
>=20
> Yes it is, but the point is to document what we're doing. The compiler
> simplifies all this in the generated code.

What's wrong with moving the comment for this variable before this
conditional?

> > =20
> > >  		return false;
> > > -	if (!is_mergeable_vm_userfaultfd_ctx(vma, vm_userfaultfd_ctx))
> > > +	if (!is_mergeable_vm_userfaultfd_ctx(vma, vmg->uffd_ctx))
> > >  		return false;
> > > -	if (!anon_vma_name_eq(anon_vma_name(vma), anon_name))
> > > +	if (!anon_vma_name_eq(anon_vma_name(vma), vmg->anon_name))
> > >  		return false;
> > >  	return true;
> > >  }
> > > @@ -94,16 +96,16 @@ static void init_multi_vma_prep(struct vma_prepar=
e *vp,
> > >   * We assume the vma may be removed as part of the merge.
> > >   */
> > >  bool
> > > -can_vma_merge_before(struct vm_area_struct *vma, unsigned long vm_fl=
ags,
> > > -		struct anon_vma *anon_vma, struct file *file,
> > > -		pgoff_t vm_pgoff, struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
> > > -		struct anon_vma_name *anon_name)
> > > +can_vma_merge_before(struct vma_merge_struct *vmg)
> > >  {
> > > -	if (is_mergeable_vma(vma, file, vm_flags, vm_userfaultfd_ctx, anon_=
name, true) &&
> > > -	    is_mergeable_anon_vma(anon_vma, vma->anon_vma, vma)) {
> > > -		if (vma->vm_pgoff =3D=3D vm_pgoff)
> > > +	pgoff_t pglen =3D PHYS_PFN(vmg->end - vmg->start);
> > > +
> > > +	if (is_mergeable_vma(vmg, true) &&
> > > +	    is_mergeable_anon_vma(vmg->anon_vma, vmg->next->anon_vma, vmg->=
next)) {
> > > +		if (vmg->next->vm_pgoff =3D=3D vmg->pgoff + pglen)
> > >  			return true;
> > >  	}
> > > +
> > >  	return false;
> > >  }
> > >
> > > @@ -116,18 +118,11 @@ can_vma_merge_before(struct vm_area_struct *vma=
, unsigned long vm_flags,
> > >   *
> > >   * We assume that vma is not removed as part of the merge.
> > >   */
> > > -bool
> > > -can_vma_merge_after(struct vm_area_struct *vma, unsigned long vm_fla=
gs,
> > > -		struct anon_vma *anon_vma, struct file *file,
> > > -		pgoff_t vm_pgoff, struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
> > > -		struct anon_vma_name *anon_name)
> > > +bool can_vma_merge_after(struct vma_merge_struct *vmg)
> > >  {
> > > -	if (is_mergeable_vma(vma, file, vm_flags, vm_userfaultfd_ctx, anon_=
name, false) &&
> > > -	    is_mergeable_anon_vma(anon_vma, vma->anon_vma, vma)) {
> > > -		pgoff_t vm_pglen;
> > > -
> > > -		vm_pglen =3D vma_pages(vma);
> > > -		if (vma->vm_pgoff + vm_pglen =3D=3D vm_pgoff)
> > > +	if (is_mergeable_vma(vmg, false) &&
> > > +	    is_mergeable_anon_vma(vmg->anon_vma, vmg->prev->anon_vma, vmg->=
prev)) {
> > > +		if (vmg->prev->vm_pgoff + vma_pages(vmg->prev) =3D=3D vmg->pgoff)
> > >  			return true;
> > >  	}
> > >  	return false;
> > > @@ -180,7 +175,7 @@ void unmap_region(struct mm_struct *mm, struct ma=
_state *mas,
> > >   * VMA Iterator will point to the end VMA.
> > >   */
> > >  static int __split_vma(struct vma_iterator *vmi, struct vm_area_stru=
ct *vma,
> > > -		       unsigned long addr, int new_below)
> > > +		       unsigned long addr, bool new_below)
> > >  {
> > >  	struct vma_prepare vp;
> > >  	struct vm_area_struct *new;
> > > @@ -261,13 +256,14 @@ static int __split_vma(struct vma_iterator *vmi=
, struct vm_area_struct *vma,
> > >   * Split a vma into two pieces at address 'addr', a new vma is alloc=
ated
> > >   * either for the first part or the tail.
> > >   */
> > > -static int split_vma(struct vma_iterator *vmi, struct vm_area_struct=
 *vma,
> > > -		     unsigned long addr, int new_below)
> > > +static int split_vma(struct vma_merge_struct *vmg, bool new_below) =
=20
> >
> > IMHO this patch is already long enough. Maybe the type change from int
> > to bool could be split out to a separate patch to reduce churn here? =20
>=20
> I don't really understand this comment. This reduces the number of lines =
of
> code, and it's a line I have to change anyway, so there'd be _more_ churn
> to split this out?
>=20
> I don't think this is really all that important, but it'd be very silly to
> split this out in my opinion.

Possibly a matter of taste. The churn is further down:

>=20
> > =20
> > >  {
> > > -	if (vma->vm_mm->map_count >=3D sysctl_max_map_count)
> > > +	if (vmg->vma->vm_mm->map_count >=3D sysctl_max_map_count)
> > >  		return -ENOMEM;
> > >
> > > -	return __split_vma(vmi, vma, addr, new_below);
> > > +	return __split_vma(vmg->vmi, vmg->vma,
> > > +			   new_below ? vmg->start : vmg->end,
> > > +			   new_below);
> > >  }
> > >
> > >  /*
> > > @@ -712,7 +708,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, str=
uct vm_area_struct *vma,
> > >  		if (end < vma->vm_end && mm->map_count >=3D sysctl_max_map_count)
> > >  			goto map_count_exceeded;
> > >
> > > -		error =3D __split_vma(vmi, vma, start, 1);
> > > +		error =3D __split_vma(vmi, vma, start, true);

Churn here.

> > >  		if (error)
> > >  			goto start_split_failed;
> > >  	}
> > > @@ -725,7 +721,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, str=
uct vm_area_struct *vma,
> > >  	do {
> > >  		/* Does it split the end? */
> > >  		if (next->vm_end > end) {
> > > -			error =3D __split_vma(vmi, next, end, 0);
> > > +			error =3D __split_vma(vmi, next, end, false);

Churn here.

But you're right, no big deal.

> > >  			if (error)
> > >  				goto end_split_failed;
> > >  		}
> > > @@ -934,16 +930,10 @@ int do_vmi_munmap(struct vma_iterator *vmi, str=
uct mm_struct *mm,
> > >   * **** is not represented - it will be merged and the vma containin=
g the
> > >   *      area is returned, or the function will return NULL
> > >   */
> > > -static struct vm_area_struct
> > > -*vma_merge(struct vma_iterator *vmi, struct vm_area_struct *prev,
> > > -	   struct vm_area_struct *src, unsigned long addr, unsigned long en=
d,
> > > -	   unsigned long vm_flags, pgoff_t pgoff, struct mempolicy *policy,
> > > -	   struct vm_userfaultfd_ctx vm_userfaultfd_ctx,
> > > -	   struct anon_vma_name *anon_name)
> > > +static struct vm_area_struct *vma_merge(struct vma_merge_struct *vmg)
> > >  {
> > > -	struct mm_struct *mm =3D src->vm_mm;
> > > -	struct anon_vma *anon_vma =3D src->anon_vma;
> > > -	struct file *file =3D src->vm_file;
> > > +	struct mm_struct *mm =3D container_of(vmg->vmi->mas.tree, struct mm=
_struct, mm_mt);
> > > +	struct vm_area_struct *prev =3D vmg->prev;
> > >  	struct vm_area_struct *curr, *next, *res;
> > >  	struct vm_area_struct *vma, *adjust, *remove, *remove2;
> > >  	struct vm_area_struct *anon_dup =3D NULL;
> > > @@ -953,16 +943,18 @@ static struct vm_area_struct
> > >  	bool merge_prev =3D false;
> > >  	bool merge_next =3D false;
> > >  	bool vma_expanded =3D false;
> > > +	unsigned long addr =3D vmg->start;
> > > +	unsigned long end =3D vmg->end;
> > >  	unsigned long vma_start =3D addr;
> > >  	unsigned long vma_end =3D end;
> > > -	pgoff_t pglen =3D (end - addr) >> PAGE_SHIFT;
> > > +	pgoff_t pglen =3D PHYS_PFN(end - addr);
> > >  	long adj_start =3D 0;
> > >
> > >  	/*
> > >  	 * We later require that vma->vm_flags =3D=3D vm_flags,
> > >  	 * so this tests vma->vm_flags & VM_SPECIAL, too.
> > >  	 */
> > > -	if (vm_flags & VM_SPECIAL)
> > > +	if (vmg->flags & VM_SPECIAL)
> > >  		return NULL;
> > >
> > >  	/* Does the input range span an existing VMA? (cases 5 - 8) */
> > > @@ -970,27 +962,26 @@ static struct vm_area_struct
> > >
> > >  	if (!curr ||			/* cases 1 - 4 */
> > >  	    end =3D=3D curr->vm_end)	/* cases 6 - 8, adjacent VMA */
> > > -		next =3D vma_lookup(mm, end);
> > > +		next =3D vmg->next =3D vma_lookup(mm, end);
> > >  	else
> > > -		next =3D NULL;		/* case 5 */
> > > +		next =3D vmg->next =3D NULL;	/* case 5 */ =20
> >
> > Again, is it worth keeping the "next" variable, or could we replace it
> > with "vmg->next" everywhere? =20
>=20
> I already responded previously but equally, I'm explicitly using a local
> variable to keep the code relatively simple and to not be constantly
> ostensibly dereferencing vmg.

Yeah, sure. OTOH whoever looks at the code may ask why there is both
"vmg->next" and "next" and if they're really (supposed to be) the same
thing or if there's a subtle difference.

Petr T

