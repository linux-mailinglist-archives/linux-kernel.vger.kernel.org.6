Return-Path: <linux-kernel+bounces-573374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8154A6D683
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 09:43:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A5C1188AEAF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 08:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956FE1DFF0;
	Mon, 24 Mar 2025 08:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="eMJ3g99Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BSfO6oxA"
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16B5200CB
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 08:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742805782; cv=none; b=Wl9SedIHfqNgZvsU/Rm6C97W3bJv+yGN9upagjuRxj8N3h0jf154RU6E1dqlIPKsznWBVLaGTwoLhi9U9YEK/lv/VCfH153EAgXveuiVdhviPCTBfDu703MLTh5zoH5y6PrXelxmmoe/mSqlT9d+B+o6jClY2r4R8lW+wvFhWyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742805782; c=relaxed/simple;
	bh=ycOg5IKMHPKpgJbedMyST9/3B0t5g8eFieS6PBgUfn8=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=uKM7SaznO7kRJe53pglWZ3rbcmV8FuvaXVYYoBXuFLkZQ5XmNhFIoznw1SVLcL+L0a7mbW41g+7v6syoRMEFnzC4PMNRDKnizggqmRcCy09TU/x4THjR+Tfe4BjB/QCLYmr/XtZhb62aA9rKLitRKol0dGIfAhxSLaxLvYeSHtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=eMJ3g99Y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BSfO6oxA; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BC9A211400C4;
	Mon, 24 Mar 2025 04:42:59 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-07.internal (MEProxy); Mon, 24 Mar 2025 04:42:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1742805779;
	 x=1742892179; bh=ooYuA0uM53YxnENt+atSUcEUD65s+aUhDXD6jeflgG8=; b=
	eMJ3g99Yzd9c4BoOVLfrKG/FuaQnaGtQaOKsWzqgQUJYektzgB4mNYbHM5hPL/Y2
	yMNIGARDPEK9gtWnk6b/1Wd6GUQvcLhbjcRedyCLpBXz+M3pkgKZtg3fW2/N26Oq
	CwTHAZ5Q2Oe5XRtx6pzRFDidKQJvHMrx+nddzru9/VO6CoaPXkenn4fCSMav3ZYf
	ZkE6qtAFGaEgQkNFfi+8XWBYEC+5zYFGhllX/tpsBXw9LCOgoMCFWJKgAKWu1SVC
	orisL8qdIkyuYGbrg+Gk/10yQgnyNaQrn/Zn2gzG8xtwAm3KT0CQn2eAhlCtMwO9
	Uvr+jg4KF79afpCOv3oGaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1742805779; x=
	1742892179; bh=ooYuA0uM53YxnENt+atSUcEUD65s+aUhDXD6jeflgG8=; b=B
	SfO6oxApSVgj0TrkS6W3wVKULQ6hAQa3lp77kCWvQ8e/xZOtuIQyRAmW3rpe4QVQ
	yLUsoZiaB1QXnBg7VkR4iYL8cFoFdDKVoXBjZ0RPeE7UBRBcfdW8olZfRhKxXu6Q
	LsxvF/tDPh+EfCewAc8TdJoaX7MabBNBxPsouqJS/UhzggXgeSdY+BU1wx13Dn88
	am7JAV0bi3HFpu9cGjb2QkCdC9ZTOw00XEWoGYBFjRtRd0sO5wnhPyemBaG9N2i2
	msdFnm6cxxzBl2uTtZCBwKD4ScxlF7LyjWLRa45Q9erytJiTNhwArL9qA51j6nwa
	anon86oFjBrId9t5uGP8A==
X-ME-Sender: <xms:ERvhZzZ10boHAWOzwyKM9cHp7Pv8Iys7qWERv-ZxbBkOfsGRkFO0jQ>
    <xme:ERvhZyaIO-SaWeBPZqS9e6M8VUE9ltw3IPtpQZeuiJzxoG08GXGTSDQv3Eg01_3e1
    1lyRVjRbuyU4cW_uPc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduheelfedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertder
    tdejnecuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnug
    gsrdguvgeqnecuggftrfgrthhtvghrnhepvdfhvdekueduveffffetgfdvveefvdelhedv
    vdegjedvfeehtdeggeevheefleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohep
    vddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrnhhshhhumhgrnhdrkhhhrg
    hnughurghlsegrrhhmrdgtohhmpdhrtghpthhtoheptggrthgrlhhinhdrmhgrrhhinhgr
    shesrghrmhdrtghomhdprhgtphhtthhopehrhigrnhdrrhhosggvrhhtshesrghrmhdrtg
    homhdprhgtphhtthhopehvihhntggvnhiiohdrfhhrrghstghinhhosegrrhhmrdgtohhm
    pdhrtghpthhtoheptghuihihuhhnhhhuihessgihthgvuggrnhgtvgdrtghomhdprhgtph
    htthhopehluhiguhdrkhgvrhhnvghlsegshihtvggurghntggvrdgtohhmpdhrtghpthht
    ohepshhtuhgrrhhtrdhmvghnvghfhiestghouggrshhiphdrtghomhdprhgtphhtthhope
    gthhhrihhsthhophhhvgdrlhgvrhhohiestghsghhrohhuphdrvghupdhrtghpthhtohep
    phgrlhhmvghrsegurggssggvlhhtrdgtohhm
X-ME-Proxy: <xmx:ERvhZ190Exg3K6_kLgWu7WsydNwRgDQP1BvGS38EtAEVS10qTc9izQ>
    <xmx:ERvhZ5pSTaln_bffxxqCHJkhz9AKpKOOKmQO4Eq5HKf-Gho2VJ5U-g>
    <xmx:ERvhZ-pLXnyHzEuv7tjWWqvRr2xVVCSXFg9BY-tBBUxlIVlxpfmlxg>
    <xmx:ERvhZ_Qq-RQ9a5tD09RpSMN7-QpOUqXaXxZO_wMviqQRD4uPdkCddw>
    <xmx:ExvhZ2B_JHKg4uJh_z1M_1tIcDc8LNRBkE3AjwEBbfVsDk8PWVd86Ji_>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 1BD7F2220072; Mon, 24 Mar 2025 04:42:57 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T4d23c9949082f1fa
Date: Mon, 24 Mar 2025 09:42:35 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Yunhui Cui" <cuiyunhui@bytedance.com>
Cc: "Paul Walmsley" <paul.walmsley@sifive.com>,
 "Palmer Dabbelt" <palmer@dabbelt.com>, "Albert Ou" <aou@eecs.berkeley.edu>,
 "Alexandre Ghiti" <alex@ghiti.fr>,
 "Anshuman Khandual" <anshuman.khandual@arm.com>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Ingo Molnar" <mingo@kernel.org>,
 "Catalin Marinas" <catalin.marinas@arm.com>,
 "Ryan Roberts" <ryan.roberts@arm.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 "Nam Cao" <namcao@linutronix.de>,
 =?UTF-8?Q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@rivosinc.com>,
 "Stuart Menefy" <stuart.menefy@codasip.com>,
 "Xu Lu" <luxu.kernel@bytedance.com>,
 "Vincenzo Frascino" <vincenzo.frascino@arm.com>,
 "Samuel Holland" <samuel.holland@sifive.com>,
 "Christophe Leroy" <christophe.leroy@csgroup.eu>,
 "Dawei Li" <dawei.li@shingroup.cn>, "Mike Rapoport" <rppt@kernel.org>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Message-Id: <68644786-ed4b-49b1-9a4c-3318a8fc0c7d@app.fastmail.com>
In-Reply-To: 
 <CAEEQ3wk95SMxbKQqD08ACaErG9bvUNQ9QOK6KsZSc5xGHRj+pQ@mail.gmail.com>
References: <20250320084428.51151-1-cuiyunhui@bytedance.com>
 <9256ca10-323d-41b4-b935-5281f925d50c@app.fastmail.com>
 <CAEEQ3wk95SMxbKQqD08ACaErG9bvUNQ9QOK6KsZSc5xGHRj+pQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] riscv: introduce the ioremap_prot() function
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025, at 02:30, yunhui cui wrote:
> On Thu, Mar 20, 2025 at 5:22=E2=80=AFPM Arnd Bergmann <arnd@arndb.de> =
wrote:

>> > diff --git a/arch/riscv/include/asm/io.h b/arch/riscv/include/asm/i=
o.h
>> > index a0e51840b9db..736c5557bd06 100644
>> > --- a/arch/riscv/include/asm/io.h
>> > +++ b/arch/riscv/include/asm/io.h
>> > @@ -133,6 +133,8 @@ __io_writes_outs(outs, u64, q, __io_pbr(), __io=
_paw())
>> >  #define outsq(addr, buffer, count) __outsq(PCI_IOBASE + (addr), bu=
ffer, count)
>> >  #endif
>> >
>> > +#define ioremap_prot ioremap_prot
>> > +
>> >  #include <asm-generic/io.h>
>> >
>> >  #ifdef CONFIG_MMU
>>
>> This feels slightly wrong to me, the "#define foo foo" method
>> is normally used to override a declaration or inline function with
>> another one, but this one only overrides the implementation, not
>> the declaration.
>>
>> I see the same is done on arc, arm64, parisc, powerpc, s390,
>> sh and xtensa, so we can keep this one as well, but it would be
>> nice to change all of these to a less surprising approach.
>>
>> Maybe we should just remove these macros from asm/io.h and
>> the trivial wrapper from mm/ioremap.c, and instead change the
>> other architectures that have GENERIC_IOREMAP to use
>>
>> #define ioremap_prot generic_ioremap_prot
>>
>> It seems this would be only csky, hexagon, (some) loongarch
>> and openrisc.
>
> It seems that we can't simply use #define ioremap_prot
> generic_ioremap_prot because some architectures have certain special
> behaviors before calling generic_ioremap_prot(). For example, there's
> the ioremap_prot_hook() logic on ARM64 and the CONFIG_EISA logic on
> PA-RISC, among others.

I meant only the four that I have listed above should do
the "#define ioremap_prot generic_ioremap_prot", while the
ones that have some special case would continue to provide
their own implementation.

> Regarding the check of whether the address is a memory address, I
> think we can directly incorporate pfn_valid() into
> generic_ioremap_prot. This probably won't affect architectures that
> directly use generic_ioremap_prot(), such as C-SKY, Hexagon, and
> LoongArch.
>
> So, my next plan is to add pfn_valid() to generic_ioremap_prot().

Ah right, I see now that x86 does not use CONFIG_GENERIC_IOREMAP,
so it would still be able to have its memremap() fall back to
ioremap_cache().

You should probably still go through the list of drivers
calling ioremap_cache() or ioremap_wt() to see if any of them
might be used on an architecture that defines those two functions
through ioremap_prot(), as that would be broken when they
get called on normal memory:

arch/loongarch/kernel/acpi.c:           return ioremap_cache(phys, size);
arch/mips/include/asm/dmi.h:#define dmi_remap(x, l)                     =
ioremap_cache(x, l)
arch/powerpc/kernel/crash_dump.c:               vaddr =3D ioremap_cache(=
paddr, PAGE_SIZE);
arch/powerpc/platforms/pasemi/dma_lib.c:        dma_status =3D ioremap_c=
ache(res.start, resource_size(&res));
arch/powerpc/platforms/powernv/vas-window.c:    map =3D ioremap_cache(st=
art, len);
arch/x86/hyperv/hv_init.c:      ghcb_va =3D (void *)ioremap_cache(ghcb_g=
pa, HV_HYP_PAGE_SIZE);
arch/x86/kernel/acpi/boot.c:    return ioremap_cache(phys, size);
arch/x86/platform/efi/efi_32.c:         va =3D ioremap_cache(md->phys_ad=
dr, size);
drivers/acpi/apei/bert.c:       boot_error_region =3D ioremap_cache(bert=
_tab->address, region_len);
drivers/acpi/apei/einj-core.c:  trigger_tab =3D ioremap_cache(trigger_pa=
ddr, sizeof(*trigger_tab));
drivers/acpi/apei/einj-core.c:  trigger_tab =3D ioremap_cache(trigger_pa=
ddr, table_size);
drivers/acpi/apei/erst.c:       erst_erange.vaddr =3D ioremap_cache(erst=
_erange.base,
drivers/firmware/meson/meson_sm.c:      return ioremap_cache(sm_phy_base=
, size);
drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:                adev->mman.aper_=
base_kaddr =3D ioremap_cache(adev->gmc.aper_base,
drivers/gpu/drm/hyperv/hyperv_drm_drv.c:        hv->vram =3D ioremap_cac=
he(hv->mem->start, hv->fb_size);
drivers/gpu/drm/ttm/ttm_bo_util.c:                      map->virtual =3D=
 ioremap_cache(res, size);
drivers/gpu/drm/ttm/ttm_bo_util.c:                      vaddr_iomem =3D =
ioremap_cache(mem->bus.offset,
drivers/hv/hv.c:                /* Mask out vTOM bit. ioremap_cache() ma=
ps decrypted */
drivers/hv/hv.c:                        (void *)ioremap_cache(base, HV_H=
YP_PAGE_SIZE);
drivers/hv/hv.c:                /* Mask out vTOM bit. ioremap_cache() ma=
ps decrypted */
drivers/hv/hv.c:                        (void *)ioremap_cache(base, HV_H=
YP_PAGE_SIZE);
drivers/mtd/devices/bcm47xxsflash.c:            b47s->window =3D ioremap=
_cache(res->start, resource_size(res));
drivers/mtd/maps/pxa2xx-flash.c:        info->map.cached =3D ioremap_cac=
he(info->map.phys, info->map.size);
drivers/soc/fsl/qbman/qman_ccsr.c:      void __iomem *tmpp =3D ioremap_c=
ache(addr, sz);
drivers/video/fbdev/hyperv_fb.c:        fb_virt =3D ioremap_cache(par->m=
em->start, screen_fb_size);
include/acpi/acpi_io.h:       return ioremap_cache(phys, size);
drivers/block/z2ram.c:                  vaddr =3D (unsigned long)ioremap=
_wt(paddr, size);
drivers/video/fbdev/amifb.c:    videomemory =3D (u_long)ioremap_wt(info-=
>fix.smem_start,
drivers/video/fbdev/atafb.c:            external_screen_base =3D ioremap=
_wt(external_addr, external_len);
drivers/video/fbdev/controlfb.c:        p->frame_buffer =3D ioremap_wt(p=
->frame_buffer_phys, 0x800000);
drivers/video/fbdev/hpfb.c:     fb_start =3D (unsigned long)ioremap_wt(f=
b_info.fix.smem_start,
drivers/video/fbdev/platinumfb.c:       pinfo->frame_buffer =3D ioremap_=
wt(pinfo->rsrc_fb.start, 0x400000);
drivers/video/fbdev/valkyriefb.c:       p->frame_buffer =3D ioremap_wt(f=
rame_buffer_phys, p->total_vram);

Similar, any architecture that doesn't have arch_memremap_wb()
falls back to ioremap_cache() or ioremap(), which then have that
check.

      Arnd

