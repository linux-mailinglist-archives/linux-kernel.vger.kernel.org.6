Return-Path: <linux-kernel+bounces-214589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F6E9086DA
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 10:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18F1F284B94
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 08:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82AA81922C1;
	Fri, 14 Jun 2024 08:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KTlOtos4"
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8607B14884B
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 08:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718355505; cv=none; b=Lu8JARP3l2+uuM54rvy3tP86o85DFxqoQgrCWmcIGbgmjCl7M2SkA4U4sdTUKZoAOe5STQZgA46edo1KR5KL4ApnGi6VCR530FX9xepFvPW+9vP0PuLwEDzAKiwQ+hSNdTpqv57Wqk5qdcyEoHx9w+paJgD1R7itq9Y9nJAFM8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718355505; c=relaxed/simple;
	bh=Ghq/990L70pHzsgGPsyLph78CzogXOrJp5Paqw6qrlo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tXgdQRZMpaw6T4M1COg79O6LslOOPZW4/FsRRc6oE/RHgcHItQNhX5ebbjbujicril7LK9V7bGuev2J3caTFUeOFJDJG8mx1IL4o0ShZ64WQDkoZA7lt0+rfjt/ntyDlOMSaiu/D6EevaHBTW6SZO3EsJG8/Wj4H52iO9n8U7L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KTlOtos4; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-4ecf2fff1cdso522506e0c.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 01:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718355502; x=1718960302; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5map5sTrhgjiJItBOra2Uu/E0cA/V5092VbQl+VekeU=;
        b=KTlOtos4X/5abY7Udx3riIi88ofWhLHxQQSb5Ur5ARU7UggI1tiWu8ipJh31/kA66y
         bN5kC7PHi/pGZQ/a8SVL1+nKqa2n/tOYf9MZyW99m4IE8C8nCWXc2bV6DnH0/AyVU9mY
         31rcpVe4Whn8JeLmTBioUfRZuMPSclkUcDf27c1j2ac4sibA+JQzVgYQn5/HoTp4gryi
         iO90z46Ulsj5qyhSZEbOXj3btq3ZLQDHZDkMrhKshBhEJ3G8NKcf3Rfj1XTbuwIk0MSW
         BxlPBDsWd+1LoWsizBTyg4hdkFKIWIDkTMObutqMWo/6FBqCpFSTdLqD4++U2d0dKl7u
         +zCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718355502; x=1718960302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5map5sTrhgjiJItBOra2Uu/E0cA/V5092VbQl+VekeU=;
        b=kASUcZbfqAXbP0BQ3pndwQWwySau47NkW29VmM4Yy8tSf9PXigv0wrtj0ymKewo8BG
         uBVhlbKoj3ol2XW0AsZ4CgUUGcS6tnD1PYVhcI3Mv9sLK7q+bBhsakll9dv8rHcKa+NA
         rTi2M/wtmKQZIP1XbFfaGWPZDb+d9iKQ4yRaddJP0DVmbhBZKwxQYM/fuxQZAQknunTP
         Xjdvewjp7YzUzvwUm+X7ROvFnmo/mJQSIXY7DqreMFeU+liSyaXkqWGlGl4r2l+nxqxa
         Z+txcK0MrezORLRaDvOvQIxAhaR0ycDIo0Ou39mf1KqU7Df3KBbMfXztr7qc4DBZbGlw
         E+iQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4NgRqLz6PAE3I+CkVhjVxQjgKq4BZgcMBhdKmUScr2w67f9y0/Y9r6UhXPc7ZuldUO4n3IVRMwowFqwbmfiUeTqTaJJnxBL7YiHPL
X-Gm-Message-State: AOJu0Yy516Ny0LaoK+FfpNhIWPgrElaXkt/pky8VtKLbQ7j1llpicpnk
	GnuPssxRQQdZivGJqDlBwHowdfwDAlPbt3YzIMLML0VIAQL3tOBuSVQ55DcglTdEy+sSr+kh//K
	Ene/W3iPgVzpef/m30SZitC7M8+c=
X-Google-Smtp-Source: AGHT+IHPGRMhrmSdawlt3rfF9Pj9XYHxJhOaEU/XZRzjsqFAvdhVCkud7ODouRrPqxng3DF6Vg+5PIRQAca02P/KtJw=
X-Received: by 2002:a05:6122:4593:b0:4ea:f3ae:6349 with SMTP id
 71dfb90a1353d-4ee3e48c2aamr2749932e0c.7.1718355502148; Fri, 14 Jun 2024
 01:58:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613000721.23093-1-21cnbao@gmail.com> <20240613000721.23093-4-21cnbao@gmail.com>
 <CAGsJ_4zx3Rp9ye=LFhzEN+JypAq1zb_gLQZgyiRvYJZTMpLCHA@mail.gmail.com>
 <b0b4a134-1d40-4eef-94f3-5c4593b55e78@redhat.com> <CAGsJ_4zDoevXiNOTbSefU4WfoPEpbkhArc1niTBFRPsMHu5j8w@mail.gmail.com>
 <cac7d354-bcf3-4d7f-866a-9665568a50a0@redhat.com> <CAGsJ_4xfPPz8oOe79nPxues0PkEem8O2Q+0zo6pU8uDGO1kMkg@mail.gmail.com>
 <e151cfd9-c0a5-4536-a490-77dc47aa3ed6@redhat.com> <CAGsJ_4wss6++EP8hSyuc3sPqtLgqqjs7DOUfQ5aCK36Bn+VbBg@mail.gmail.com>
In-Reply-To: <CAGsJ_4wss6++EP8hSyuc3sPqtLgqqjs7DOUfQ5aCK36Bn+VbBg@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 14 Jun 2024 20:58:11 +1200
Message-ID: <CAGsJ_4yiVs48XKTMkijS95MwXfxcRkRv0j0rj7cFjKCi2AcYZg@mail.gmail.com>
Subject: Re: [PATCH RFC 3/3] mm: remove folio_test_anon(folio)==false path in __folio_add_anon_rmap()
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, chrisl@kernel.org, 
	linux-kernel@vger.kernel.org, mhocko@suse.com, ryan.roberts@arm.com, 
	baolin.wang@linux.alibaba.com, yosryahmed@google.com, shy828301@gmail.com, 
	surenb@google.com, v-songbaohua@oppo.com, willy@infradead.org, 
	ying.huang@intel.com, yuzhao@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2024 at 8:56=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> On Fri, Jun 14, 2024 at 8:51=E2=80=AFPM David Hildenbrand <david@redhat.c=
om> wrote:
> >
> > On 14.06.24 09:56, Barry Song wrote:
> > > On Thu, Jun 13, 2024 at 9:12=E2=80=AFPM David Hildenbrand <david@redh=
at.com> wrote:
> > >>
> > >> On 13.06.24 11:06, Barry Song wrote:
> > >>> On Thu, Jun 13, 2024 at 8:49=E2=80=AFPM David Hildenbrand <david@re=
dhat.com> wrote:
> > >>>>
> > >>>> On 13.06.24 10:46, Barry Song wrote:
> > >>>>> On Thu, Jun 13, 2024 at 12:08=E2=80=AFPM Barry Song <21cnbao@gmai=
l.com> wrote:
> > >>>>>>
> > >>>>>> From: Barry Song <v-songbaohua@oppo.com>
> > >>>>>>
> > >>>>>> The folio_test_anon(folio)=3D=3Dfalse case within do_swap_page()=
 has been
> > >>>>>> relocated to folio_add_new_anon_rmap(). Additionally, two other =
callers
> > >>>>>> consistently pass anonymous folios.
> > >>>>>>
> > >>>>>> stack 1:
> > >>>>>> remove_migration_pmd
> > >>>>>>       -> folio_add_anon_rmap_pmd
> > >>>>>>         -> __folio_add_anon_rmap
> > >>>>>>
> > >>>>>> stack 2:
> > >>>>>> __split_huge_pmd_locked
> > >>>>>>       -> folio_add_anon_rmap_ptes
> > >>>>>>          -> __folio_add_anon_rmap
> > >>>>>>
> > >>>>>> __folio_add_anon_rmap() only needs to handle the cases
> > >>>>>> folio_test_anon(folio)=3D=3Dtrue now.
> > >>>>>
> > >>>>> My team reported a case where swapoff() is calling
> > >>>>> folio_add_anon_rmap_pte *not* folio_add_anon_rmap_ptes
> > >>>>> with one new anon  (!folio_test_anon(folio)).
> > >>>>>
> > >>>>> I will double check all folio_add_anon_rmap_pte() cases.
> > >>>>
> > >>>> Right, swapoff() path is a bit special (e.g., we don't do any kind=
 of
> > >>>> batching on the swapoff() path).
> > >>>>
> > >>>> But we should never get a new large anon folio there, or could tha=
t now
> > >>>> happen?
> > >>>
> > >>> My team encountered the following issue while testing this RFC
> > >>> series on real hardware. Let me take a look to identify the
> > >>> problem.
> > >>>
> > >>> [  261.214195][T11285] page:000000004cdd779e refcount:4 mapcount:1
> > >>> mapping:00000000ba142c22 index:0x1 pfn:0x1b30a6
> > >>> [  261.214213][T11285] memcg:ffffff8003678000
> > >>> [  261.214217][T11285] aops:swap_aops
> > >>> [  261.214233][T11285] flags:
> > >>> 0x2000000000081009(locked|uptodate|owner_priv_1|swapbacked|zone=3D1=
|kasantag=3D0x0)
> > >>> [  261.214241][T11285] page_type: 0x0()
> > >>> [  261.214246][T11285] raw: 2000000000081009 0000000000000000
> > >>> dead000000000122 0000000000000000
> > >>> [  261.214251][T11285] raw: 0000000000000001 00000000000d84b3
> > >>> 0000000400000000 ffffff8003678000
> > >>> [  261.214254][T11285] page dumped because:
> > >>> VM_WARN_ON_FOLIO(!folio_test_anon(folio))
> > >>> [  261.214257][T11285] page_owner tracks the page as allocated
> > >>> [  261.214260][T11285] page last allocated via order 0, migratetype
> > >>> Movable, gfp_mask 0x2140cca(GFP_HIGHUSER_MOVABLE|__GFP_COMP), pid
> > >>> 11285, tgid 11285 (swapoff), ts 261214177545, free_ts 261151875699
> > >>> [  261.214268][T11285]  post_alloc_hook+0x1b8/0x1c0
> > >>> [  261.214284][T11285]  prep_new_page+0x28/0x13c
> > >>> [  261.214291][T11285]  get_page_from_freelist+0x198c/0x1aa4
> > >>> [  261.214298][T11285]  __alloc_pages+0x15c/0x330
> > >>> [  261.214304][T11285]  __folio_alloc+0x1c/0x4c
> > >>> [  261.214310][T11285]  __read_swap_cache_async+0xd8/0x48c
> > >>> [  261.214320][T11285]  swap_cluster_readahead+0x158/0x324
> > >>> [  261.214326][T11285]  swapin_readahead+0x64/0x448
> > >>> [  261.214331][T11285]  __arm64_sys_swapoff+0x6ec/0x14b0
> > >>> [  261.214337][T11285]  invoke_syscall+0x58/0x114
> > >>> [  261.214353][T11285]  el0_svc_common+0xac/0xe0
> > >>> [  261.214360][T11285]  do_el0_svc+0x1c/0x28
> > >>> [  261.214366][T11285]  el0_svc+0x38/0x68
> > >>> [  261.214372][T11285]  el0t_64_sync_handler+0x68/0xbc
> > >>> [  261.214376][T11285]  el0t_64_sync+0x1a8/0x1ac
> > >>> [  261.214381][T11285] page last free pid 90 tgid 90 stack trace:
> > >>> [  261.214386][T11285]  free_unref_page_prepare+0x338/0x374
> > >>> [  261.214395][T11285]  free_unref_page_list+0x84/0x378
> > >>> [  261.214400][T11285]  shrink_folio_list+0x1234/0x13e4
> > >>> [  261.214409][T11285]  evict_folios+0x1458/0x19b4
> > >>> [  261.214417][T11285]  try_to_shrink_lruvec+0x1c8/0x264
> > >>> [  261.214422][T11285]  shrink_one+0xa8/0x234
> > >>> [  261.214427][T11285]  shrink_node+0xb38/0xde0
> > >>> [  261.214432][T11285]  balance_pgdat+0x7a4/0xdb4
> > >>> [  261.214437][T11285]  kswapd+0x290/0x4e4
> > >>> [  261.214442][T11285]  kthread+0x114/0x1bc
> > >>> [  261.214459][T11285]  ret_from_fork+0x10/0x20
> > >>> [  261.214477][T11285] ------------[ cut here ]------------
> > >>> [  261.214480][T11285] WARNING: CPU: 3 PID: 11285 at mm/rmap.c:1305
> > >>> folio_add_anon_rmap_ptes+0x2b4/0x330
> > >>>
> > >>> [  261.215403][T11285] pstate: 63400005 (nZCv daif +PAN -UAO +TCO +=
DIT
> > >>> -SSBS BTYPE=3D--)
> > >>> [  261.215423][T11285] pc : folio_add_anon_rmap_ptes+0x2b4/0x330
> > >>> [  261.215428][T11285] lr : folio_add_anon_rmap_ptes+0x2b4/0x330
> > >>> [  261.215433][T11285] sp : ffffffc0a7dbbbf0
> > >>> [  261.215437][T11285] x29: ffffffc0a7dbbbf0 x28: ffffff8040860a08
> > >>> x27: ffffff80db480000
> > >>> [  261.215445][T11285] x26: fffffffe04cc2980 x25: ffffff808f77f120
> > >>> x24: 0000007b44941000
> > >>> [  261.215452][T11285] x23: 0000000000000001 x22: 0000000000000001
> > >>> x21: fffffffe04cc2980
> > >>> [  261.215459][T11285] x20: ffffff80db480000 x19: fffffffe04cc2980
> > >>> x18: ffffffed011dae80
> > >>> [  261.215465][T11285] x17: 0000000000000001 x16: ffffffffffffffff
> > >>> x15: 0000000000000004
> > >>> [  261.215471][T11285] x14: ffffff82fb73fac0 x13: 0000000000000003
> > >>> x12: 0000000000000003
> > >>> [  261.215476][T11285] x11: 00000000fffeffff x10: c0000000fffeffff =
x9
> > >>> : 0d46c0889b468e00
> > >>> [  261.215483][T11285] x8 : 0d46c0889b468e00 x7 : 545b5d3935343431 =
x6
> > >>> : 322e31363220205b
> > >>> [  261.215489][T11285] x5 : ffffffed013de407 x4 : ffffffed00698967 =
x3
> > >>> : 0000000000000000
> > >>> [  261.215495][T11285] x2 : 0000000000000000 x1 : ffffffc0a7dbb8c0 =
x0
> > >>> : ffffff8068c15c80
> > >>> [  261.215501][T11285] Call trace:
> > >>> [  261.215504][T11285]  folio_add_anon_rmap_ptes+0x2b4/0x330
> > >>> [  261.215509][T11285]  __arm64_sys_swapoff+0x8cc/0x14b0
> > >>> [  261.215516][T11285]  invoke_syscall+0x58/0x114
> > >>> [  261.215526][T11285]  el0_svc_common+0xac/0xe0
> > >>> [  261.215532][T11285]  do_el0_svc+0x1c/0x28
> > >>> [  261.215539][T11285]  el0_svc+0x38/0x68
> > >>> [  261.215544][T11285]  el0t_64_sync_handler+0x68/0xbc
> > >>> [  261.215548][T11285]  el0t_64_sync+0x1a8/0x1ac
> > >>> [  261.215552][T11285] ---[ end trace 0000000000000000 ]---
> > >>
> > >> Ah, yes. in unuse_pte(), you'll have to do the right thing if
> > >> !folio_test(anon) before doing the folio_add_anon_rmap_pte().
> > >>
> > >> You might have a fresh anon folio in the swapcache that was never ma=
pped
> > >> (hopefully order-0, otherwise we'd likely be in trouble).
> > >
> > > Yes. It is order-0
> > >
> > > [  261.214260][T11285] page last allocated via order 0, migratetype
> > >
> > > Otherwise, we would have encountered this VM_WARN_ON_FOLIO?
> > >
> > > __folio_add_anon_rmap()
> > > {
> > > ...
> > > VM_WARN_ON_FOLIO(folio_test_large(folio) &&
> > >       level !=3D RMAP_LEVEL_PMD, folio);
> > > ...
> > > }
> > >
> > > Given that nobody has ever reported this warning, I assume all caller=
s
> > > using folio_add_anon_rmap_pte(s) are right now safe to move to ?
> >
> > Yes, and we should likely add a VM_WARN_ON_ONCE() here that we have a
> > small folio if !anon. If that ever changes, we can assess the situation=
.
> >
>
> this patch actually has a WARN_ON for all !anon, so it extends the WARN
> to small.
>
> -       if (unlikely(!folio_test_anon(folio))) {
> -               VM_WARN_ON_FOLIO(!folio_test_locked(folio), folio);
> -               /*
> -                * For a PTE-mapped large folio, we only know that the si=
ngle
> -                * PTE is exclusive. Further, __folio_set_anon() might no=
t get
> -                * folio->index right when not given the address of the h=
ead
> -                * page.
> -                */
> -               VM_WARN_ON_FOLIO(folio_test_large(folio) &&
> -                                level !=3D RMAP_LEVEL_PMD, folio);
> -               __folio_set_anon(folio, vma, address,
> -                                !!(flags & RMAP_EXCLUSIVE));
> -       } else if (likely(!folio_test_ksm(folio))) {
> +       VM_WARN_ON_FOLIO(!folio_test_anon(folio), folio);
> +
>
> > Only swap created "new" anon folios without properly calling the right
> > function so far, all other code handles that correctly.

as I assume patch2/3 should have moved all !anon to
folio_add_new_anon_rmap()

diff --git a/mm/ksm.c b/mm/ksm.c
index d2641bc2efc9..c913ba8c37eb 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -1420,7 +1420,14 @@ static int replace_page(struct vm_area_struct
*vma, struct page *page,
         */
        if (!is_zero_pfn(page_to_pfn(kpage))) {
                folio_get(kfolio);
-               folio_add_anon_rmap_pte(kfolio, kpage, vma, addr, RMAP_NONE=
);
+               /*
+                * We currently ensure that new folios cannot be partially
+                * exclusive: they are either fully exclusive or fully shar=
ed.
+                */
+               if (!folio_test_anon(kfolio))
+                       folio_add_new_anon_rmap(kfolio, vma, addr, RMAP_NON=
E);
+               else
+                       folio_add_anon_rmap_pte(kfolio, kpage, vma,
addr, RMAP_NONE);
                newpte =3D mk_pte(kpage, vma->vm_page_prot);
        } else {
                /*
diff --git a/mm/memory.c b/mm/memory.c
index 1f24ecdafe05..16797cc22058 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4339,6 +4339,12 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
        if (unlikely(folio !=3D swapcache && swapcache)) {
                folio_add_new_anon_rmap(folio, vma, address, RMAP_EXCLUSIVE=
);
                folio_add_lru_vma(folio, vma);
+       } else if (!folio_test_anon(folio)) {
+               /*
+                * We currently ensure that new folios cannot be partially
+                * exclusive: they are either fully exclusive or fully shar=
ed.
+                */
+               folio_add_new_anon_rmap(folio, vma, address, rmap_flags);
        } else {
                folio_add_anon_rmap_ptes(folio, page, nr_pages, vma, addres=
s,
                                        rmap_flags);
diff --git a/mm/swapfile.c b/mm/swapfile.c
index ae1d2700f6a3..ac53e46de48a 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1908,8 +1908,14 @@ static int unuse_pte(struct vm_area_struct
*vma, pmd_t *pmd,
                VM_BUG_ON_FOLIO(folio_test_writeback(folio), folio);
                if (pte_swp_exclusive(old_pte))
                        rmap_flags |=3D RMAP_EXCLUSIVE;
-
-               folio_add_anon_rmap_pte(folio, page, vma, addr, rmap_flags)=
;
+               /*
+                * We currently ensure that new folios cannot be partially
+                * exclusive: they are either fully exclusive or fully shar=
ed.
+                */
+               if (!folio_test_anon(folio))
+                       folio_add_new_anon_rmap(folio, vma, addr, rmap_flag=
s);
+               else
+                       folio_add_anon_rmap_pte(folio, page, vma,
addr, rmap_flags);
        } else { /* ksm created a completely new copy */
                folio_add_new_anon_rmap(folio, vma, addr, RMAP_EXCLUSIVE);
                folio_add_lru_vma(folio, vma);


> >
> > --
> > Cheers,
> >
> > David / dhildenb
> >

