Return-Path: <linux-kernel+bounces-348194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A6398E3E9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 22:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EBE21C225CA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 20:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5FE6216A0E;
	Wed,  2 Oct 2024 20:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b="AudRSOGn"
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1A719309D
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 20:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727899616; cv=none; b=lclyqJNq2BOacEcZq+WqNtbQoyr5ev6zR4rkZddv2xmnfp4uJJ3eDcUEQRrrDxslsopvB6NLI7fklKYu5Oya47J7vxfSuXAtbJ9Zg0rTx37fewAOXd9yTdANQJYcxioMjSDXpPq8Y+IwADdpWM6AmMAa1lnaCp8SNRTAwRmAb+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727899616; c=relaxed/simple;
	bh=Cz9KVmWTwIzMIc9kBgvhUQXN3k6OZN84iA+dMjB8uLo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O+QSYV3z5IFEySF+exbUei36m/Adq83ejF6bXdZVGY8p4HtfnkWrzYrt1VRjIyvYEszNPZX8UYuvDp/bpd+kwhtY2/ElpaG8UiD8TCMOce748Jg26QoySy5uIA8JHsA2znGHijRNby9I0Plhz7vQcvERhbZj1Vi2Bt8PgFqiI5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=spasswolf@web.de header.b=AudRSOGn; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1727899596; x=1728504396; i=spasswolf@web.de;
	bh=O/9AnSPJNtnYzr7XqNjR1lVuMX5wODXBfBxDwgJ0C90=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=AudRSOGnpbrIJ+ZSTkqABis7ZoGwokIuBRmozXzP8JRVII0Fimx5dFWxtVEGQqRo
	 ee33bUZs4GYY4SQVfNWFykBUqpSJO9vciBdz3u3v1MprQDoTF7ySSuoA79feNXbrH
	 Dv8yp3Z/PcC+ld+aeteW4VeyAoMuoguFTz3X1CbZQVBO3RP2ZhvNzAo92QV+a6WdR
	 q1o66F6WDlrgiN5/KMmRviRPbuI5naoRp4yle8rTnTPFy3+n02FCe3jGvfC0z2r0w
	 cuEQzzsa+HnmOCcqFXd7ppmkjr+h7f0JPc3AidqwimezLixbbh71nTIUIF7qezFib
	 /P+u26p5kICxvPWwoQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([84.119.92.193]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MZjET-1sQVid0aBz-00Y6Nf; Wed, 02
 Oct 2024 22:06:36 +0200
Message-ID: <240ede917b6712021481ab356714977e247036b6.camel@web.de>
Subject: Re: [PATCH v8 14/21] mm/mmap: Avoid zeroing vma tree in
 mmap_region()
From: Bert Karwatzki <spasswolf@web.de>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>, Andrew Morton	
 <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, 	spasswolf@web.de
Date: Wed, 02 Oct 2024 22:06:34 +0200
In-Reply-To: <cf72fda8-5fc5-437b-a290-6a2c883e6adf@lucifer.local>
References: <20241001023402.3374-1-spasswolf@web.de>
	 <26991b8a-9fc4-4cf9-99de-048c90e7a683@lucifer.local>
	 <32c0bcb3-4f05-4069-ac18-3fc9f76c6f7f@lucifer.local>
	 <9d8761c5f32e2bad14b23772378a0a856b51003b.camel@web.de>
	 <c63a64a9-cdee-4586-85ba-800e8e1a8054@lucifer.local>
	 <cf72fda8-5fc5-437b-a290-6a2c883e6adf@lucifer.local>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.54.0-1+b1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/DX4XP5qEdB1EnxRmMu6mAs9vPOfiqEZJVonUDiGvxNEaip3Ky0
 O5WXe+KjDZHq8NuenTMRjiz24hYphFTg0r2d5PCT8mAvhSUe36NnI+wn/UdkJz+8X9t6Jyo
 e6+KSQzI8CYHuPv12aROAw6uK+qiqhzpu/vj39QLgy12hKoB0umIcOgE8UtQi8BfXyWiXve
 ov1WAqi2AYfrk8VQx6o2A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:FVpI1L+kVwo=;csBhj3FqJF0tMJbBqd3sMccP+HH
 sNjLhGlCfd8PduxePPAiYf9eo79Gx9XGFt70fCnFWDZtwInF+17Mjx0HJuQzcyEqvTD9YgMvw
 UL12qn0AgJzgctCY56dPSSuyMNob95ZZx5X1hPk1mj8gWpPVb/kjGd42rAuvTvZOG9xA2eRlB
 UgjKTbhmsxwNP6tu6Iro1WoXPjuu1JjdfDd3qADj7MRMK9o8HHV/D2Wv2QktyI92P1w8YnVna
 wgh1STXoyUvBY2cQ0dXSYUsY+8TaA8eaWuZEqBNXdrOMwjeTQF1SGEEbCLruG7waK7U5TssuL
 gkuOIRgoyLTaeSsNtxcGAGAswjWR9Vybyr6Wok2/7SIzr90/AQ7EfCbqf7pER4OXCJ2isL+Re
 5JdJ62Q3dIN9bmJjOXeJds7bGevu4VrqmQBbGAQhb9aDo4LRVLrxkLj434tvd+wuHebQu5aKl
 5fklrymEVUFvdFnCBumBDNCy2f4CSassjI8CR9fqDlmg7KwSIp8Zuu/7qH6XhlXkEfQfKg5eU
 oplcaGtoS2BujRvFs+oSsC6VCVvHQ4FvO7Tk9SMD7ZZbgB1bUL7p96Mg6tE3S4cG/YL1BNOMQ
 4gKSyFRVHfUPih8TcBTCOcd9+HwPuuswvU9+fvJyHlGOoOZFxoX4dPFkfNDqFApnHTVHcLDW2
 er83J43rnhcah1DJ4MqK4Z9Nwxz21Jld/wK26fKVNQ9fz6Oxz/zEIk8Hb6Et/mfkVjttJGNWf
 Fs5fOsMZDdlQSjBZeu1CpEdJwLg+BTy9jzOryZXoRvhqkLgtlTJT9f2Rm6tr7yXXZu6eJAtQD
 l5ZCmahAl4xtewS+ISnPB24w==

Am Mittwoch, dem 02.10.2024 um 19:28 +0100 schrieb Lorenzo Stoakes:
> On Wed, Oct 02, 2024 at 06:19:18PM GMT, Lorenzo Stoakes wrote:
>
> [snip]
>
> >
> > Current status - I litearlly cannot repro this even doing exactly what=
 you're
> > doing, so I wonder if your exact GPU or a file system you're using or =
something
> > is a factor here and there's something which implements a custom .mmap=
 callback
> > or vm_ops->close() that is somehow interfacing with this, or if this b=
eing a
> > file thing is somehow a factor.
> >
> > Recreating the scenario as best I can with anon mappings, it seems imm=
ediately
> > before it triggers we are in the position on the left in the range wit=
h the
> > problematic node, and then immediately after we are in the right (plus=
 an
> > invalid entry/pivot for 0x68000000).
> >
> > The final action that triggers the problem is mapping [0x1b90000, 0x1b=
ae000)
> > PROT_NONE, MAP_RESERVE which merges with A and D, and we unmap B and C=
:
> >
> > 01740000-017c0000 ---p 00000000 00:00 0       01740000-017c0000 ---p 0=
0000000 00:00 0
> > 017c0000-01b40000 rw-p 00000000 00:00 0	      017c0000-01b40000 rw-p 0=
0000000 00:00 0
> > 01b40000-01b50000 ---p 00000000 00:00 0	      01b40000-01b50000 ---p 0=
0000000 00:00 0
> > 01b50000-01b56000 rw-p 00000000 00:00 0	      01b50000-01b56000 rw-p 0=
0000000 00:00 0
> > 01b56000-01b60000 ---p 00000000 00:00 0	      01b56000-01b60000 ---p 0=
0000000 00:00 0
> > 01b60000-01b70000 ---p 00000000 00:00 0	      01b60000-01b70000 ---p 0=
0000000 00:00 0
> > 01b70000-01b80000 ---p 00000000 00:00 0	      01b70000-01b80000 ---p 0=
0000000 00:00 0
> > 01b80000-01b86000 rw-p 00000000 00:00 0	      01b80000-01b86000 rw-p 0=
0000000 00:00 0
> > 01b86000-01b90000 ---p 00000000 00:00 0 * A   01b86000-68000000 ---p 0=
0000000 00:00 0
> > 01b90000-01b91000 rwxp 00000000 00:00 0 * B   < invalid 0x68000000 ent=
ry/pivot >
> > 01b91000-01bae000 rw-p 00000000 00:00 0 * C
> > 01bae000-68000000 ---p 00000000 00:00 0 * D
> >
> > It seems based on some of the VMA flags that we _must_ be mapping file=
s here,
> > e.g. some have VM_EXEC and others are mising VM_MAYREAD which indicate=
s a
> > read-only file mapping. Probably given low addresses we are setting up=
 a binary
> > set of mappings or such? Would align with PROT_NONE mappings also.
> >
> > This really makes me think, combined with the fact I really _cannot_ r=
epro this
> > (on intel GPU hardware and ext4 file system) that there are some 'spec=
ial'
> > mappings going on here.
> >
> > The fact we're unmapping 2 VMAs and then removing a final one in a mer=
ge does
> > suggest something is going wrong in the interaction between these two =
events.
> >
> > I wonder if the merge logic is possibly struggling with the (detached =
but
> > present) VMAs still being there as we try to expand an existing VMA?
> >
> > Though my money's on a call_mmap() or .close() call doing something we=
ird here.
> >
> > Investigation carries on...
>
> Hey Bert - sorry to be a pain, but try as I might I cannot repro this.
>
> I've attached a quite thorough hacky printk patch here, it's going to
> generate a ton of noise, so I really think this one has to be a link to =
an
> off-list dmesg or we're going to break lei again, sorry Andrew.
>
> If you could repro with this patch applied + the usual debug config
> settings and send it back I'd appreciate it!
>
> This should hopefully eek out a little more information to help figure
> things out.
>
> Also if you could share your .config, ulimit -a and
> /proc/sys/vm/max_map_count that'd be great too, thanks!
>
> Again, much much appreciated.
>
> Cheers, Lorenzo
>
> ----8<----
> From d85fb5d2fd096e84681bdb6da8b5d37f0464ff84 Mon Sep 17 00:00:00 2001
> From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Date: Wed, 2 Oct 2024 09:19:28 +0100
> Subject: [PATCH] hack: mm: see if we can get some more information
>
> Add some dreadful printk() hacks so we can try to get some more informat=
ion
> on what's going on.
> ---
>  mm/internal.h | 15 ++++++++++++
>  mm/mmap.c     | 66 ++++++++++++++++++++++++++++++++++++++++++++++++++-
>  mm/vma.c      | 34 ++++++++++++++++++++++++--
>  3 files changed, 112 insertions(+), 3 deletions(-)
>
> diff --git a/mm/internal.h b/mm/internal.h
> index 93083bbeeefa..cd9414b4651d 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -1443,4 +1443,19 @@ static inline void accept_page(struct page *page)
>  }
>  #endif /* CONFIG_UNACCEPTED_MEMORY */
>
> +static inline bool check_interesting(unsigned long start, unsigned long=
 end)
> +{
> +	const unsigned long interesting_start =3D 0x1740000;
> +	/* Include off-by-one on purpose.*/
> +	const unsigned long interesting_end =3D 0x68000000 + 1;

In an earlier patch you requested this to be changed to 0x798b1000, is thi=
s
correct?

> +
> +	/*  interesting_start            interesting_end
> +	 *          |--------------------------|
> +	 *           =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D> end
> +	 *        <=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D   start
> +	 */
> +	return end > interesting_start && /* after or overlaps... */
> +		start < interesting_end;  /* ...overlaps. */
> +}
> +
>  #endif	/* __MM_INTERNAL_H */
> diff --git a/mm/mmap.c b/mm/mmap.c
> index dd4b35a25aeb..8a1d5c0da86f 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1341,6 +1341,18 @@ struct vm_area_struct *expand_stack(struct mm_str=
uct *mm, unsigned long addr)
>  	return vma;
>  }
>
> +static void ljs_dump(struct mm_struct *mm,
> +		     unsigned long addr, unsigned long len,
> +		     vm_flags_t vm_flags, bool is_unmap)
> +{
> +	if (!check_interesting(addr, addr + len))
> +		return;
> +
> +	pr_err("LJS: %s mm=3D%p [0x%lx, 0x%lx) [vm_flags=3D%lu]\n",
> +	       is_unmap ? "munmap" : "mmap", mm, addr, addr + len,
> +		vm_flags);
> +}
> +
>  /* do_munmap() - Wrapper function for non-maple tree aware do_munmap() =
calls.
>   * @mm: The mm_struct
>   * @start: The start address to munmap
> @@ -1354,6 +1366,8 @@ int do_munmap(struct mm_struct *mm, unsigned long =
start, size_t len,
>  {
>  	VMA_ITERATOR(vmi, mm, start);
>
> +	ljs_dump(mm, start, len, 0, true);
> +
>  	return do_vmi_munmap(&vmi, mm, start, len, uf, false);
>  }
>
> @@ -1375,6 +1389,8 @@ unsigned long mmap_region(struct file *file, unsig=
ned long addr,
>  	VMA_ITERATOR(vmi, mm, addr);
>  	VMG_STATE(vmg, mm, &vmi, addr, end, vm_flags, pgoff);
>
> +	ljs_dump(mm, addr, len, vm_flags, false);
> +
>  	vmg.file =3D file;
>  	/* Find the first overlapping VMA */
>  	vma =3D vma_find(&vmi, end);
> @@ -1390,6 +1406,12 @@ unsigned long mmap_region(struct file *file, unsi=
gned long addr,
>
>  		vmg.next =3D vms.next;
>  		vmg.prev =3D vms.prev;
> +
> +		if (check_interesting(addr, addr + len))
> +			pr_err("LJS: prev=3D[%lx, %lx), next=3D[%lx, %lx)\n",
> +			       vmg.prev ? vmg.prev->vm_start : 0, vmg.prev ? vmg.prev->vm_en=
d : 0,
> +			       vmg.next ? vmg.next->vm_start : 0, vmg.next ? vmg.next->vm_en=
d : 0);
> +
>  		vma =3D NULL;
>  	} else {
>  		vmg.next =3D vma_iter_next_rewind(&vmi, &vmg.prev);
> @@ -1413,9 +1435,29 @@ unsigned long mmap_region(struct file *file, unsi=
gned long addr,
>  		vmg.flags =3D vm_flags;
>  	}
>
> +	if (check_interesting(addr, addr + len)) {
> +		char *special =3D vm_flags & VM_SPECIAL ? "special" : "";
> +		char *has_file =3D file ? "file-backed" : "";
> +
> +		pr_err("LJS: Interesting [%lx, %lx) flags=3D%lu, special=3D[%s] file=
=3D[%s]\n",
> +		       addr, addr+len, vm_flags, special, has_file);
> +	}
> +
>  	vma =3D vma_merge_new_range(&vmg);
> -	if (vma)
> +	if (vma) {
> +		if (check_interesting(addr, addr + len)) {
> +			pr_err("LJS: Merged to [%lx, %lx), addr=3D%lx, end=3D%lx\n",
> +			       vma->vm_start, vma->vm_end, vma_iter_addr(&vmi),
> +			       vma_iter_end(&vmi));
> +
> +			mt_validate(&mm->mm_mt);
> +		}
> +
>  		goto expanded;
> +	} else if (check_interesting(addr, addr + len)) {
> +		pr_err("LJS: Failed to merge [%lx, %lx), reset...\n",
> +		       addr, addr + len);
> +	}
>  	/*
>  	 * Determine the object being mapped and call the appropriate
>  	 * specific mapper. the address has already been validated, but
> @@ -1441,6 +1483,11 @@ unsigned long mmap_region(struct file *file, unsi=
gned long addr,
>  		if (error)
>  			goto unmap_and_free_vma;
>
> +		if (check_interesting(addr, addr + len)) {
> +			pr_err("LJS: call_mmap() on [%lx, %lx) old_flags=3D%lu new_flags=3D%=
lu new range=3D[%lx, %lx)\n",
> +			       addr, addr + end, vm_flags, vma->vm_flags, vma->vm_start, vma=
->vm_end);
> +		}
> +
>  		if (vma_is_shared_maywrite(vma)) {
>  			error =3D mapping_map_writable(file->f_mapping);
>  			if (error)
> @@ -1467,6 +1514,11 @@ unsigned long mmap_region(struct file *file, unsi=
gned long addr,
>  			/* If this fails, state is reset ready for a reattempt. */
>  			merge =3D vma_merge_new_range(&vmg);
>
> +			if (check_interesting(addr, addr + len))
> +				pr_err("LJS: flags changed for [%lx, %lx) from %lu to %lu %s",
> +				       vma->vm_start, vma->vm_end, vm_flags, vma->vm_flags,
> +				       merge ? "merged" : "");
> +
>  			if (merge) {
>  				/*
>  				 * ->mmap() can change vma->vm_file and fput
> @@ -1510,10 +1562,18 @@ unsigned long mmap_region(struct file *file, uns=
igned long addr,
>
>  	/* Lock the VMA since it is modified after insertion into VMA tree */
>  	vma_start_write(vma);
> +
> +	if (check_interesting(addr, addr + len))
> +		pr_err("LJS: mm=3D%p: iter store addr=3D%lx, end=3D%lx, vma=3D[%lx, %=
lx)\n",
> +		       mm, vma_iter_addr(&vmi), vma_iter_end(&vmi), vma->vm_start, vm=
a->vm_end);
> +
>  	vma_iter_store(&vmi, vma);
>  	mm->map_count++;
>  	vma_link_file(vma);
>
> +	if (check_interesting(addr, addr + len))
> +		mt_validate(&mm->mm_mt);
> +
>  	/*
>  	 * vma_merge_new_range() calls khugepaged_enter_vma() too, the below
>  	 * call covers the non-merge case.
> @@ -1530,6 +1590,10 @@ unsigned long mmap_region(struct file *file, unsi=
gned long addr,
>  	perf_event_mmap(vma);
>
>  	/* Unmap any existing mapping in the area */
> +
> +	if (check_interesting(addr, addr + len))
> +		mt_validate(&mm->mm_mt);
> +
>  	vms_complete_munmap_vmas(&vms, &mas_detach);
>
>  	vm_stat_account(mm, vm_flags, pglen);
> diff --git a/mm/vma.c b/mm/vma.c
> index 4737afcb064c..33f80e82704b 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -1108,8 +1108,13 @@ void vms_clean_up_area(struct vma_munmap_struct *=
vms,
>  	vms_clear_ptes(vms, mas_detach, true);
>  	mas_set(mas_detach, 0);
>  	mas_for_each(mas_detach, vma, ULONG_MAX)
> -		if (vma->vm_ops && vma->vm_ops->close)
> +		if (vma->vm_ops && vma->vm_ops->close) {
> +			if (check_interesting(vma->vm_start, vma->vm_end))
> +				pr_err("LJS: mm=3D%p Closing [%lx, %lx)\n",
> +				       vma->vm_mm, vma->vm_start, vma->vm_end);
> +
>  			vma->vm_ops->close(vma);
> +		}
>  	vms->closed_vm_ops =3D true;
>  }
>
> @@ -1179,6 +1184,10 @@ int vms_gather_munmap_vmas(struct vma_munmap_stru=
ct *vms,
>  	struct vm_area_struct *next =3D NULL;
>  	int error;
>
> +	if (check_interesting(vms->vma->vm_start, vms->vma->vm_end))
> +		pr_err("LJS2 vms->start=3D%lx, vms->vma->vm_start=3D%lx\n",
> +		       vms->start, vms->vma->vm_start);
> +
>  	/*
>  	 * If we need to split any vma, do it now to save pain later.
>  	 * Does it split the first one?
> @@ -1202,6 +1211,11 @@ int vms_gather_munmap_vmas(struct vma_munmap_stru=
ct *vms,
>  			goto start_split_failed;
>  		}
>
> +		if (check_interesting(vms->vma->vm_start, vms->vma->vm_end))
> +			pr_err("LJS: mm=3D%p vms=3D[%lx, %lx) split START of [%lx, %lx)\n",
> +			       vms->vma->vm_mm, vms->start, vms->end,
> +			       vms->vma->vm_start, vms->vma->vm_end);
> +
>  		error =3D __split_vma(vms->vmi, vms->vma, vms->start, 1);
>  		if (error)
>  			goto start_split_failed;
> @@ -1217,12 +1231,23 @@ int vms_gather_munmap_vmas(struct vma_munmap_str=
uct *vms,
>  	for_each_vma_range(*(vms->vmi), next, vms->end) {
>  		long nrpages;
>
> +		if (check_interesting(vms->vma->vm_start, vms->vma->vm_end))
> +			pr_err("LJS: mm=3D%p vms=3D[%lx, %lx) UNMAP [%lx, %lx)\n",
> +			       vms->vma->vm_mm, vms->start, vms->end,
> +			       next->vm_start, next->vm_end);
> +
>  		if (!can_modify_vma(next)) {
>  			error =3D -EPERM;
>  			goto modify_vma_failed;
>  		}
>  		/* Does it split the end? */
>  		if (next->vm_end > vms->end) {
> +
> +			if (check_interesting(next->vm_start, next->vm_end))
> +				pr_err("LJS: mm=3D%p vms=3D[%lx, %lx) split END of [%lx, %lx)\n",
> +				       next->vm_mm, vms->start, vms->end,
> +				       next->vm_start, next->vm_end);
> +
>  			error =3D __split_vma(vms->vmi, next, vms->end, 0);
>  			if (error)
>  				goto end_split_failed;
> @@ -1295,9 +1320,14 @@ int vms_gather_munmap_vmas(struct vma_munmap_stru=
ct *vms,
>  	}
>  #endif
>
> -	while (vma_iter_addr(vms->vmi) > vms->start)
> +	while (vma_iter_addr(vms->vmi) > vms->start) {
>  		vma_iter_prev_range(vms->vmi);
>
> +		if (check_interesting(vms->vma->vm_start, vms->vma->vm_end))
> +			pr_err("LJS3: addr=3D%lx, vms->start=3D%lx\n",
> +			       vma_iter_addr(vms->vmi), vms->start);
> +	}
> +
>  	vms->clear_ptes =3D true;
>  	return 0;
>
> --
> 2.46.2

I just tested the "hunch" commit (without this patch) and it crashed in th=
e same
way. Here are more detailed instructions of how I create the crash:

The game used is Rogue Heroes: Ruins of Tasos (which is basically Zelda). =
The
game itself does not work anymore (even on unaffected kernel versions), it=
 has
been crashing with a

Unhandled Exception:
Microsoft.Xna.Framework.Graphics.NoSuitableGraphicsDeviceException: Failed=
 to
create graphics device! ---> System.TypeInitializationException: The type
initializer for 'Microsoft.Xna.Framework.Graphics.GraphicsAdapter' threw a=
n
exception. ---> SharpDX.SharpDXException: HRESULT: [0x80004005], Module:
[General], ApiCode: [E_FAIL/Unspecified error], Message: Call failed.

error for sometime (probably a year).

1. Go to Properties->Compatibility and select "Force the use of specific S=
team
Play compatibility tool" and the select Proton 7.0-6
2. start the game, the game should then crash with the Xna error above
3. Go to Properties->Compatibility and unselect "Force the use of specific=
 Steam
Play compatibility tool"
4. start the game again, this will usually give the vma error (on two occa=
sions
so far the whole procedure (1-4) had to be done twice to get the error.

Bert Karwatzki


