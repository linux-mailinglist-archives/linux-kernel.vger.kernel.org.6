Return-Path: <linux-kernel+bounces-214641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EDCB290878B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 11:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C124B24D48
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 09:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C411922FE;
	Fri, 14 Jun 2024 09:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VjaiXA2p"
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DC01922F5
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 09:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718357630; cv=none; b=uhjusVIGwWXIRo0fZ/Bsj5lrRPi9UpSolKzCzlzRxtGNsZ6SJlhWPlJICMTYzf2RVaeAQjMwflv9YYBWAg48wsvOsqeICOXuIty5nHC1fPkHl4h16+GkbG0XbFvuPsbi0CkJ+md9sPBMQ3S3SOYneYWBPzvDCzX8drZHXEve2eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718357630; c=relaxed/simple;
	bh=vY5BmBEpp3sa+ZWZH7iZQ/zc2dYQ8iZrdAGCWP3HK5M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AaqPIi6cD7Ub8gBatjM+kKdSHv4s0NnQzMydSJRfQY5ZPf5j/wLgqm2Lss5vpChVD97wfxOdGn9Ea7g7AhiXQqx3YAFPLuLYCC2Fwl5WNPwo8N2l2dMELB+l1zaQahksWYG+lP0wIQm71FU3TZwoilpU63/3HGsL1ZTcv21WuGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VjaiXA2p; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-4ecf1013d73so601240e0c.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 02:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718357627; x=1718962427; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4OlCeSeSwuoi/mYK/PxNkVUe2xFe5Qw7QwmIn2ZrDa4=;
        b=VjaiXA2pfbynMtRdp4+BXOcSPE+XP6S4PqwjVRpxJxJg4m2slxL2Ur4anWUcex4Wl+
         CNCFsoCLpTTi+rQpO9qImg4lJc0ZiZmdIbQwtF2qxEDmmQ1vvsBh3fTaEAwpjGbR2ZjA
         w9X1GrKwwgKe+WDZBn1sk9NDMzPbTZ4S7BJJKWA+56PBc9e3ZuDKJIiwAIR8CCvhgXkl
         mAo0uiTi/t4pVExar0K9nnHp3vsH7Vj/j/SivjHFTdpj1Vew/4kOlDSxJC9KcgyLg2hZ
         bPHpvRU0SRFvO1FgHVS5JDCgRacwywGdh911qMoZJFwq+tV+jxpUF1q6tBwHDHe5dhvU
         0aZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718357627; x=1718962427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4OlCeSeSwuoi/mYK/PxNkVUe2xFe5Qw7QwmIn2ZrDa4=;
        b=RL1fHsydZL4sRjJOuI/K7aQCPLkJtivJmv0DGebdeUNGdiBW0v49+WZbVF/DTOftOC
         nndm1TcD7sLN0+7edC4aVMEG2ADWmqkN2hevK50Ej28w02gjz6Z7pkA6cEcMFPliW+IY
         hRvxngaTGmgjl5yh3PKWp3FsKxwokv/Yi22fS7kzxirSZGa2rUGOuygo51buIud7oOkV
         BC9798bDD5JbZtroWKBHSS6jwV+DWEfiEHa3SWNo7Mlp0EAf7Oe7ETGl+0HFohdsbVoc
         TW/zwpJV8bYnt2Xs2OvuzBnKxFvkt07BNc5R1onmDKmL10mk5SrxCJ8ecFtj8KUl3VXB
         6Bdw==
X-Forwarded-Encrypted: i=1; AJvYcCVciaKTtS670HCIAtfM1cOoH53Y+DelpJCrQ+qK35h5Af5QfHEHDhgcEULbj7iJpg7lLGrP81zC6D8cOxdxTSPs74WfTzwNm79XPfzv
X-Gm-Message-State: AOJu0YxuuI5idwBhT8MkhI6BZEP81C9yJL6Gp7WtnVBgJWdo5Cf7RlPX
	8AiwPjbdzKPCdPIEiK7KiIPyLPbScpW0MmTAK/rGjbtzap9YUYbJvFFUZ6Kuj1IT41TheDYcZ5h
	ov2K7Z6ReTWa0tI7+SkFDHp5NjHuTT0Jb
X-Google-Smtp-Source: AGHT+IF8athJNBJZEn87MdBOAxqh6ku3SAdXCBC4sx+nu95LwX35kLvWghodgdykC7q23gTsBlb3k+fWxvp5/V7R1CA=
X-Received: by 2002:a05:6122:1351:b0:4ec:fa1c:decf with SMTP id
 71dfb90a1353d-4ee3df849e6mr2781117e0c.5.1718357627344; Fri, 14 Jun 2024
 02:33:47 -0700 (PDT)
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
 <CAGsJ_4yiVs48XKTMkijS95MwXfxcRkRv0j0rj7cFjKCi2AcYZg@mail.gmail.com> <aa2d9d4f-8f06-4388-afe3-ed4b626d41e2@redhat.com>
In-Reply-To: <aa2d9d4f-8f06-4388-afe3-ed4b626d41e2@redhat.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 14 Jun 2024 21:33:35 +1200
Message-ID: <CAGsJ_4wJjp5kTRt=MAQ7umS-uSw9uyUthj1z5urmo5t084aUwQ@mail.gmail.com>
Subject: Re: [PATCH RFC 3/3] mm: remove folio_test_anon(folio)==false path in __folio_add_anon_rmap()
To: David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, chrisl@kernel.org, 
	linux-kernel@vger.kernel.org, mhocko@suse.com, ryan.roberts@arm.com, 
	baolin.wang@linux.alibaba.com, yosryahmed@google.com, shy828301@gmail.com, 
	surenb@google.com, v-songbaohua@oppo.com, willy@infradead.org, 
	ying.huang@intel.com, yuzhao@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 14, 2024 at 9:04=E2=80=AFPM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 14.06.24 10:58, Barry Song wrote:
> > On Fri, Jun 14, 2024 at 8:56=E2=80=AFPM Barry Song <21cnbao@gmail.com> =
wrote:
> >>
> >> On Fri, Jun 14, 2024 at 8:51=E2=80=AFPM David Hildenbrand <david@redha=
t.com> wrote:
> >>>
> >>> On 14.06.24 09:56, Barry Song wrote:
> >>>> On Thu, Jun 13, 2024 at 9:12=E2=80=AFPM David Hildenbrand <david@red=
hat.com> wrote:
> >>>>>
> >>>>> On 13.06.24 11:06, Barry Song wrote:
> >>>>>> On Thu, Jun 13, 2024 at 8:49=E2=80=AFPM David Hildenbrand <david@r=
edhat.com> wrote:
> >>>>>>>
> >>>>>>> On 13.06.24 10:46, Barry Song wrote:
> >>>>>>>> On Thu, Jun 13, 2024 at 12:08=E2=80=AFPM Barry Song <21cnbao@gma=
il.com> wrote:
> >>>>>>>>>
> >>>>>>>>> From: Barry Song <v-songbaohua@oppo.com>
> >>>>>>>>>
> >>>>>>>>> The folio_test_anon(folio)=3D=3Dfalse case within do_swap_page(=
) has been
> >>>>>>>>> relocated to folio_add_new_anon_rmap(). Additionally, two other=
 callers
> >>>>>>>>> consistently pass anonymous folios.
> >>>>>>>>>
> >>>>>>>>> stack 1:
> >>>>>>>>> remove_migration_pmd
> >>>>>>>>>        -> folio_add_anon_rmap_pmd
> >>>>>>>>>          -> __folio_add_anon_rmap
> >>>>>>>>>
> >>>>>>>>> stack 2:
> >>>>>>>>> __split_huge_pmd_locked
> >>>>>>>>>        -> folio_add_anon_rmap_ptes
> >>>>>>>>>           -> __folio_add_anon_rmap
> >>>>>>>>>
> >>>>>>>>> __folio_add_anon_rmap() only needs to handle the cases
> >>>>>>>>> folio_test_anon(folio)=3D=3Dtrue now.
> >>>>>>>>
> >>>>>>>> My team reported a case where swapoff() is calling
> >>>>>>>> folio_add_anon_rmap_pte *not* folio_add_anon_rmap_ptes
> >>>>>>>> with one new anon  (!folio_test_anon(folio)).
> >>>>>>>>
> >>>>>>>> I will double check all folio_add_anon_rmap_pte() cases.
> >>>>>>>
> >>>>>>> Right, swapoff() path is a bit special (e.g., we don't do any kin=
d of
> >>>>>>> batching on the swapoff() path).
> >>>>>>>
> >>>>>>> But we should never get a new large anon folio there, or could th=
at now
> >>>>>>> happen?
> >>>>>>
> >>>>>> My team encountered the following issue while testing this RFC
> >>>>>> series on real hardware. Let me take a look to identify the
> >>>>>> problem.
> >>>>>>
> >>>>>> [  261.214195][T11285] page:000000004cdd779e refcount:4 mapcount:1
> >>>>>> mapping:00000000ba142c22 index:0x1 pfn:0x1b30a6
> >>>>>> [  261.214213][T11285] memcg:ffffff8003678000
> >>>>>> [  261.214217][T11285] aops:swap_aops
> >>>>>> [  261.214233][T11285] flags:
> >>>>>> 0x2000000000081009(locked|uptodate|owner_priv_1|swapbacked|zone=3D=
1|kasantag=3D0x0)
> >>>>>> [  261.214241][T11285] page_type: 0x0()
> >>>>>> [  261.214246][T11285] raw: 2000000000081009 0000000000000000
> >>>>>> dead000000000122 0000000000000000
> >>>>>> [  261.214251][T11285] raw: 0000000000000001 00000000000d84b3
> >>>>>> 0000000400000000 ffffff8003678000
> >>>>>> [  261.214254][T11285] page dumped because:
> >>>>>> VM_WARN_ON_FOLIO(!folio_test_anon(folio))
> >>>>>> [  261.214257][T11285] page_owner tracks the page as allocated
> >>>>>> [  261.214260][T11285] page last allocated via order 0, migratetyp=
e
> >>>>>> Movable, gfp_mask 0x2140cca(GFP_HIGHUSER_MOVABLE|__GFP_COMP), pid
> >>>>>> 11285, tgid 11285 (swapoff), ts 261214177545, free_ts 261151875699
> >>>>>> [  261.214268][T11285]  post_alloc_hook+0x1b8/0x1c0
> >>>>>> [  261.214284][T11285]  prep_new_page+0x28/0x13c
> >>>>>> [  261.214291][T11285]  get_page_from_freelist+0x198c/0x1aa4
> >>>>>> [  261.214298][T11285]  __alloc_pages+0x15c/0x330
> >>>>>> [  261.214304][T11285]  __folio_alloc+0x1c/0x4c
> >>>>>> [  261.214310][T11285]  __read_swap_cache_async+0xd8/0x48c
> >>>>>> [  261.214320][T11285]  swap_cluster_readahead+0x158/0x324
> >>>>>> [  261.214326][T11285]  swapin_readahead+0x64/0x448
> >>>>>> [  261.214331][T11285]  __arm64_sys_swapoff+0x6ec/0x14b0
> >>>>>> [  261.214337][T11285]  invoke_syscall+0x58/0x114
> >>>>>> [  261.214353][T11285]  el0_svc_common+0xac/0xe0
> >>>>>> [  261.214360][T11285]  do_el0_svc+0x1c/0x28
> >>>>>> [  261.214366][T11285]  el0_svc+0x38/0x68
> >>>>>> [  261.214372][T11285]  el0t_64_sync_handler+0x68/0xbc
> >>>>>> [  261.214376][T11285]  el0t_64_sync+0x1a8/0x1ac
> >>>>>> [  261.214381][T11285] page last free pid 90 tgid 90 stack trace:
> >>>>>> [  261.214386][T11285]  free_unref_page_prepare+0x338/0x374
> >>>>>> [  261.214395][T11285]  free_unref_page_list+0x84/0x378
> >>>>>> [  261.214400][T11285]  shrink_folio_list+0x1234/0x13e4
> >>>>>> [  261.214409][T11285]  evict_folios+0x1458/0x19b4
> >>>>>> [  261.214417][T11285]  try_to_shrink_lruvec+0x1c8/0x264
> >>>>>> [  261.214422][T11285]  shrink_one+0xa8/0x234
> >>>>>> [  261.214427][T11285]  shrink_node+0xb38/0xde0
> >>>>>> [  261.214432][T11285]  balance_pgdat+0x7a4/0xdb4
> >>>>>> [  261.214437][T11285]  kswapd+0x290/0x4e4
> >>>>>> [  261.214442][T11285]  kthread+0x114/0x1bc
> >>>>>> [  261.214459][T11285]  ret_from_fork+0x10/0x20
> >>>>>> [  261.214477][T11285] ------------[ cut here ]------------
> >>>>>> [  261.214480][T11285] WARNING: CPU: 3 PID: 11285 at mm/rmap.c:130=
5
> >>>>>> folio_add_anon_rmap_ptes+0x2b4/0x330
> >>>>>>
> >>>>>> [  261.215403][T11285] pstate: 63400005 (nZCv daif +PAN -UAO +TCO =
+DIT
> >>>>>> -SSBS BTYPE=3D--)
> >>>>>> [  261.215423][T11285] pc : folio_add_anon_rmap_ptes+0x2b4/0x330
> >>>>>> [  261.215428][T11285] lr : folio_add_anon_rmap_ptes+0x2b4/0x330
> >>>>>> [  261.215433][T11285] sp : ffffffc0a7dbbbf0
> >>>>>> [  261.215437][T11285] x29: ffffffc0a7dbbbf0 x28: ffffff8040860a08
> >>>>>> x27: ffffff80db480000
> >>>>>> [  261.215445][T11285] x26: fffffffe04cc2980 x25: ffffff808f77f120
> >>>>>> x24: 0000007b44941000
> >>>>>> [  261.215452][T11285] x23: 0000000000000001 x22: 0000000000000001
> >>>>>> x21: fffffffe04cc2980
> >>>>>> [  261.215459][T11285] x20: ffffff80db480000 x19: fffffffe04cc2980
> >>>>>> x18: ffffffed011dae80
> >>>>>> [  261.215465][T11285] x17: 0000000000000001 x16: ffffffffffffffff
> >>>>>> x15: 0000000000000004
> >>>>>> [  261.215471][T11285] x14: ffffff82fb73fac0 x13: 0000000000000003
> >>>>>> x12: 0000000000000003
> >>>>>> [  261.215476][T11285] x11: 00000000fffeffff x10: c0000000fffeffff=
 x9
> >>>>>> : 0d46c0889b468e00
> >>>>>> [  261.215483][T11285] x8 : 0d46c0889b468e00 x7 : 545b5d3935343431=
 x6
> >>>>>> : 322e31363220205b
> >>>>>> [  261.215489][T11285] x5 : ffffffed013de407 x4 : ffffffed00698967=
 x3
> >>>>>> : 0000000000000000
> >>>>>> [  261.215495][T11285] x2 : 0000000000000000 x1 : ffffffc0a7dbb8c0=
 x0
> >>>>>> : ffffff8068c15c80
> >>>>>> [  261.215501][T11285] Call trace:
> >>>>>> [  261.215504][T11285]  folio_add_anon_rmap_ptes+0x2b4/0x330
> >>>>>> [  261.215509][T11285]  __arm64_sys_swapoff+0x8cc/0x14b0
> >>>>>> [  261.215516][T11285]  invoke_syscall+0x58/0x114
> >>>>>> [  261.215526][T11285]  el0_svc_common+0xac/0xe0
> >>>>>> [  261.215532][T11285]  do_el0_svc+0x1c/0x28
> >>>>>> [  261.215539][T11285]  el0_svc+0x38/0x68
> >>>>>> [  261.215544][T11285]  el0t_64_sync_handler+0x68/0xbc
> >>>>>> [  261.215548][T11285]  el0t_64_sync+0x1a8/0x1ac
> >>>>>> [  261.215552][T11285] ---[ end trace 0000000000000000 ]---
> >>>>>
> >>>>> Ah, yes. in unuse_pte(), you'll have to do the right thing if
> >>>>> !folio_test(anon) before doing the folio_add_anon_rmap_pte().
> >>>>>
> >>>>> You might have a fresh anon folio in the swapcache that was never m=
apped
> >>>>> (hopefully order-0, otherwise we'd likely be in trouble).
> >>>>
> >>>> Yes. It is order-0
> >>>>
> >>>> [  261.214260][T11285] page last allocated via order 0, migratetype
> >>>>
> >>>> Otherwise, we would have encountered this VM_WARN_ON_FOLIO?
> >>>>
> >>>> __folio_add_anon_rmap()
> >>>> {
> >>>> ...
> >>>> VM_WARN_ON_FOLIO(folio_test_large(folio) &&
> >>>>        level !=3D RMAP_LEVEL_PMD, folio);
> >>>> ...
> >>>> }
> >>>>
> >>>> Given that nobody has ever reported this warning, I assume all calle=
rs
> >>>> using folio_add_anon_rmap_pte(s) are right now safe to move to ?
> >>>
> >>> Yes, and we should likely add a VM_WARN_ON_ONCE() here that we have a
> >>> small folio if !anon. If that ever changes, we can assess the situati=
on.
> >>>
> >>
> >> this patch actually has a WARN_ON for all !anon, so it extends the WAR=
N
> >> to small.
>
> Not what I mean, see below:
>
> >>
> >> -       if (unlikely(!folio_test_anon(folio))) {
> >> -               VM_WARN_ON_FOLIO(!folio_test_locked(folio), folio);
> >> -               /*
> >> -                * For a PTE-mapped large folio, we only know that the=
 single
> >> -                * PTE is exclusive. Further, __folio_set_anon() might=
 not get
> >> -                * folio->index right when not given the address of th=
e head
> >> -                * page.
> >> -                */
> >> -               VM_WARN_ON_FOLIO(folio_test_large(folio) &&
> >> -                                level !=3D RMAP_LEVEL_PMD, folio);
> >> -               __folio_set_anon(folio, vma, address,
> >> -                                !!(flags & RMAP_EXCLUSIVE));
> >> -       } else if (likely(!folio_test_ksm(folio))) {
> >> +       VM_WARN_ON_FOLIO(!folio_test_anon(folio), folio);
> >> +
> >>
> >>> Only swap created "new" anon folios without properly calling the righ=
t
> >>> function so far, all other code handles that correctly.
> >
> > as I assume patch2/3 should have moved all !anon to
> > folio_add_new_anon_rmap()
> >
> > diff --git a/mm/ksm.c b/mm/ksm.c
> > index d2641bc2efc9..c913ba8c37eb 100644
> > --- a/mm/ksm.c
> > +++ b/mm/ksm.c
> > @@ -1420,7 +1420,14 @@ static int replace_page(struct vm_area_struct
> > *vma, struct page *page,
> >           */
> >          if (!is_zero_pfn(page_to_pfn(kpage))) {
> >                  folio_get(kfolio);
> > -               folio_add_anon_rmap_pte(kfolio, kpage, vma, addr, RMAP_=
NONE);
> > +               /*
> > +                * We currently ensure that new folios cannot be partia=
lly
> > +                * exclusive: they are either fully exclusive or fully =
shared.
> > +                */
> > +               if (!folio_test_anon(kfolio))
> > +                       folio_add_new_anon_rmap(kfolio, vma, addr, RMAP=
_NONE);
> > +               else
> > +                       folio_add_anon_rmap_pte(kfolio, kpage, vma, > a=
ddr, RMAP_NONE);
>
> I don't think that is required? We are only working with anon folios. Or
> were you able to trigger this? (which would be weird)

I didn't trigger this. but I am not sure if kfifo is always anon based on
the code context.

for page,  it is 100% anon(otherwise "goto out"), but I am not quite
sure about kpage
by the code context.

static int try_to_merge_one_page(struct vm_area_struct *vma,
                                 struct page *page, struct page *kpage)
{
        pte_t orig_pte =3D __pte(0);
        int err =3D -EFAULT;

        if (page =3D=3D kpage)                      /* ksm page forked */
                return 0;

        if (!PageAnon(page))
                goto out;
        ....
}

Then I saw this

static int replace_page(struct vm_area_struct *vma, struct page *page,
                        struct page *kpage, pte_t orig_pte)
{
        ...
        VM_BUG_ON_PAGE(PageAnonExclusive(page), page);
        VM_BUG_ON_FOLIO(folio_test_anon(kfolio) && PageAnonExclusive(kpage)=
,
                        kfolio);
}

If kfolio is always anon, we should have used
VM_BUG_ON_FOLIO(PageAnonExclusive(kpage), folio)
just like
VM_BUG_ON_PAGE(PageAnonExclusive(page), page);
without "folio_test_anon(kfolio)".

So I lost my way.

>
> [...]
>
> > -               folio_add_anon_rmap_pte(folio, page, vma, addr, rmap_fl=
ags);
> > +               /*
> > +                * We currently ensure that new folios cannot be partia=
lly
> > +                * exclusive: they are either fully exclusive or fully =
shared.
> > +                */
> > +               if (!folio_test_anon(folio))
>
> Here I suggest changing the comment to (and adding the VM_WARN_ON_ONCE):
>
> /*
>   * We currently only expect small !anon folios, for which we now that
>   * they are either fully exclusive or fully shared. If we ever get large
>   * folios here, we have to be careful.
>   */
> if (!folio_test_anon(folio) {
>         VM_WARN_ON_ONCE(folio_test_large(folio));
>         folio_add_new_anon_rmap(folio, vma, addr, rmap_flags);
> } else {
> ...

looks good to me.

>
>
> --
> Cheers,
>
> David / dhildenb
>

Thanks
Barry

