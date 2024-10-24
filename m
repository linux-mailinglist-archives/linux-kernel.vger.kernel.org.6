Return-Path: <linux-kernel+bounces-379148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13BA19ADAB3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 05:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C28DA282864
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 03:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6297E16087B;
	Thu, 24 Oct 2024 03:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cJ5v84sf"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558B11EB3D
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 03:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729741930; cv=none; b=eZV9WOO62dmQRFQUgmwewXiuAn+rp8p+cnxu07Km+UG6QGeLZd08I5AxheSQuZpEMK8V0Y6qCSUdbchspUJ3ebx/sApdNCEcELX1O4nr7l/ntEFqyaZo/ppNVO6WzLHl2CNsuFTHpxMrBGcBIrh/E52eluKdUlgPa36hpzZ8sew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729741930; c=relaxed/simple;
	bh=k6u4Ss6k8MlZlvyBWETtC7+EjLSptpXtvyoE6KO3TOs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R2esrr2lUayekWy/Zhtj9wHXP7sL0LHXAOAbhtnf+fWh0HGnjaslsRxI2bfMszfIWmboZxQMikzSTtHuliTpDMVUsHHJwYUZXv2gPUqN6clxMOQ5JamL3eF+B7AQiEpJQxmZtFQYg9Q5MwdYqjEjA0nNXQqch3/DhDdhdCc/9yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cJ5v84sf; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2fb470a8b27so14042381fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 20:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729741925; x=1730346725; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sRnPT8Dyhb9pG40q7iUbKYdz9ByQD97iggYnI/cI1nQ=;
        b=cJ5v84sff3LlCDTTBWKI3vAlZ+x5OY5mrjidyx86j7NefvcHWj7JsKwRVJt9+8aOLg
         kNNJAmVIhivNvKQ3SDMmVyDNwoBMDgPfFKYUBNJxmHqvdyxv5JrmqI5ry7Ba3hWVUJvf
         SRIliCz0i7B73b6ZvmLlArGN5ONKRRpRhn0Vi0VcKJwosooG2EKGlQcBjHk44nqsV1lP
         zED8nG2dCHVwQRl8F4Wxe/9idK42BBRF9lp3MquzZbz9QNKumLvwMk8zSJFncYFfAbYV
         GdduNIQ8PM75QfWcguT/VDRK3v9XXXXizEUWlT5HFoCDLiiSscEvzOwmmTFFluoy8ZSE
         dcow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729741925; x=1730346725;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sRnPT8Dyhb9pG40q7iUbKYdz9ByQD97iggYnI/cI1nQ=;
        b=aTt/jv8CPKRlWy/uCaTALluHzrzyrbvCinTVjwwacOoDShgIaR3ZqlM1hbq8mPHHh8
         aRls0NVj9c4GpUv2y2uahj+BF1HN/Lkgg1aYPw6il7DtAtnW7Il+EjSjxsOK9KQL28ec
         NQGqr38BGq5wQD8xuFVD2cunduTycL3CbqM0TEWVbdamESGXdg1ieR6EQofrCNoJidNn
         bLXc/+3Fj0V+K5FfOnNX7X1bLe9vvWmXq51EgGUnFFjsC5gvKR5ZClwCNv80uOI6nLNf
         5yiFVkJiWHctagxm9+ebfPozHtfrNqk+9nYl779NbdXoO7uXKWJKZbr8agbhBLqEUkjX
         FnlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNgoBvb9H5n1cOgV/9929sFO/DjJEApDyQgDG5DkBDhl/5IvjIZIMURhKuP7EIVEHcQMX2SFD14JR8pYo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLsnXiV0qbfAbZqvme++P7z4ePPFN9K5NgQfb+S+yLyTdd80BI
	g+QpxXb1GIumjcTnIOAFzbsDH8ZCcZx0b7RMf6KrZK+g9DGH/C6HwhW0ECFDRbegX2M/N+/ey16
	XoSB/t5TxOj5rFDHQyBR244yd0DU=
X-Google-Smtp-Source: AGHT+IGbpVn8SXfTFJAAla51cn/sy/ijW/MgYlQWJhDtQMXA+tDzl+zqOj/7IfyE+txR6engpS46MLDYBFX6xYmeOGs=
X-Received: by 2002:a2e:b8c6:0:b0:2f7:6277:f2be with SMTP id
 38308e7fff4ca-2fca8368bf6mr1529781fa.22.1729741925071; Wed, 23 Oct 2024
 20:52:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022192451.38138-1-ryncsn@gmail.com> <87ed474kvx.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <CAMgjq7BfO=dNYep4z1aS7nUAJU3bktR17gYAufx=kkLudq4dAQ@mail.gmail.com> <875xpi42wg.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <875xpi42wg.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Thu, 24 Oct 2024 11:51:48 +0800
Message-ID: <CAMgjq7AxYyYTZ9NQ_3eJaxTis0CFAr5Zpi2oz3FPFYoWhDp00g@mail.gmail.com>
Subject: Re: [PATCH 00/13] mm, swap: rework of swap allocator locks
To: "Huang, Ying" <ying.huang@intel.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Barry Song <v-songbaohua@oppo.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Hugh Dickins <hughd@google.com>, 
	Yosry Ahmed <yosryahmed@google.com>, Tim Chen <tim.c.chen@linux.intel.com>, 
	Nhat Pham <nphamcs@gmail.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024 at 11:08=E2=80=AFAM Huang, Ying <ying.huang@intel.com>=
 wrote:
>
> Kairui Song <ryncsn@gmail.com> writes:
>
> > On Wed, Oct 23, 2024 at 10:27=E2=80=AFAM Huang, Ying <ying.huang@intel.=
com> wrote:
> >>
> >> Hi, Kairui,
> >
> > Hi Ying,
> >
> >>
> >> Kairui Song <ryncsn@gmail.com> writes:
> >>
> >> > From: Kairui Song <kasong@tencent.com>
> >> >
> >> > This series improved the swap allocator performance greatly by rewor=
king
> >> > the locking design and simplify a lot of code path.
> >> >
> >> > This is follow up of previous swap cluster allocator series:
> >> > https://lore.kernel.org/linux-mm/20240730-swap-allocator-v5-0-cb9c14=
8b9297@kernel.org/
> >> >
> >> > And this series is based on an follow up fix of the swap cluster
> >> > allocator:
> >> > https://lore.kernel.org/linux-mm/20241022175512.10398-1-ryncsn@gmail=
.com/
> >> >
> >> > This is part of the new swap allocator work item discussed in
> >> > Chris's "Swap Abstraction" discussion at LSF/MM 2024, and
> >> > "mTHP and swap allocator" discussion at LPC 2024.
> >> >
> >> > Previous series introduced a fully cluster based allocation algorith=
m,
> >> > this series completely get rid of the old allocation path and makes =
the
> >> > allocator avoid grabbing the si->lock unless needed. This bring huge
> >> > performance gain and get rid of slot cache on freeing path.
> >>
> >> Great!
> >>
> >> > Currently, swap locking is mainly composed of two locks, cluster loc=
k
> >> > (ci->lock) and device lock (si->lock). The device lock is widely use=
d
> >> > to protect many things, causing it to be the main bottleneck for SWA=
P.
> >>
> >> Device lock can be confusing with another device lock for struct devic=
e.
> >> Better to call it swap device lock?
> >
> > Good idea, I'll use the term swap device lock then.
> >
> >>
> >> > Cluster lock is much more fine-grained, so it will be best to use
> >> > ci->lock instead of si->lock as much as possible.
> >> >
> >> > `perf lock` indicates this issue clearly. Doing linux kernel build
> >> > using tmpfs and ZRAM with limited memory (make -j64 with 1G memcg an=
d 4k
> >> > pages), result of "perf lock contention -ab sleep 3":
> >> >
> >> >   contended   total wait     max wait     avg wait         type   ca=
ller
> >> >
> >> >      34948     53.63 s       7.11 ms      1.53 ms     spinlock   fre=
e_swap_and_cache_nr+0x350
> >> >      16569     40.05 s       6.45 ms      2.42 ms     spinlock   get=
_swap_pages+0x231
> >> >      11191     28.41 s       7.03 ms      2.54 ms     spinlock   swa=
pcache_free_entries+0x59
> >> >       4147     22.78 s     122.66 ms      5.49 ms     spinlock   pag=
e_vma_mapped_walk+0x6f3
> >> >       4595      7.17 s       6.79 ms      1.56 ms     spinlock   swa=
pcache_free_entries+0x59
> >> >     406027      2.74 s       2.59 ms      6.74 us     spinlock   lis=
t_lru_add+0x39
> >> >   ...snip...
> >> >
> >> > The top 5 caller are all users of si->lock, total wait time up sums =
to
> >> > several minutes in the 3 seconds time window.
> >>
> >> Can you show results of `perf record -g`, `perf report -g` too?  I hav=
e
> >> interest to check hot spot shifting too.
> >
> > Sure. I think `perf lock` result is already good enough and cleaner.
> > My test environment are mostly VM based so spinlock slow path may get
> > offloaded to host, and can't be see by perf record, I collected
> > following data after disabled paravirt spinlock:
> >
> > The time consumption and stack trace of a page fault before:
> > -   78.45%     0.17%  cc1              [kernel.kallsyms]
> >                 [k] asm_exc_page_fault
> >    - 78.28% asm_exc_page_fault
> >       - 78.18% exc_page_fault
> >          - 78.17% do_user_addr_fault
> >             - 78.09% handle_mm_fault
> >                - 78.06% __handle_mm_fault
> >                   - 69.69% do_swap_page
> >                      - 55.87% alloc_swap_folio
> >                         - 55.60% mem_cgroup_swapin_charge_folio
> >                            - 55.48% charge_memcg
> >                               - 55.45% try_charge_memcg
> >                                  - 55.36% try_to_free_mem_cgroup_pages
> >                                     - do_try_to_free_pages
> >                                        - 55.35% shrink_node
> >                                           - 55.27% shrink_lruvec
> >                                              - 55.13% try_to_shrink_lru=
vec
> >                                                 - 54.79% evict_folios
> >                                                    - 54.35% shrink_foli=
o_list
> >                                                       - 30.01% add_to_s=
wap
> >                                                          - 29.77%
> > folio_alloc_swap
> >                                                             - 29.50%
> > get_swap_pages
> >
> > 25.03% queued_spin_lock_slowpath
> >                                                                - 2.71%
> > alloc_swap_scan_cluster
> >
> > 1.80% queued_spin_lock_slowpath
> >                                                                   +
> > 0.89% __try_to_reclaim_swap
> >                                                                - 1.74%
> > swap_reclaim_full_clusters
> >
> > 1.74% queued_spin_lock_slowpath
> >                                                       - 10.88%
> > try_to_unmap_flush_dirty
> >                                                          - 10.87%
> > arch_tlbbatch_flush
> >                                                             - 10.85%
> > on_each_cpu_cond_mask
> >
> > smp_call_function_many_cond
> >                                                       + 7.45% pageout
> >                                                       + 2.71% try_to_un=
map_flush
> >                                                       + 1.90% try_to_un=
map
> >                                                       + 0.78% folio_ref=
erenced
> >                      - 9.41% cluster_swap_free_nr
> >                         - 9.39% free_swap_slot
> >                            - 9.35% swapcache_free_entries
> >                                 8.40% queued_spin_lock_slowpath
> >                                 0.93% swap_entry_range_free
> >                      - 3.61% swap_read_folio_bdev_sync
> >                         - 3.55% submit_bio_wait
> >                            - 3.51% submit_bio_noacct_nocheck
> >                               + 3.46% __submit_bio
> >                   + 7.71% do_pte_missing
> >                   + 0.61% wp_page_copy
> >
> > The queued_spin_lock_slowpath above is the si->lock, and there are
> > multiple users of it so the total overhead is higher than shown.
> >
> > After:
> > -   75.05%     0.43%  cc1              [kernel.kallsyms]
> >                 [k] asm_exc_page_fault
> >    - 74.62% asm_exc_page_fault
> >       - 74.36% exc_page_fault
> >          - 74.34% do_user_addr_fault
> >             - 74.10% handle_mm_fault
> >                - 73.96% __handle_mm_fault
> >                   - 67.55% do_swap_page
> >                      - 45.92% alloc_swap_folio
> >                         - 45.03% mem_cgroup_swapin_charge_folio
> >                            - 44.58% charge_memcg
> >                               - 44.44% try_charge_memcg
> >                                  - 44.12% try_to_free_mem_cgroup_pages
> >                                     - do_try_to_free_pages
> >                                        - 44.10% shrink_node
> >                                           - 43.86% shrink_lruvec
> >                                              - 41.92% try_to_shrink_lru=
vec
> >                                                 - 40.67% evict_folios
> >                                                    - 37.12% shrink_foli=
o_list
> >                                                       - 20.88% pageout
> >                                                          + 20.02% swap_=
writepage
> >                                                          + 0.72% shmem_=
writepage
> >                                                       - 4.08% add_to_sw=
ap
> >                                                          - 2.48%
> > folio_alloc_swap
> >                                                             - 2.12%
> > __mem_cgroup_try_charge_swap
> >                                                                - 1.47%
> > swap_cgroup_record
> >                                                                   +
> > 1.32% _raw_spin_lock_irqsave
> >                                                          - 1.56%
> > add_to_swap_cache
> >                                                             - 1.04% xas=
_store
> >                                                                + 1.01%
> > workingset_update_node
> >                                                       + 3.97%
> > try_to_unmap_flush_dirty
> >                                                       + 3.51% folio_ref=
erenced
> >                                                       + 2.24% __remove_=
mapping
> >                                                       + 1.16% try_to_un=
map
> >                                                       + 0.52% try_to_un=
map_flush
> >                                                      2.50%
> > queued_spin_lock_slowpath
> >                                                      0.79% scan_folios
> >                                                 + 1.20% try_to_inc_max_=
seq
> >                                              + 1.92% lru_add_drain
> >                         + 0.73% vma_alloc_folio_noprof
> >                      - 9.81% swap_read_folio_bdev_sync
> >                         - 9.61% submit_bio_wait
> >                            + 9.49% submit_bio_noacct_nocheck
> >                      - 8.06% cluster_swap_free_nr
> >                         - 8.02% swap_entry_range_free
> >                            + 3.92% __mem_cgroup_uncharge_swap
> >                            + 2.90% zram_slot_free_notify
> >                              0.58% clear_shadow_from_swap_cache
> >                      - 1.32% __folio_batch_add_and_move
> >                         - 1.30% folio_batch_move_lru
> >                            + 1.10% folio_lruvec_lock_irqsave
>
> Thanks for data.
>
> It seems that the cycles shifts from spinning to memory compression.
> That is expected.
>
> > spin_lock usage is much lower.
> >
> > I prefer the perf lock output as it shows the exact time and user of lo=
cks.
>
> perf cycles data is more complete.  You can find which part becomes new
> hot spot.
>
> >>
> >> > Following the new allocator design, many operation doesn't need to t=
ouch
> >> > si->lock at all. We only need to take si->lock when doing operations
> >> > across multiple clusters (eg. changing the cluster list), other
> >> > operations only need to take ci->lock. So ideally allocator should
> >> > always take ci->lock first, then, if needed, take si->lock. But due
> >> > to historical reasons, ci->lock is used inside si->lock by design,
> >> > causing lock inversion if we simply try to acquire si->lock after
> >> > acquiring ci->lock.
> >> >
> >> > This series audited all si->lock usage, simplify legacy codes, elimi=
nate
> >> > usage of si->lock as much as possible by introducing new designs bas=
ed
> >> > on the new cluster allocator.
> >> >
> >> > Old HDD allocation codes are removed, cluster allocator is adapted
> >> > with small changes for HDD usage, test is looking OK.
> >>
> >> I think that it's a good idea to remove HDD allocation specific code.
> >> Can you check the performance of swapping to HDD?  However, I understa=
nd
> >> that many people have no HDD in hand.
> >
> > It's not hard to make cluster allocator work well with HDD in theory,
> > see the commit "mm, swap: use a global swap cluster for non-rotation
> > device".
> > The testing is not very reliable though, I found HDD swap performance
> > is very unstable because of the IO pattern of HDD, so it's just a best
> > effort try.
>
> Just to check whether code change cause something too bad for HDD.  No
> measurable difference is a good news.
>
> >> > And this also removed slot cache for freeing path. The performance i=
s
> >> > better without it, and this enables other clean up and optimizations
> >> > as discussed before:
> >> > https://lore.kernel.org/all/CAMgjq7ACohT_uerSz8E_994ZZCv709Zor+43hdm=
esW_59W1BWw@mail.gmail.com/
> >> >
> >> > After this series, lock contention on si->lock is nearly unobservabl=
e
> >> > with `perf lock` with the same test above :
> >> >
> >> >   contended   total wait     max wait     avg wait         type   ca=
ller
> >> >   ... snip ...
> >> >          91    204.62 us      4.51 us      2.25 us     spinlock   cl=
uster_move+0x2e
> >> >   ... snip ...
> >> >          47    125.62 us      4.47 us      2.67 us     spinlock   cl=
uster_move+0x2e
> >> >   ... snip ...
> >> >          23     63.15 us      3.95 us      2.74 us     spinlock   cl=
uster_move+0x2e
> >> >   ... snip ...
> >> >          17     41.26 us      4.58 us      2.43 us     spinlock   cl=
uster_isolate_lock+0x1d
> >> >   ... snip ...
> >> >
> >> > cluster_move and cluster_isolate_lock are basically the only users
> >> > of si->lock now, performance gain is huge with reduced LOC.
> >> >
> >> > Tests
> >> > =3D=3D=3D
> >> >
> >> > Build kernel with defconfig on tmpfs with ZRAM as swap:
> >> > ---
> >> >
> >> > Running a test matrix which is scaled up progressive for a intuitive=
 result.
> >> > The test are ran on top of tmpfs, using memory cgroup for memory lim=
itation,
> >> > on a 48c96t system.
> >> >
> >> > 12 test run for each case, it can be seen clearly that as concurrent=
 job
> >> > number goes higher the performance gain is higher, the performance i=
s
> >> > higher even with low concurrency.
> >> >
> >> >    make -j<NR>     |   System Time (seconds)  |   Total Time (second=
s)
> >> >  (NR / Mem / ZRAM) | (Before / After / Delta) | (Before / After / De=
lta)
> >> >  With 4k pages only:
> >> >   6 / 192M / 3G    |    5258 /  5235 / -0.3%  |    1420 /  1414 / -0=
.3%
> >> >  12 / 256M / 4G    |    5518 /  5337 / -3.3%  |     758 /   742 / -2=
.1%
> >> >  24 / 384M / 5G    |    7091 /  5766 / -18.7% |     476 /   422 / -1=
1.3%
> >> >  48 / 768M / 7G    |   11139 /  5831 / -47.7% |     330 /   221 / -3=
3.0%
> >> >  96 / 1.5G / 10G   |   21303 / 11353 / -46.7% |     283 /   180 / -3=
6.4%
> >> >  With 64k mTHP:
> >> >  24 / 512M / 5G    |    5104 /  4641 / -18.7% |     376 /   358 / -4=
.8%
> >> >  48 /   1G / 7G    |    8693 /  4662 / -18.7% |     257 /   176 / -3=
1.5%
> >> >  96 /   2G / 10G   |   17056 / 10263 / -39.8% |     234 /   169 / -2=
7.8%
> >>
> >> How much is the swap in/out throughput before/after the change?
> >
> > This may not be too beneficial for typical throughput measurement:
> > - For example doing the same test with brd will only show a ~20%
> > performance improvement, still a big gain though. I think the si->lock
> > spinlock wasting CPU cycles may effect CPU sensitive things like ZRAM
> > even more.
>
> 20% is a good data.  You don't need to guess.  perf cycles profiling can
> show the hot spot.
>
> > - And simple benchmarks which just do multiple sequential swaps in/out
> > in multiple thread hardly stress the allocator.
> >
> > I haven't found a good
> > benchmark to simulate random parallel IOs on SWAP yet, I can write one
> > later.
>
> I have used anon-w-rand test case of vm-scalability to simulate random
> parallel swap out.
>
> https://git.kernel.org/pub/scm/linux/kernel/git/wfg/vm-scalability.git/tr=
ee/case-anon-w-rand
>
> > A more close to real word benchmark like build kernel test, or
> > mysql/sysbench all showed great improment.
>
> Yes.  Real work load is good.  We can use micro-benchmark to find out
> some performance limit, for example, max possible throughput.
>
> >>
> >> When I worked on swap in/out performance before, the hot spot shifts f=
rom
> >> swap related code to LRU lock and zone lock.  Things may change a lot
> >> now.
> >>
> >> If zram is used as swap device, the hot spot may become
> >> compression/decompression after solving the swap lock contention.  To
> >> stress swap subsystem further, we may use a ram disk as swap.
> >> Previously, we have used a simulated pmem device (backed by DRAM).  Th=
at
> >> can be setup as in,
> >>
> >> https://pmem.io/blog/2016/02/how-to-emulate-persistent-memory/
> >>
> >> After creating the raw block device: /dev/pmem0, we can do
> >>
> >> $ mkswap /dev/pmem0
> >> $ swapon /dev/pmem0
> >>
> >> Can you use something similar if necessary?
> >
> > I used to test with brd, as described above,
>
> brd will allocate memory during running, pmem can avoid that.  perf
> profile is your friends to root cause the possible issue.
>
> > I think using ZRAM with
> > test simulating real workload is more useful.
>
> Yes.  And, as I said before.  Micro-benchmark has its own value.

Hi Ying,

Thank you very much for the suggestion, I didn't mean I'm against
micro benchmarks in any way, just a lot of effort was spent on other
tests so I skipped that part for V1.

As you mentioned vm-scalability, I think this is definitely a good
idea to include that test when pmem simulation.

There are still some bottlenecks of SWAP, beside compression and page
fault / tlb, mostly cgroup lock and list lru locks. I have some ideas
to optimize these too, could be next steps.

> > And I did include a Sequential SWAP test, the result is looking OK (no
> > regression, minor to none improvement).
>
> Good.  At least we have no regression here.
>
> --
> Best Regards,
> Huang, Ying

