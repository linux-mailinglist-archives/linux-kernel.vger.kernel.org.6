Return-Path: <linux-kernel+bounces-360692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F5C999E1A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 09:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E07AC1F23DF5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 07:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C64209F46;
	Fri, 11 Oct 2024 07:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="rZFN0QPZ"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1FE209676
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 07:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728632374; cv=none; b=g8XcHx21G02a7B6oToOXoLh50C7weBc0eroawRbT1lmO+zBFaUPh+cdvXVReeHSeN11uGrRd9NuYs+lvrwcYeYySX1Xh7idDgDScn8psBZx6Kth595TeqR++sEc7620gIg2nsTMQGyg0QTdUuWoV5CNfsF867Xu+ooig5Pdpm08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728632374; c=relaxed/simple;
	bh=T5zSxvb/dBQPWkqL8hYCcFHvoaYT40LRnYA/JRG5k98=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aKBDb62hd+B8Fh+wysHKizswjXX/u6JaPtbIm9UosffC0vfMh3B5oZIWqaRxlnXtTmBXzqhbdq8vnDFnw045xB3Oo0LuqI1+fWKkdzpu6u/XuVZ0Hma/v0/FPz8THU4QbbUxdJgDJSh8hoppdVVs6clBNOW6205F1TXV1+KS0ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=rZFN0QPZ; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=+08wgX1e861sgSH/F9mHPoEt1THIiXUKLgterN2sqLU=;
	t=1728632372; x=1729841972; b=rZFN0QPZerbAvh0x5fVsezVjo/NeqrXSbyTgJWLPEealoa0
	JY4reriJ0LBZMAM1Vciq1sWyGfsXjNwvnevuyvE87euJYN7XoZQRZkNFEfj5XuZzdU9cdq9fq91a8
	cejUK70LtzU6EKibl/CFKe5r2xWmmOBnIXMAbrh7jTG0qln9D76zAxNYCwbcintKhO2l97oHZWUmV
	J7IxFe48BHs4Shia6KEwsKVISgFi81H9g7TqVt6dis2ewXnTs6M8pq5pU2Kw4G4RibFPv2DkTx3T2
	jI85XPNf1AQZe9oxispCjgJd2tLr3jB535m5D5laSZToqVbLTGnk8FJeE7lyG1eg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1szAFC-00000006ziv-346n;
	Fri, 11 Oct 2024 09:39:26 +0200
Message-ID: <6abc79186ace90cd2abe202a4abe0eaf17eebb5f.camel@sipsolutions.net>
Subject: Re: [PATCH] um: Abandon the _PAGE_NEWPROT bit
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Tiwei Bie <tiwei.btw@antgroup.com>, richard@nod.at, 
	anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Fri, 11 Oct 2024 09:39:24 +0200
In-Reply-To: <20241011053843.1623089-1-tiwei.btw@antgroup.com>
References: <20241011053843.1623089-1-tiwei.btw@antgroup.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

Hi,

On Fri, 2024-10-11 at 13:38 +0800, Tiwei Bie wrote:
> When a PTE is updated in the page table, the _PAGE_NEWPAGE bit will
> always be set. And the corresponding page will always be mapped or
> unmapped depending on whether the PTE is present or not. The check
> on the _PAGE_NEWPROT bit is not really reachable. Abandoning it will
> allow us to simplify the code and remove the unreachable code.

Oh, nice cleanup!

And I like that mprotect is gone as I don't want it in SECCOMP mode :-)

Maybe we should rename _PAGE_NEWPAGE to something like _PAGE_NEEDSYNC?
I think that might make it more clear how everything ties together.

Anyway, the change looks good to me.

Benjamin

Reviewed-by: Benjamin Berg <benjamin.berg@intel.com>

> Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
> ---
> =C2=A0arch/um/include/asm/pgtable.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 40 ++++-----------
> =C2=A0arch/um/include/shared/os.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 -
> =C2=A0arch/um/include/shared/skas/stub-data.h |=C2=A0 1 -
> =C2=A0arch/um/kernel/skas/stub.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 10 ----
> =C2=A0arch/um/kernel/tlb.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 66 =
+++++++++++------------
> --
> =C2=A0arch/um/os-Linux/skas/mem.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 21 --------
> =C2=A06 files changed, 37 insertions(+), 103 deletions(-)
>=20
> diff --git a/arch/um/include/asm/pgtable.h
> b/arch/um/include/asm/pgtable.h
> index bd7a9593705f..a32424cfe792 100644
> --- a/arch/um/include/asm/pgtable.h
> +++ b/arch/um/include/asm/pgtable.h
> @@ -12,7 +12,6 @@
> =C2=A0
> =C2=A0#define _PAGE_PRESENT	0x001
> =C2=A0#define _PAGE_NEWPAGE	0x002
> -#define _PAGE_NEWPROT	0x004
> =C2=A0#define _PAGE_RW	0x020
> =C2=A0#define _PAGE_USER	0x040
> =C2=A0#define _PAGE_ACCESSED	0x080
> @@ -151,23 +150,12 @@ static inline int pte_newpage(pte_t pte)
> =C2=A0	return pte_get_bits(pte, _PAGE_NEWPAGE);
> =C2=A0}
> =C2=A0
> -static inline int pte_newprot(pte_t pte)
> -{
> -	return(pte_present(pte) && (pte_get_bits(pte,
> _PAGE_NEWPROT)));
> -}
> -
> =C2=A0/*
> =C2=A0 * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =C2=A0 * Flags setting section.
> =C2=A0 * =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =C2=A0 */
> =C2=A0
> -static inline pte_t pte_mknewprot(pte_t pte)
> -{
> -	pte_set_bits(pte, _PAGE_NEWPROT);
> -	return(pte);
> -}
> -
> =C2=A0static inline pte_t pte_mkclean(pte_t pte)
> =C2=A0{
> =C2=A0	pte_clear_bits(pte, _PAGE_DIRTY);
> @@ -184,17 +172,14 @@ static inline pte_t pte_wrprotect(pte_t pte)
> =C2=A0{
> =C2=A0	if (likely(pte_get_bits(pte, _PAGE_RW)))
> =C2=A0		pte_clear_bits(pte, _PAGE_RW);
> -	else
> -		return pte;
> -	return(pte_mknewprot(pte));
> +	return pte;
> =C2=A0}
> =C2=A0
> =C2=A0static inline pte_t pte_mkread(pte_t pte)
> =C2=A0{
> -	if (unlikely(pte_get_bits(pte, _PAGE_USER)))
> -		return pte;
> -	pte_set_bits(pte, _PAGE_USER);
> -	return(pte_mknewprot(pte));
> +	if (likely(!pte_get_bits(pte, _PAGE_USER)))
> +		pte_set_bits(pte, _PAGE_USER);
> +	return pte;
> =C2=A0}
> =C2=A0
> =C2=A0static inline pte_t pte_mkdirty(pte_t pte)
> @@ -211,18 +196,15 @@ static inline pte_t pte_mkyoung(pte_t pte)
> =C2=A0
> =C2=A0static inline pte_t pte_mkwrite_novma(pte_t pte)
> =C2=A0{
> -	if (unlikely(pte_get_bits(pte,=C2=A0 _PAGE_RW)))
> -		return pte;
> -	pte_set_bits(pte, _PAGE_RW);
> -	return(pte_mknewprot(pte));
> +	if (likely(!pte_get_bits(pte, _PAGE_RW)))
> +		pte_set_bits(pte, _PAGE_RW);
> +	return pte;
> =C2=A0}
> =C2=A0
> =C2=A0static inline pte_t pte_mkuptodate(pte_t pte)
> =C2=A0{
> =C2=A0	pte_clear_bits(pte, _PAGE_NEWPAGE);
> -	if(pte_present(pte))
> -		pte_clear_bits(pte, _PAGE_NEWPROT);
> -	return(pte);
> +	return pte;
> =C2=A0}
> =C2=A0
> =C2=A0static inline pte_t pte_mknewpage(pte_t pte)
> @@ -236,12 +218,10 @@ static inline void set_pte(pte_t *pteptr, pte_t
> pteval)
> =C2=A0	pte_copy(*pteptr, pteval);
> =C2=A0
> =C2=A0	/* If it's a swap entry, it needs to be marked _PAGE_NEWPAGE
> so
> -	 * fix_range knows to unmap it.=C2=A0 _PAGE_NEWPROT is specific
> to
> -	 * mapped pages.
> +	 * update_pte_range knows to unmap it.
> =C2=A0	 */
> =C2=A0
> =C2=A0	*pteptr =3D pte_mknewpage(*pteptr);
> -	if(pte_present(*pteptr)) *pteptr =3D pte_mknewprot(*pteptr);
> =C2=A0}
> =C2=A0
> =C2=A0#define PFN_PTE_SHIFT		PAGE_SHIFT
> @@ -298,8 +278,6 @@ static inline int pte_same(pte_t pte_a, pte_t
> pte_b)
> =C2=A0	({ pte_t pte;					\
> =C2=A0							\
> =C2=A0	pte_set_val(pte, page_to_phys(page), (pgprot));	\
> -	if (pte_present(pte))				\
> -		pte_mknewprot(pte_mknewpage(pte));	\
> =C2=A0	pte;})
> =C2=A0
> =C2=A0static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
> diff --git a/arch/um/include/shared/os.h
> b/arch/um/include/shared/os.h
> index bf539fee7831..09f8201de5db 100644
> --- a/arch/um/include/shared/os.h
> +++ b/arch/um/include/shared/os.h
> @@ -279,8 +279,6 @@ int map(struct mm_id *mm_idp, unsigned long virt,
> =C2=A0	unsigned long len, int prot, int phys_fd,
> =C2=A0	unsigned long long offset);
> =C2=A0int unmap(struct mm_id *mm_idp, unsigned long addr, unsigned long
> len);
> -int protect(struct mm_id *mm_idp, unsigned long addr,
> -	=C2=A0=C2=A0=C2=A0 unsigned long len, unsigned int prot);
> =C2=A0
> =C2=A0/* skas/process.c */
> =C2=A0extern int is_skas_winch(int pid, int fd, void *data);
> diff --git a/arch/um/include/shared/skas/stub-data.h
> b/arch/um/include/shared/skas/stub-data.h
> index 3fbdda727373..81a4cace032c 100644
> --- a/arch/um/include/shared/skas/stub-data.h
> +++ b/arch/um/include/shared/skas/stub-data.h
> @@ -30,7 +30,6 @@ enum stub_syscall_type {
> =C2=A0	STUB_SYSCALL_UNSET =3D 0,
> =C2=A0	STUB_SYSCALL_MMAP,
> =C2=A0	STUB_SYSCALL_MUNMAP,
> -	STUB_SYSCALL_MPROTECT,
> =C2=A0};
> =C2=A0
> =C2=A0struct stub_syscall {
> diff --git a/arch/um/kernel/skas/stub.c b/arch/um/kernel/skas/stub.c
> index 5d52ffa682dc..796fc266d3bb 100644
> --- a/arch/um/kernel/skas/stub.c
> +++ b/arch/um/kernel/skas/stub.c
> @@ -35,16 +35,6 @@ static __always_inline int syscall_handler(struct
> stub_data *d)
> =C2=A0				return -1;
> =C2=A0			}
> =C2=A0			break;
> -		case STUB_SYSCALL_MPROTECT:
> -			res =3D stub_syscall3(__NR_mprotect,
> -					=C2=A0=C2=A0=C2=A0 sc->mem.addr, sc-
> >mem.length,
> -					=C2=A0=C2=A0=C2=A0 sc->mem.prot);
> -			if (res) {
> -				d->err =3D res;
> -				d->syscall_data_len =3D i;
> -				return -1;
> -			}
> -			break;
> =C2=A0		default:
> =C2=A0			d->err =3D -95; /* EOPNOTSUPP */
> =C2=A0			d->syscall_data_len =3D i;
> diff --git a/arch/um/kernel/tlb.c b/arch/um/kernel/tlb.c
> index 548af31d4111..23c1f550cd7c 100644
> --- a/arch/um/kernel/tlb.c
> +++ b/arch/um/kernel/tlb.c
> @@ -23,9 +23,6 @@ struct vm_ops {
> =C2=A0		=C2=A0=C2=A0=C2=A0 int phys_fd, unsigned long long offset);
> =C2=A0	int (*unmap)(struct mm_id *mm_idp,
> =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long virt, unsigned long len);
> -	int (*mprotect)(struct mm_id *mm_idp,
> -			unsigned long virt, unsigned long len,
> -			unsigned int prot);
> =C2=A0};
> =C2=A0
> =C2=A0static int kern_map(struct mm_id *mm_idp,
> @@ -44,15 +41,6 @@ static int kern_unmap(struct mm_id *mm_idp,
> =C2=A0	return os_unmap_memory((void *)virt, len);
> =C2=A0}
> =C2=A0
> -static int kern_mprotect(struct mm_id *mm_idp,
> -			 unsigned long virt, unsigned long len,
> -			 unsigned int prot)
> -{
> -	return os_protect_memory((void *)virt, len,
> -				 prot & UM_PROT_READ, prot &
> UM_PROT_WRITE,
> -				 1);
> -}
> -
> =C2=A0void report_enomem(void)
> =C2=A0{
> =C2=A0	printk(KERN_ERR "UML ran out of memory on the host side! "
> @@ -65,33 +53,37 @@ static inline int update_pte_range(pmd_t *pmd,
> unsigned long addr,
> =C2=A0				=C2=A0=C2=A0 struct vm_ops *ops)
> =C2=A0{
> =C2=A0	pte_t *pte;
> -	int r, w, x, prot, ret =3D 0;
> +	int ret =3D 0;
> =C2=A0
> =C2=A0	pte =3D pte_offset_kernel(pmd, addr);
> =C2=A0	do {
> -		r =3D pte_read(*pte);
> -		w =3D pte_write(*pte);
> -		x =3D pte_exec(*pte);
> -		if (!pte_young(*pte)) {
> -			r =3D 0;
> -			w =3D 0;
> -		} else if (!pte_dirty(*pte))
> -			w =3D 0;
> -
> -		prot =3D ((r ? UM_PROT_READ : 0) | (w ? UM_PROT_WRITE
> : 0) |
> -			(x ? UM_PROT_EXEC : 0));
> -		if (pte_newpage(*pte)) {
> -			if (pte_present(*pte)) {
> -				__u64 offset;
> -				unsigned long phys =3D pte_val(*pte) &
> PAGE_MASK;
> -				int fd =3D phys_mapping(phys,
> &offset);
> -
> -				ret =3D ops->mmap(ops->mm_idp, addr,
> PAGE_SIZE,
> -						prot, fd, offset);
> -			} else
> -				ret =3D ops->unmap(ops->mm_idp, addr,
> PAGE_SIZE);
> -		} else if (pte_newprot(*pte))
> -			ret =3D ops->mprotect(ops->mm_idp, addr,
> PAGE_SIZE, prot);
> +		if (!pte_newpage(*pte))
> +			continue;
> +
> +		if (pte_present(*pte)) {
> +			__u64 offset;
> +			unsigned long phys =3D pte_val(*pte) &
> PAGE_MASK;
> +			int fd =3D phys_mapping(phys, &offset);
> +			int r, w, x, prot;
> +
> +			r =3D pte_read(*pte);
> +			w =3D pte_write(*pte);
> +			x =3D pte_exec(*pte);
> +			if (!pte_young(*pte)) {
> +				r =3D 0;
> +				w =3D 0;
> +			} else if (!pte_dirty(*pte))
> +				w =3D 0;
> +
> +			prot =3D (r ? UM_PROT_READ : 0) |
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (w ? UM_PROT_WRITE : 0) |
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (x ? UM_PROT_EXEC : 0);
> +
> +			ret =3D ops->mmap(ops->mm_idp, addr,
> PAGE_SIZE,
> +					prot, fd, offset);
> +		} else
> +			ret =3D ops->unmap(ops->mm_idp, addr,
> PAGE_SIZE);
> +
> =C2=A0		*pte =3D pte_mkuptodate(*pte);
> =C2=A0	} while (pte++, addr +=3D PAGE_SIZE, ((addr < end) && !ret));
> =C2=A0	return ret;
> @@ -180,11 +172,9 @@ int um_tlb_sync(struct mm_struct *mm)
> =C2=A0	if (mm =3D=3D &init_mm) {
> =C2=A0		ops.mmap =3D kern_map;
> =C2=A0		ops.unmap =3D kern_unmap;
> -		ops.mprotect =3D kern_mprotect;
> =C2=A0	} else {
> =C2=A0		ops.mmap =3D map;
> =C2=A0		ops.unmap =3D unmap;
> -		ops.mprotect =3D protect;
> =C2=A0	}
> =C2=A0
> =C2=A0	pgd =3D pgd_offset(mm, addr);
> diff --git a/arch/um/os-Linux/skas/mem.c b/arch/um/os-
> Linux/skas/mem.c
> index 9a13ac23c606..d7f1814b0e5a 100644
> --- a/arch/um/os-Linux/skas/mem.c
> +++ b/arch/um/os-Linux/skas/mem.c
> @@ -217,24 +217,3 @@ int unmap(struct mm_id *mm_idp, unsigned long
> addr, unsigned long len)
> =C2=A0
> =C2=A0	return 0;
> =C2=A0}
> -
> -int protect(struct mm_id *mm_idp, unsigned long addr, unsigned long
> len,
> -	=C2=A0=C2=A0=C2=A0 unsigned int prot)
> -{
> -	struct stub_syscall *sc;
> -
> -	/* Compress with previous syscall if that is possible */
> -	sc =3D syscall_stub_get_previous(mm_idp,
> STUB_SYSCALL_MPROTECT, addr);
> -	if (sc && sc->mem.prot =3D=3D prot) {
> -		sc->mem.length +=3D len;
> -		return 0;
> -	}
> -
> -	sc =3D syscall_stub_alloc(mm_idp);
> -	sc->syscall =3D STUB_SYSCALL_MPROTECT;
> -	sc->mem.addr =3D addr;
> -	sc->mem.length =3D len;
> -	sc->mem.prot =3D prot;
> -
> -	return 0;
> -}


