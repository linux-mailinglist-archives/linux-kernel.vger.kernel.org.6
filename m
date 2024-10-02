Return-Path: <linux-kernel+bounces-348222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C9198E44C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 22:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B01AE1F21E53
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 20:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA04D217304;
	Wed,  2 Oct 2024 20:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="hvgh4X9a"
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A58B81720
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 20:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727901563; cv=none; b=UJE5EdK0WeXvF5CLCKfo8ksNmYr3vWk9RQ+MNg4X1eJpQLVhMQiWa3SxyhtVBT50ZG/yryglCs9XsMDGV2b/7HeRcghNSy2HyELezFMeJvLafyK5nWQOsM7bUZqdjbxTGPezKPfwWpH1EHqBcjWKmjjV81h0aptj7AUYwfdJhB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727901563; c=relaxed/simple;
	bh=za8P7SGg0wxIz31IkhU48ejoM8Vx3HeC0URvCDqSBCA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SzwKETYh78oTpmr27MbN5D+tB/QjpJf18zUxTOgh8s3S2ETE4LpKEp1kbGnujqu9aA4zh0ZvKNKFM0zbVYAvwLvLe+64c6Qwj4dBXa6W4g9HBSweHCLeflvhageawngdPF1TCd3HjtbZOf9q+2Se1nTMlLfJ5wNdEmffjyq2qxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=hvgh4X9a; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1727901548; x=1728506348; i=spasswolf@web.de;
	bh=c/zgEF/OV4yrJtrkRQeGzG9pQ86WJ8YfjXe/nmqgoQU=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=hvgh4X9aHBZA1t6FMkMf2QXiM2bJOFaqvmETYGLPXgABqRJcrUMcUv3SW2FwP/Mr
	 B3V/6jUyJuPRpaXwdijSfzXH4zjcT66ce+qYdnTdzF7L6Xv7cjbxu7FYlYY/uyVo5
	 wHMjhRqjJ93IAwe1K4MxMkiWPbtDyjAXMe4zVOffunouq4dk1GwA0vdJau/iQrvJZ
	 2WP0DGSH8RBgeeTcDCcFYpMORrRyJWsoXneovLG5H2G6MSzLwIw1fLQ7ZAgJCTCAe
	 /eydi47sDU7ExvEPi9b1DAA6aqC1Sy+yFXfgJDl/4rbISWQNtQqb4Elm7e0YAudkC
	 tif6LvRz1/wtjTPm2g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([84.119.92.193]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MFrxl-1sfqAW3CXf-00ENmi; Wed, 02
 Oct 2024 22:39:07 +0200
Message-ID: <102b06e5b9004c7b292fb10b245e4fa0aef21ab8.camel@web.de>
Subject: Re: [PATCH v8 14/21] mm/mmap: Avoid zeroing vma tree in
 mmap_region()
From: Bert Karwatzki <spasswolf@web.de>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>, Andrew Morton	
 <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Date: Wed, 02 Oct 2024 22:39:06 +0200
In-Reply-To: <385da45a-16df-4c8b-ae5e-33734e21f827@lucifer.local>
References: <20241001023402.3374-1-spasswolf@web.de>
	 <26991b8a-9fc4-4cf9-99de-048c90e7a683@lucifer.local>
	 <32c0bcb3-4f05-4069-ac18-3fc9f76c6f7f@lucifer.local>
	 <9d8761c5f32e2bad14b23772378a0a856b51003b.camel@web.de>
	 <c63a64a9-cdee-4586-85ba-800e8e1a8054@lucifer.local>
	 <cf72fda8-5fc5-437b-a290-6a2c883e6adf@lucifer.local>
	 <240ede917b6712021481ab356714977e247036b6.camel@web.de>
	 <385da45a-16df-4c8b-ae5e-33734e21f827@lucifer.local>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.54.0-1+b1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rZq9/YylTitabQLMmW+A3NaqwyUD6P25vJ/XYysq7qAtOz3rFxV
 FCJsqudB7XCRAair7/CvTdr0MM11xbf+ysTeyz4c9HMTmXbv+tsYg5er6hlBl+beexjkNqr
 H7w00D4DNzco7TkhSQljiRWW+LKv9eEr4TKaRbYTvdyqzsnwZwwKdLQ2mh+UbSa9HwZf3em
 fxz0mln5s5V2Y/KMRTurQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4UIK5DVrsww=;HLXRRGs/y85mmxZVTzc1y/zJdxG
 YocGsv4uGzRxBTxa1uz7NPwdw8nXeZhb/ixMB6LGnf+rWZ2KCNjTmKWOcx8tQ+LWkl/sWcIu9
 XW3/KKk7ydxakB8AgPsXDqg6rt/+Jm5bSuum0pz/oJx1J+YZH1jM/b3d61JTLjVUu/nJhCRmA
 X5OPJay9H592l5BbOuoENA4dfgjdBaEsWTzEAgIRo69450Tuk/HE1ZiJV89a3zeG/buvt2UBg
 PkT0c32G0ihn3o4xUfRhUSjRlup/y2IpPkG8g4P4zi4CN+CUflOlu1Wwc0W/qjejSokAmtdyH
 ZHKfwaLr3WnXOn4IScsJnXiR0lJo5OYOoluim/ejE5TXRJcO0g0CroYtWkqWV4WPXaCUvFxbA
 XgXjYgWf9oDbZFnd9tCgnZYk0hF8jOB/odq4BUK+wZTxFqRvIkfvHEv+2s9JFmg/+4HrE0dbV
 6mDqByLzIR7Ch1U24xa8dYQCAfXhJUUpAxMs/zgzGgeQHpiyN4aZDcbxKiu3h7Jf4r9UnC380
 HcpYpqt5scAPQXLUyYagpHTuF5m4ly9hyNzarIHPHP4hPfp+pw3KC5KjZ/GQRyLWDn4/MAj8D
 aXR+yb2ADRkrDhOjG+bQ58SET4IVCz99CH7yMAVK6BOTkUDEXfoNS7swp48m5jrnBA8bPy/xP
 +8zs8rcDvHjh6o8brByozlZHu15nscBolCZoLjQV8bwDbMuwbSvUthtBOoObCfprsnsxek1Nn
 H8pR+eiNLKAWptCjBrH2+gJ9JkNQJuaxRLyx8p3o+hYVges/Ay/eZTZhRW8kTM7FP5miVP1k/
 BT1FM0ev8S24uoFn8XAPFxgQ==

Am Mittwoch, dem 02.10.2024 um 21:22 +0100 schrieb Lorenzo Stoakes:
> On Wed, Oct 02, 2024 at 10:06:34PM GMT, Bert Karwatzki wrote:
>
> [snip]
>
> > >
> > > diff --git a/mm/internal.h b/mm/internal.h
> > > index 93083bbeeefa..cd9414b4651d 100644
> > > --- a/mm/internal.h
> > > +++ b/mm/internal.h
> > > @@ -1443,4 +1443,19 @@ static inline void accept_page(struct page *p=
age)
> > >  }
> > >  #endif /* CONFIG_UNACCEPTED_MEMORY */
> > >
> > > +static inline bool check_interesting(unsigned long start, unsigned =
long end)
> > > +{
> > > +	const unsigned long interesting_start =3D 0x1740000;
> > > +	/* Include off-by-one on purpose.*/
> > > +	const unsigned long interesting_end =3D 0x68000000 + 1;
> >
> > In an earlier patch you requested this to be changed to 0x798b1000, is=
 this
> > correct?
> >
>
> Yes, please leave it as it is for now.
>
> > > +
> > > +	/*  interesting_start            interesting_end
> > > +	 *          |--------------------------|
> > > +	 *           =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D> end
> > > +	 *        <=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D   start
> > > +	 */
> > > +	return end > interesting_start && /* after or overlaps... */
> > > +		start < interesting_end;  /* ...overlaps. */
> > > +}
> > > +
> > >  #endif	/* __MM_INTERNAL_H */
> > > diff --git a/mm/mmap.c b/mm/mmap.c
> > > index dd4b35a25aeb..8a1d5c0da86f 100644
> > > --- a/mm/mmap.c
> > > +++ b/mm/mmap.c
> > > @@ -1341,6 +1341,18 @@ struct vm_area_struct *expand_stack(struct mm=
_struct *mm, unsigned long addr)
> > >  	return vma;
> > >  }
> > >
> > > +static void ljs_dump(struct mm_struct *mm,
> > > +		     unsigned long addr, unsigned long len,
> > > +		     vm_flags_t vm_flags, bool is_unmap)
> > > +{
> > > +	if (!check_interesting(addr, addr + len))
> > > +		return;
> > > +
> > > +	pr_err("LJS: %s mm=3D%p [0x%lx, 0x%lx) [vm_flags=3D%lu]\n",
> > > +	       is_unmap ? "munmap" : "mmap", mm, addr, addr + len,
> > > +		vm_flags);
> > > +}
> > > +
> > >  /* do_munmap() - Wrapper function for non-maple tree aware do_munma=
p() calls.
> > >   * @mm: The mm_struct
> > >   * @start: The start address to munmap
> > > @@ -1354,6 +1366,8 @@ int do_munmap(struct mm_struct *mm, unsigned l=
ong start, size_t len,
> > >  {
> > >  	VMA_ITERATOR(vmi, mm, start);
> > >
> > > +	ljs_dump(mm, start, len, 0, true);
> > > +
> > >  	return do_vmi_munmap(&vmi, mm, start, len, uf, false);
> > >  }
> > >
> > > @@ -1375,6 +1389,8 @@ unsigned long mmap_region(struct file *file, u=
nsigned long addr,
> > >  	VMA_ITERATOR(vmi, mm, addr);
> > >  	VMG_STATE(vmg, mm, &vmi, addr, end, vm_flags, pgoff);
> > >
> > > +	ljs_dump(mm, addr, len, vm_flags, false);
> > > +
> > >  	vmg.file =3D file;
> > >  	/* Find the first overlapping VMA */
> > >  	vma =3D vma_find(&vmi, end);
> > > @@ -1390,6 +1406,12 @@ unsigned long mmap_region(struct file *file, =
unsigned long addr,
> > >
> > >  		vmg.next =3D vms.next;
> > >  		vmg.prev =3D vms.prev;
> > > +
> > > +		if (check_interesting(addr, addr + len))
> > > +			pr_err("LJS: prev=3D[%lx, %lx), next=3D[%lx, %lx)\n",
> > > +			       vmg.prev ? vmg.prev->vm_start : 0, vmg.prev ? vmg.prev->v=
m_end : 0,
> > > +			       vmg.next ? vmg.next->vm_start : 0, vmg.next ? vmg.next->v=
m_end : 0);
> > > +
> > >  		vma =3D NULL;
> > >  	} else {
> > >  		vmg.next =3D vma_iter_next_rewind(&vmi, &vmg.prev);
> > > @@ -1413,9 +1435,29 @@ unsigned long mmap_region(struct file *file, =
unsigned long addr,
> > >  		vmg.flags =3D vm_flags;
> > >  	}
> > >
> > > +	if (check_interesting(addr, addr + len)) {
> > > +		char *special =3D vm_flags & VM_SPECIAL ? "special" : "";
> > > +		char *has_file =3D file ? "file-backed" : "";
> > > +
> > > +		pr_err("LJS: Interesting [%lx, %lx) flags=3D%lu, special=3D[%s] f=
ile=3D[%s]\n",
> > > +		       addr, addr+len, vm_flags, special, has_file);
> > > +	}
> > > +
> > >  	vma =3D vma_merge_new_range(&vmg);
> > > -	if (vma)
> > > +	if (vma) {
> > > +		if (check_interesting(addr, addr + len)) {
> > > +			pr_err("LJS: Merged to [%lx, %lx), addr=3D%lx, end=3D%lx\n",
> > > +			       vma->vm_start, vma->vm_end, vma_iter_addr(&vmi),
> > > +			       vma_iter_end(&vmi));
> > > +
> > > +			mt_validate(&mm->mm_mt);
> > > +		}
> > > +
> > >  		goto expanded;
> > > +	} else if (check_interesting(addr, addr + len)) {
> > > +		pr_err("LJS: Failed to merge [%lx, %lx), reset...\n",
> > > +		       addr, addr + len);
> > > +	}
> > >  	/*
> > >  	 * Determine the object being mapped and call the appropriate
> > >  	 * specific mapper. the address has already been validated, but
> > > @@ -1441,6 +1483,11 @@ unsigned long mmap_region(struct file *file, =
unsigned long addr,
> > >  		if (error)
> > >  			goto unmap_and_free_vma;
> > >
> > > +		if (check_interesting(addr, addr + len)) {
> > > +			pr_err("LJS: call_mmap() on [%lx, %lx) old_flags=3D%lu new_flags=
=3D%lu new range=3D[%lx, %lx)\n",
> > > +			       addr, addr + end, vm_flags, vma->vm_flags, vma->vm_start,=
 vma->vm_end);
> > > +		}
> > > +
> > >  		if (vma_is_shared_maywrite(vma)) {
> > >  			error =3D mapping_map_writable(file->f_mapping);
> > >  			if (error)
> > > @@ -1467,6 +1514,11 @@ unsigned long mmap_region(struct file *file, =
unsigned long addr,
> > >  			/* If this fails, state is reset ready for a reattempt. */
> > >  			merge =3D vma_merge_new_range(&vmg);
> > >
> > > +			if (check_interesting(addr, addr + len))
> > > +				pr_err("LJS: flags changed for [%lx, %lx) from %lu to %lu %s",
> > > +				       vma->vm_start, vma->vm_end, vm_flags, vma->vm_flags,
> > > +				       merge ? "merged" : "");
> > > +
> > >  			if (merge) {
> > >  				/*
> > >  				 * ->mmap() can change vma->vm_file and fput
> > > @@ -1510,10 +1562,18 @@ unsigned long mmap_region(struct file *file,=
 unsigned long addr,
> > >
> > >  	/* Lock the VMA since it is modified after insertion into VMA tree=
 */
> > >  	vma_start_write(vma);
> > > +
> > > +	if (check_interesting(addr, addr + len))
> > > +		pr_err("LJS: mm=3D%p: iter store addr=3D%lx, end=3D%lx, vma=3D[%l=
x, %lx)\n",
> > > +		       mm, vma_iter_addr(&vmi), vma_iter_end(&vmi), vma->vm_start=
, vma->vm_end);
> > > +
> > >  	vma_iter_store(&vmi, vma);
> > >  	mm->map_count++;
> > >  	vma_link_file(vma);
> > >
> > > +	if (check_interesting(addr, addr + len))
> > > +		mt_validate(&mm->mm_mt);
> > > +
> > >  	/*
> > >  	 * vma_merge_new_range() calls khugepaged_enter_vma() too, the bel=
ow
> > >  	 * call covers the non-merge case.
> > > @@ -1530,6 +1590,10 @@ unsigned long mmap_region(struct file *file, =
unsigned long addr,
> > >  	perf_event_mmap(vma);
> > >
> > >  	/* Unmap any existing mapping in the area */
> > > +
> > > +	if (check_interesting(addr, addr + len))
> > > +		mt_validate(&mm->mm_mt);
> > > +
> > >  	vms_complete_munmap_vmas(&vms, &mas_detach);
> > >
> > >  	vm_stat_account(mm, vm_flags, pglen);
> > > diff --git a/mm/vma.c b/mm/vma.c
> > > index 4737afcb064c..33f80e82704b 100644
> > > --- a/mm/vma.c
> > > +++ b/mm/vma.c
> > > @@ -1108,8 +1108,13 @@ void vms_clean_up_area(struct vma_munmap_stru=
ct *vms,
> > >  	vms_clear_ptes(vms, mas_detach, true);
> > >  	mas_set(mas_detach, 0);
> > >  	mas_for_each(mas_detach, vma, ULONG_MAX)
> > > -		if (vma->vm_ops && vma->vm_ops->close)
> > > +		if (vma->vm_ops && vma->vm_ops->close) {
> > > +			if (check_interesting(vma->vm_start, vma->vm_end))
> > > +				pr_err("LJS: mm=3D%p Closing [%lx, %lx)\n",
> > > +				       vma->vm_mm, vma->vm_start, vma->vm_end);
> > > +
> > >  			vma->vm_ops->close(vma);
> > > +		}
> > >  	vms->closed_vm_ops =3D true;
> > >  }
> > >
> > > @@ -1179,6 +1184,10 @@ int vms_gather_munmap_vmas(struct vma_munmap_=
struct *vms,
> > >  	struct vm_area_struct *next =3D NULL;
> > >  	int error;
> > >
> > > +	if (check_interesting(vms->vma->vm_start, vms->vma->vm_end))
> > > +		pr_err("LJS2 vms->start=3D%lx, vms->vma->vm_start=3D%lx\n",
> > > +		       vms->start, vms->vma->vm_start);
> > > +
> > >  	/*
> > >  	 * If we need to split any vma, do it now to save pain later.
> > >  	 * Does it split the first one?
> > > @@ -1202,6 +1211,11 @@ int vms_gather_munmap_vmas(struct vma_munmap_=
struct *vms,
> > >  			goto start_split_failed;
> > >  		}
> > >
> > > +		if (check_interesting(vms->vma->vm_start, vms->vma->vm_end))
> > > +			pr_err("LJS: mm=3D%p vms=3D[%lx, %lx) split START of [%lx, %lx)\=
n",
> > > +			       vms->vma->vm_mm, vms->start, vms->end,
> > > +			       vms->vma->vm_start, vms->vma->vm_end);
> > > +
> > >  		error =3D __split_vma(vms->vmi, vms->vma, vms->start, 1);
> > >  		if (error)
> > >  			goto start_split_failed;
> > > @@ -1217,12 +1231,23 @@ int vms_gather_munmap_vmas(struct vma_munmap=
_struct *vms,
> > >  	for_each_vma_range(*(vms->vmi), next, vms->end) {
> > >  		long nrpages;
> > >
> > > +		if (check_interesting(vms->vma->vm_start, vms->vma->vm_end))
> > > +			pr_err("LJS: mm=3D%p vms=3D[%lx, %lx) UNMAP [%lx, %lx)\n",
> > > +			       vms->vma->vm_mm, vms->start, vms->end,
> > > +			       next->vm_start, next->vm_end);
> > > +
> > >  		if (!can_modify_vma(next)) {
> > >  			error =3D -EPERM;
> > >  			goto modify_vma_failed;
> > >  		}
> > >  		/* Does it split the end? */
> > >  		if (next->vm_end > vms->end) {
> > > +
> > > +			if (check_interesting(next->vm_start, next->vm_end))
> > > +				pr_err("LJS: mm=3D%p vms=3D[%lx, %lx) split END of [%lx, %lx)\n=
",
> > > +				       next->vm_mm, vms->start, vms->end,
> > > +				       next->vm_start, next->vm_end);
> > > +
> > >  			error =3D __split_vma(vms->vmi, next, vms->end, 0);
> > >  			if (error)
> > >  				goto end_split_failed;
> > > @@ -1295,9 +1320,14 @@ int vms_gather_munmap_vmas(struct vma_munmap_=
struct *vms,
> > >  	}
> > >  #endif
> > >
> > > -	while (vma_iter_addr(vms->vmi) > vms->start)
> > > +	while (vma_iter_addr(vms->vmi) > vms->start) {
> > >  		vma_iter_prev_range(vms->vmi);
> > >
> > > +		if (check_interesting(vms->vma->vm_start, vms->vma->vm_end))
> > > +			pr_err("LJS3: addr=3D%lx, vms->start=3D%lx\n",
> > > +			       vma_iter_addr(vms->vmi), vms->start);
> > > +	}
> > > +
> > >  	vms->clear_ptes =3D true;
> > >  	return 0;
> > >
> > > --
> > > 2.46.2
> >
> > I just tested the "hunch" commit (without this patch) and it crashed i=
n the same
> > way. Here are more detailed instructions of how I create the crash:
> >
> > The game used is Rogue Heroes: Ruins of Tasos (which is basically Zeld=
a). The
> > game itself does not work anymore (even on unaffected kernel versions)=
, it has
> > been crashing with a
> >
> > Unhandled Exception:
> > Microsoft.Xna.Framework.Graphics.NoSuitableGraphicsDeviceException: Fa=
iled to
> > create graphics device! ---> System.TypeInitializationException: The t=
ype
> > initializer for 'Microsoft.Xna.Framework.Graphics.GraphicsAdapter' thr=
ew an
> > exception. ---> SharpDX.SharpDXException: HRESULT: [0x80004005], Modul=
e:
> > [General], ApiCode: [E_FAIL/Unspecified error], Message: Call failed.
> >
> > error for sometime (probably a year).
> >
> > 1. Go to Properties->Compatibility and select "Force the use of specif=
ic Steam
> > Play compatibility tool" and the select Proton 7.0-6
> > 2. start the game, the game should then crash with the Xna error above
> > 3. Go to Properties->Compatibility and unselect "Force the use of spec=
ific Steam
> > Play compatibility tool"
> > 4. start the game again, this will usually give the vma error (on two =
occasions
> > so far the whole procedure (1-4) had to be done twice to get the error=
.
> >
>
> Thanks for this, however the game does work for me, at least on nvidia :=
)) I
> continue to suspect an amd-specific issue here. I will try on my intel g=
pu
> laptop too.
>
> > Bert Karwatzki
> >

I just figured out what was wrong for me in "Ruins of Tasos", I didn't hav=
e the
32bit vulkan drivers installed, so perhaps if you remove your 32bit vulkan
driver package you can get the crash, too.

Bert Karwatzki

