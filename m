Return-Path: <linux-kernel+bounces-329950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B1A89797DF
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 18:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F4B81C20C32
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2024 16:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA071C9DCE;
	Sun, 15 Sep 2024 16:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="OFt/KO26"
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0BB17BA7
	for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2024 16:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726419374; cv=none; b=Fdd5Hc//QTvaNQsnpmNA+0XnnAFpJPuXhMYVRxudonzygl1++72BOysHKksgN6gAtKWNlqFNF06pDS0jnT9ZO3lved1PYkT3QvwGiApZJN7hTRbdIoM8fEO5vy6Y560aqsSZtfKjpwn1MrHjJm1rtykHeh08Lq0eHPAPjHjmxXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726419374; c=relaxed/simple;
	bh=Hc0OgOxoYGGFjBVPDg84kNnAPJI/CfIuupDMDx0KGq4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E4lETh5BTg/D1ZulrEeUeHF9o7txR3/6Ko9ohgR6sCpqPoHB6/D3Cpk6hzoZhQpeg/bxtg0TtJ/ZFcyAC7oappar0FPxNVl8Quj5KEtzp/cxVErRKHd/OwsDeXosBIfiQ4HdNZjRbTg9rJZh0qfOFu3DZ5edJLVqJx8v7/NgXL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=OFt/KO26; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=zYjFOxhIc6gg0NkYVM/96e0omPWTOB1ufw2hZ+jyrUc=;
	t=1726419373; x=1727628973; b=OFt/KO26FCUCux9NFnL5oNAw2IMJ5aMys9af/H8Dq8uVwns
	q482vfzj94/EBVxD1I3NRF156wyDClncctiLUHZKTINiCkzq8CxoIXvxNnrJ9poX26YYPWPhk3tAE
	w+XcCEBXT5E9Rg9gvA3E5bGiUTgK61PC9hN1kyP4s+i5wWQZ3ihFCi1m27B1hGIc+lyTPWCfMILvk
	xF5cRQxzfIVARQdUu6M8T6qaAr3CloGN63mhu9mmFxMsU05yx8Bsqxdqtf3zIM2YHwMg36VNSZbWv
	k6S4HgOYfOv7CuiUrMsWfE6xOZWb2GTG53a23UM1Z76U8Ssoj2LHspPUvlGjyqdg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1spsXX-00000007VaX-0alN;
	Sun, 15 Sep 2024 18:55:59 +0200
Message-ID: <56a679e9ea6a6e6c7d9316608f25fd691001e8dc.camel@sipsolutions.net>
Subject: Re: [PATCH 2/3] um: Remove highmem leftovers
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Tiwei Bie <tiwei.btw@antgroup.com>, richard@nod.at, 
	anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Sun, 15 Sep 2024 18:55:49 +0200
In-Reply-To: <20240913142137.248245-3-tiwei.btw@antgroup.com>
References: <20240913142137.248245-1-tiwei.btw@antgroup.com>
	 <20240913142137.248245-3-tiwei.btw@antgroup.com>
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

does that mean we can also drop the 3-level page table support on i386?
It seems like the two level page table is entirely sufficient on a
system without high memory (i.e. only 32bit physical addresses).

When I took a look at it for the 4-level page table support on 64 bit I
got a bit confused. But I had not realized that highmem support had
been removed.

Benjamin

On Fri, 2024-09-13 at 22:21 +0800, Tiwei Bie wrote:
> Highmem was only supported on UML/i386. And the support has been
> removed by commit a98a6d864d3b ("um: Remove broken highmem support").
> Remove the leftovers and stop UML from trying to setup highmem when
> the sum of physmem_size and iomem_size exceeds max_physmem.
>=20
> Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
> ---
> =C2=A0arch/um/drivers/virtio_uml.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 9 +--------
> =C2=A0arch/um/include/shared/as-layout.h |=C2=A0 1 -
> =C2=A0arch/um/include/shared/mem_user.h=C2=A0 |=C2=A0 5 ++---
> =C2=A0arch/um/kernel/mem.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 3 ---
> =C2=A0arch/um/kernel/physmem.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 30 +++++++++++-----------------
> --
> =C2=A0arch/um/kernel/um_arch.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 17 +++++++----------
> =C2=A06 files changed, 21 insertions(+), 44 deletions(-)
>=20
> diff --git a/arch/um/drivers/virtio_uml.c
> b/arch/um/drivers/virtio_uml.c
> index 2b6e701776b6..e7f5556e3c96 100644
> --- a/arch/um/drivers/virtio_uml.c
> +++ b/arch/um/drivers/virtio_uml.c
> @@ -72,7 +72,7 @@ struct virtio_uml_vq_info {
> =C2=A0	bool suspended;
> =C2=A0};
> =C2=A0
> -extern unsigned long long physmem_size, highmem;
> +extern unsigned long long physmem_size;
> =C2=A0
> =C2=A0#define vu_err(vu_dev, ...)	dev_err(&(vu_dev)->pdev->dev,
> ##__VA_ARGS__)
> =C2=A0
> @@ -673,13 +673,6 @@ static int vhost_user_set_mem_table(struct
> virtio_uml_device *vu_dev)
> =C2=A0
> =C2=A0	if (rc < 0)
> =C2=A0		return rc;
> -	if (highmem) {
> -		msg.payload.mem_regions.num++;
> -		rc =3D vhost_user_init_mem_region(__pa(end_iomem),
> highmem,
> -				&fds[1],
> &msg.payload.mem_regions.regions[1]);
> -		if (rc < 0)
> -			return rc;
> -	}
> =C2=A0
> =C2=A0	return vhost_user_send(vu_dev, false, &msg, fds,
> =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 msg.payload.mem_regions.num=
);
> diff --git a/arch/um/include/shared/as-layout.h
> b/arch/um/include/shared/as-layout.h
> index 06292fca5a4d..61965a06c18a 100644
> --- a/arch/um/include/shared/as-layout.h
> +++ b/arch/um/include/shared/as-layout.h
> @@ -41,7 +41,6 @@ extern unsigned long uml_physmem;
> =C2=A0extern unsigned long uml_reserved;
> =C2=A0extern unsigned long end_vm;
> =C2=A0extern unsigned long start_vm;
> -extern unsigned long long highmem;
> =C2=A0
> =C2=A0extern unsigned long brk_start;
> =C2=A0
> diff --git a/arch/um/include/shared/mem_user.h
> b/arch/um/include/shared/mem_user.h
> index 11a723a58545..adfa08062f88 100644
> --- a/arch/um/include/shared/mem_user.h
> +++ b/arch/um/include/shared/mem_user.h
> @@ -47,10 +47,9 @@ extern int iomem_size;
> =C2=A0#define ROUND_4M(n) ((((unsigned long) (n)) + (1 << 22)) & ~((1 <<
> 22) - 1))
> =C2=A0
> =C2=A0extern unsigned long find_iomem(char *driver, unsigned long
> *len_out);
> -extern void mem_total_pages(unsigned long physmem, unsigned long
> iomem,
> -		=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long highmem);
> +extern void mem_total_pages(unsigned long physmem, unsigned long
> iomem);
> =C2=A0extern void setup_physmem(unsigned long start, unsigned long usable=
,
> -			=C2=A0 unsigned long len, unsigned long long
> highmem);
> +			=C2=A0 unsigned long len);
> =C2=A0extern void map_memory(unsigned long virt, unsigned long phys,
> =C2=A0		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long len, int r, in=
t w, int x);
> =C2=A0
> diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
> index a5b4fe2ad931..5026668dc054 100644
> --- a/arch/um/kernel/mem.c
> +++ b/arch/um/kernel/mem.c
> @@ -6,7 +6,6 @@
> =C2=A0#include <linux/stddef.h>
> =C2=A0#include <linux/module.h>
> =C2=A0#include <linux/memblock.h>
> -#include <linux/highmem.h>
> =C2=A0#include <linux/mm.h>
> =C2=A0#include <linux/swap.h>
> =C2=A0#include <linux/slab.h>
> @@ -51,8 +50,6 @@ EXPORT_SYMBOL(empty_zero_page);
> =C2=A0pgd_t swapper_pg_dir[PTRS_PER_PGD];
> =C2=A0
> =C2=A0/* Initialized at boot time, and readonly after that */
> -unsigned long long highmem;
> -EXPORT_SYMBOL(highmem);
> =C2=A0int kmalloc_ok =3D 0;
> =C2=A0
> =C2=A0/* Used during early boot */
> diff --git a/arch/um/kernel/physmem.c b/arch/um/kernel/physmem.c
> index fb2adfb49945..cc5238c1bf1e 100644
> --- a/arch/um/kernel/physmem.c
> +++ b/arch/um/kernel/physmem.c
> @@ -24,17 +24,14 @@ EXPORT_SYMBOL(high_physmem);
> =C2=A0
> =C2=A0extern unsigned long long physmem_size;
> =C2=A0
> -void __init mem_total_pages(unsigned long physmem, unsigned long
> iomem,
> -		=C2=A0=C2=A0=C2=A0=C2=A0 unsigned long highmem)
> +void __init mem_total_pages(unsigned long physmem, unsigned long
> iomem)
> =C2=A0{
> -	unsigned long phys_pages, highmem_pages;
> -	unsigned long iomem_pages, total_pages;
> +	unsigned long phys_pages, iomem_pages, total_pages;
> =C2=A0
> -	phys_pages=C2=A0=C2=A0=C2=A0 =3D physmem >> PAGE_SHIFT;
> -	iomem_pages=C2=A0=C2=A0 =3D iomem=C2=A0=C2=A0 >> PAGE_SHIFT;
> -	highmem_pages =3D highmem >> PAGE_SHIFT;
> +	phys_pages=C2=A0 =3D physmem >> PAGE_SHIFT;
> +	iomem_pages =3D iomem=C2=A0=C2=A0 >> PAGE_SHIFT;
> =C2=A0
> -	total_pages=C2=A0=C2=A0 =3D phys_pages + iomem_pages + highmem_pages;
> +	total_pages =3D phys_pages + iomem_pages;
> =C2=A0
> =C2=A0	max_mapnr =3D total_pages;
> =C2=A0}
> @@ -64,13 +61,12 @@ void map_memory(unsigned long virt, unsigned long
> phys, unsigned long len,
> =C2=A0 * @reserve_end:	end address of the physical kernel memory.
> =C2=A0 * @len:	Length of total physical memory that should be
> mapped/made
> =C2=A0 *		available, in bytes.
> - * @highmem:	Number of highmem bytes that should be mapped/made
> available.
> =C2=A0 *
> - * Creates an unlinked temporary file of size (len + highmem) and
> memory maps
> + * Creates an unlinked temporary file of size (len) and memory maps
> =C2=A0 * it on the last executable image address (uml_reserved).
> =C2=A0 *
> =C2=A0 * The offset is needed as the length of the total physical memory
> - * (len + highmem) includes the size of the memory used be the
> executable image,
> + * (len) includes the size of the memory used be the executable
> image,
> =C2=A0 * but the mapped-to address is the last address of the executable
> image
> =C2=A0 * (uml_reserved =3D=3D end address of executable image).
> =C2=A0 *
> @@ -78,19 +74,19 @@ void map_memory(unsigned long virt, unsigned long
> phys, unsigned long len,
> =C2=A0 * of all user space processes/kernel tasks.
> =C2=A0 */
> =C2=A0void __init setup_physmem(unsigned long start, unsigned long
> reserve_end,
> -			=C2=A0 unsigned long len, unsigned long long
> highmem)
> +			=C2=A0 unsigned long len)
> =C2=A0{
> =C2=A0	unsigned long reserve =3D reserve_end - start;
> =C2=A0	long map_size =3D len - reserve;
> =C2=A0	int err;
> =C2=A0
> -	if(map_size <=3D 0) {
> +	if (map_size <=3D 0) {
> =C2=A0		os_warn("Too few physical memory! Needed=3D%lu,
> given=3D%lu\n",
> =C2=A0			reserve, len);
> =C2=A0		exit(1);
> =C2=A0	}
> =C2=A0
> -	physmem_fd =3D create_mem_file(len + highmem);
> +	physmem_fd =3D create_mem_file(len);
> =C2=A0
> =C2=A0	err =3D os_map_memory((void *) reserve_end, physmem_fd,
> reserve,
> =C2=A0			=C2=A0=C2=A0=C2=A0 map_size, 1, 1, 1);
> @@ -109,7 +105,7 @@ void __init setup_physmem(unsigned long start,
> unsigned long reserve_end,
> =C2=A0	os_write_file(physmem_fd, __syscall_stub_start, PAGE_SIZE);
> =C2=A0	os_fsync_file(physmem_fd);
> =C2=A0
> -	memblock_add(__pa(start), len + highmem);
> +	memblock_add(__pa(start), len);
> =C2=A0	memblock_reserve(__pa(start), reserve);
> =C2=A0
> =C2=A0	min_low_pfn =3D PFN_UP(__pa(reserve_end));
> @@ -137,10 +133,6 @@ int phys_mapping(unsigned long phys, unsigned
> long long *offset_out)
> =C2=A0			region =3D region->next;
> =C2=A0		}
> =C2=A0	}
> -	else if (phys < __pa(end_iomem) + highmem) {
> -		fd =3D physmem_fd;
> -		*offset_out =3D phys - iomem_size;
> -	}
> =C2=A0
> =C2=A0	return fd;
> =C2=A0}
> diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
> index 8e594cda6d77..8f86aa468b50 100644
> --- a/arch/um/kernel/um_arch.c
> +++ b/arch/um/kernel/um_arch.c
> @@ -366,18 +366,15 @@ int __init linux_main(int argc, char **argv)
> =C2=A0
> =C2=A0	setup_machinename(init_utsname()->machine);
> =C2=A0
> -	highmem =3D 0;
> +	physmem_size =3D (physmem_size + PAGE_SIZE - 1) & PAGE_MASK;
> =C2=A0	iomem_size =3D (iomem_size + PAGE_SIZE - 1) & PAGE_MASK;
> +
> =C2=A0	max_physmem =3D TASK_SIZE - uml_physmem - iomem_size -
> MIN_VMALLOC;
> =C2=A0
> -	/*
> -	 * Zones have to begin on a 1 << MAX_PAGE_ORDER page
> boundary,
> -	 * so this makes sure that's true for highmem
> -	 */
> -	max_physmem &=3D ~((1 << (PAGE_SHIFT + MAX_PAGE_ORDER)) - 1);
> =C2=A0	if (physmem_size + iomem_size > max_physmem) {
> -		highmem =3D physmem_size + iomem_size - max_physmem;
> -		physmem_size -=3D highmem;
> +		physmem_size =3D max_physmem - iomem_size;
> +		os_info("Physical memory size shrunk to %llu
> bytes\n",
> +			physmem_size);
> =C2=A0	}
> =C2=A0
> =C2=A0	high_physmem =3D uml_physmem + physmem_size;
> @@ -413,8 +410,8 @@ void __init setup_arch(char **cmdline_p)
> =C2=A0	u8 rng_seed[32];
> =C2=A0
> =C2=A0	stack_protections((unsigned long) &init_thread_info);
> -	setup_physmem(uml_physmem, uml_reserved, physmem_size,
> highmem);
> -	mem_total_pages(physmem_size, iomem_size, highmem);
> +	setup_physmem(uml_physmem, uml_reserved, physmem_size);
> +	mem_total_pages(physmem_size, iomem_size);
> =C2=A0	uml_dtb_init();
> =C2=A0	read_initrd();
> =C2=A0


