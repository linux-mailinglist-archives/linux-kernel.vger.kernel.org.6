Return-Path: <linux-kernel+bounces-303627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A799611DE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 17:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC466281D06
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 15:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8771C8FDC;
	Tue, 27 Aug 2024 15:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P0klNOae"
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531E41C825E
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 15:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724772243; cv=none; b=Yx7AXg8CKqSZ97LM5lI3ffc9/0lyCmbhswDhkLKpM09FZXHV+uB5UdyJZ1rSt6NpTcnu2aWmJiNooZngSkjL1ENPBQBlZIFZtoxgIvCeioOqEPb7CbOeWBdYGVTdz9TVTto9xhwYup1riV1wx2f/vs21EWYqcR9jkQSKlqtRA94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724772243; c=relaxed/simple;
	bh=Zt9p2PTNVS4EMWklnaVwKLjuhvFPCX1Mpbu4gF6cm+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=APrke+jwpoDaBow037HJLyR5KCFZUU31iUyk7aY2sxG487Icil0WIshoT/9mCQj9/LkXSJsxT6kc5lrinicW16NNIvvqn6rbu3VhyksWeHpJmcubOcFfNEJ7Cnx7gtiR9BUA9IURURyTwA2be1bYNxEatcgYaiCdNFHrGXl0iXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P0klNOae; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7093d565310so5555522a34.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 08:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724772240; x=1725377040; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VJlqhcnIZtxgUpe8ETMlRDL5dqH9NpG4OFeoaKR1IRM=;
        b=P0klNOaeHXBp2vO/366d7WQvVrVMiqZU7buURdTDMoK679/b7cvadlswnEJtncZ4rN
         y0ngL487kir8NiUijfr8CEmqG7fdrNex3iyochdT7OsAn0gOQryA2/GEt5GZEXslI5aQ
         kt1ZBsgPWD4rV6P/N7oS/V845+UNlNZ7RDnXAIxtQD7OK8lkTmKgP7afgehrmORJaS1u
         n1aR/nt3XEBBLV+dJrtNYia+VEmMPIGRWlbPadpZD2N05r3aGAljs0aFLaX1OWB4UOaX
         1O8KqY1DlthbJj4gPvoRuHFFuSkLy+c1MBjP6Q9cGFKTJ6kDitAd6oDxBignL4AlxPa7
         pvZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724772240; x=1725377040;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VJlqhcnIZtxgUpe8ETMlRDL5dqH9NpG4OFeoaKR1IRM=;
        b=pAzHEWvk518M6gr6OqTRVN1KpHGgNndc9mIvTc1wZgUbNMBVdRNbUwffUWOZQYnz3e
         +iTNvPcaYD6v/8xBw8wfQHYr7rnykcEWjP5uTqjFURhBSdWW72pygP4qxutHmjAw3Zay
         0h+GCXt2iZy+P59l8LtkJqwKOkZjGOS0BqcrF8KpzHy9qycsAMO+V81u7ClYD0Lz0p7c
         s0japhXe9/EgbFZMLC8njS02saWLqAIddB1/JyAVkzoU8WnYseKm4ILzp1lvSQbYqHSO
         YEM0nfMsExBJ41hDvHIXiVN4H655mNUR4NEMC6cprOvDRAommej/iWjbpcUJEq2X5qlZ
         PpXg==
X-Gm-Message-State: AOJu0YxE01zkrZpq8i5XkfMIyKvWt6K7dcLKqlzOaWqVcL2ezYs8upac
	CLegm9d3+6e9WJysPhmbttgRfZgr81Ng+D/zPn11+yebbKr5jHaX6Aa2O5ZhbkRk6+i6PLkqMRe
	h0aKEYfSaEs/rw2xMrq8cXz3aHho=
X-Google-Smtp-Source: AGHT+IGCY0ENeUDtFWnKBV596hhaT8U1ZRxwjmMKfcgFTZ/Fiz8vCWpoxH6v7/bK3ULWxkvTtuI+ZUUJ+DzkQKNF8nM=
X-Received: by 2002:a05:6830:2645:b0:709:3bf8:93bc with SMTP id
 46e09a7af769-70e0ec7f093mr13158001a34.30.1724772240066; Tue, 27 Aug 2024
 08:24:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819021621.29125-1-kanchana.p.sridhar@intel.com>
 <CAKEwX=OO6frFa+S3xjtoabB2dY1Y5RN5qjMsVUsgKDK_QuOFzg@mail.gmail.com>
 <SJ0PR11MB5678288EE890E8CB882839CDC98E2@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <SJ0PR11MB567801EE747E2810EF183C73C9892@SJ0PR11MB5678.namprd11.prod.outlook.com>
 <CAKEwX=PYv4Cn_a7WSnbUyhwSBO61xoDPSexXxS0uwwxu5P6XLw@mail.gmail.com> <SJ0PR11MB5678E44062CADBE8BAB546F3C9942@SJ0PR11MB5678.namprd11.prod.outlook.com>
In-Reply-To: <SJ0PR11MB5678E44062CADBE8BAB546F3C9942@SJ0PR11MB5678.namprd11.prod.outlook.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 27 Aug 2024 08:23:49 -0700
Message-ID: <CAKEwX=ORuJabxQSehU5E0QNG=Gx6QkyTCb1vek3AOcQuvF54Xg@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] mm: ZSWAP swap-out of mTHP folios
To: "Sridhar, Kanchana P" <kanchana.p.sridhar@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"hannes@cmpxchg.org" <hannes@cmpxchg.org>, "yosryahmed@google.com" <yosryahmed@google.com>, 
	"ryan.roberts@arm.com" <ryan.roberts@arm.com>, "Huang, Ying" <ying.huang@intel.com>, 
	"21cnbao@gmail.com" <21cnbao@gmail.com>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, 
	"Zou, Nanhai" <nanhai.zou@intel.com>, "Feghali, Wajdi K" <wajdi.k.feghali@intel.com>, 
	"Gopal, Vinodh" <vinodh.gopal@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 26, 2024 at 11:08=E2=80=AFPM Sridhar, Kanchana P
<kanchana.p.sridhar@intel.com> wrote:
>
> > Internally, we often see 1-3 or 1-4 saving ratio (or even more).
>
> Agree with this as well. In our experiments with other workloads, we
> typically see much higher ratios.
>
> >
> > Probably does not explain everything, but worth double checking -
> > could you check with zstd to see if the ratio improves.
>
> Sure. I gathered ratio and compressed memory footprint data today with
> 64K mTHP, the 4G SSD swapfile and different zswap compressors.
>
>  This patch-series and no zswap charging, 64K mTHP:
> -------------------------------------------------------------------------=
--
>                        Total         Total     Average      Average   Com=
p
>                   compressed   compression  compressed  compression  rati=
o
>                       length       latency      length      latency
>                        bytes  milliseconds       bytes  nanoseconds
> -------------------------------------------------------------------------=
--
> SSD (no zswap) 1,362,296,832       887,861
> lz4            2,610,657,430        55,984       2,055      44,065    1.9=
9
> zstd             729,129,528        50,986         565      39,510    7.2=
5
> deflate-iaa    1,286,533,438        44,785       1,415      49,252    2.8=
9
> -------------------------------------------------------------------------=
--
>
> zstd does very well on ratio, as expected.

Wait. So zstd is displaying 7-to-1 compression ratio? And has *lower*
average latency?

Why are we running benchmark on lz4 again? Sure there is no free lunch
and no compressor that works well on all kind of data, but lz4's
performance here is so bad that it's borderline justifiable to
disable/bypass zswap with this kind of compresison ratio...

Can I ask you to run benchmarking on zstd from now on?

>
> >
> > >
> > >
> > >  Experiment 3 - 4K folios swap characteristics SSD vs. ZSWAP:
> > >  ------------------------------------------------------------
> > >
> > >  I wanted to take a step back and understand how the mainline v6.11-r=
c3
> > >  handles 4K folios when swapped out to SSD (CONFIG_ZSWAP is off) and
> > when
> > >  swapped out to ZSWAP. Interestingly, higher swapout activity is obse=
rved
> > >  with 4K folios and v6.11-rc3 (with the debug change to not charge zs=
wap to
> > >  cgroup).
> > >
> > >  v6.11-rc3 with no zswap charge, only 4K folios, no (m)THP:
> > >
> > >  -------------------------------------------------------------
> > >  SSD (CONFIG_ZSWAP is OFF)       ZSWAP          lz4    lzo-rle
> > >  -------------------------------------------------------------
> > >  cgroup memory.events:           cgroup memory.events:
> > >
> > >  low                 0           low              0          0
> > >  high            5,068           high       321,923    375,116
> > >  max                 0           max              0          0
> > >  oom                 0           oom              0          0
> > >  oom_kill            0           oom_kill         0          0
> > >  oom_group_kill      0           oom_group_kill   0          0
> > >  -------------------------------------------------------------
> > >
> > >  SSD (CONFIG_ZSWAP is OFF):
> > >  --------------------------
> > >  pswpout            415,709
> > >  sys time (sec)      301.02
> > >  Throughput KB/s    155,970
> > >  memcg_high events    5,068
> > >  --------------------------
> > >
> > >
> > >  ZSWAP                  lz4         lz4         lz4     lzo-rle
> > >  --------------------------------------------------------------
> > >  zswpout          1,598,550   1,515,151   1,449,432   1,493,917
> > >  sys time (sec)      889.36      481.21      581.22      635.75
> > >  Throughput KB/s     35,176      14,765      20,253      21,407
> > >  memcg_high events  321,923     412,733     369,976     375,116
> > >  --------------------------------------------------------------
> > >
> > >  This shows that there is a performance regression of -60% to -195% w=
ith
> > >  zswap as compared to SSD with 4K folios. The higher swapout activity=
 with
> > >  zswap is seen here too (i.e., this doesn't appear to be mTHP-specifi=
c).
> > >
> > >  I verified this to be the case even with the v6.7 kernel, which also
> > >  showed a 2.3X throughput improvement when we don't charge zswap:
> > >
> > >  ZSWAP lz4                 v6.7      v6.7 with no cgroup zswap charge
> > >  --------------------------------------------------------------------
> > >  zswpout              1,419,802       1,398,620
> > >  sys time (sec)           535.4          613.41
> >
> > systime increases without zswap cgroup charging? That's strange...
>
> Additional data gathered with v6.11-rc3 (listed below) based on your sugg=
estion
> to investigate potential swap.high breaches should hopefully provide some
> explanation.
>
> >
> > >  Throughput KB/s          8,671          20,045
> > >  memcg_high events      574,046         451,859
> >
> > So, on 4k folio setup, even without cgroup charge, we are still seeing:
> >
> > 1. More zswpout (than observed in SSD)
> > 2. 40-50% worse latency - in fact it is worse without zswap cgroup char=
ging.
> > 3. 100 times the amount of memcg_high events? This is perhaps the
> > *strangest* to me. You're already removing zswap cgroup charging, then
> > where does this comes from? How can we have memory.high violation when
> > zswap does *not* contribute to memory usage?
> >
> > Is this due to swap limit charging? Do you have a cgroup swap limit?
> >
> > mem_high =3D page_counter_read(&memcg->memory) >
> >            READ_ONCE(memcg->memory.high);
> > swap_high =3D page_counter_read(&memcg->swap) >
> >            READ_ONCE(memcg->swap.high);
> > [...]
> >
> > if (mem_high || swap_high) {
> >     /*
> >     * The allocating tasks in this cgroup will need to do
> >     * reclaim or be throttled to prevent further growth
> >     * of the memory or swap footprints.
> >     *
> >     * Target some best-effort fairness between the tasks,
> >     * and distribute reclaim work and delay penalties
> >     * based on how much each task is actually allocating.
> >     */
> >     current->memcg_nr_pages_over_high +=3D batch;
> >     set_notify_resume(current);
> >     break;
> > }
> >
>
> I don't have a swap.high limit set on the cgroup; it is set to "max".
>
> I ran experiments with v6.11-rc3, no zswap charging, 4K folios and differ=
ent
> zswap compressors to verify if swap.high is breached with the 4G SSD swap=
file.
>
>  SSD (CONFIG_ZSWAP is OFF):
>
>                                 SSD          SSD          SSD
>  ------------------------------------------------------------
>  pswpout                    415,709    1,032,170      636,582
>  sys time (sec)              301.02       328.15       306.98
>  Throughput KB/s            155,970       89,621      122,219
>  memcg_high events            5,068       15,072        8,344
>  memcg_swap_high events           0            0            0
>  memcg_swap_fail events           0            0            0
>  ------------------------------------------------------------
>
>  ZSWAP                               zstd         zstd       zstd
>  ----------------------------------------------------------------
>  zswpout                        1,391,524    1,382,965  1,417,307
>  sys time (sec)                    474.68       568.24     489.80
>  Throughput KB/s                   26,099       23,404    111,115
>  memcg_high events                335,112      340,335    162,260
>  memcg_swap_high events                 0            0          0
>  memcg_swap_fail events         1,226,899    5,742,153
>   (mem_cgroup_try_charge_swap)
>  memcg_memory_stat_pgactivate   1,259,547
>   (shrink_folio_list)
>  ----------------------------------------------------------------
>
>  ZSWAP                      lzo-rle      lzo-rle     lzo-rle
>  -----------------------------------------------------------
>  zswpout                  1,493,917    1,363,040   1,428,133
>  sys time (sec)              635.75       498.63      484.65
>  Throughput KB/s             21,407       23,827      20,237
>  memcg_high events          375,116      352,814     373,667
>  memcg_swap_high events           0            0           0
>  memcg_swap_fail events     715,211
>  -----------------------------------------------------------
>
>  ZSWAP                         lz4         lz4        lz4          lz4
>  ---------------------------------------------------------------------
>  zswpout                 1,378,781   1,598,550   1,515,151   1,449,432
>  sys time (sec)             495.45      889.36      481.21      581.22
>  Throughput KB/s            26,248      35,176      14,765      20,253
>  memcg_high events         347,209     321,923     412,733     369,976
>  memcg_swap_high events          0           0           0           0
>  memcg_swap_fail events    580,103           0
>  ---------------------------------------------------------------------
>
>  ZSWAP                  deflate-iaa   deflate-iaa    deflate-iaa
>  ----------------------------------------------------------------
>  zswpout                    380,471     1,440,902      1,397,965
>  sys time (sec)              329.06        570.77         467.41
>  Throughput KB/s            283,867        28,403        190,600
>  memcg_high events            5,551       422,831         28,154
>  memcg_swap_high events           0             0              0
>  memcg_swap_fail events           0     2,686,758        438,562
>  ----------------------------------------------------------------

Why are there 3 columns for each of the compressors? Is this different
runs of the same workload?

And why do some columns have missing cells?

>
> There are no swap.high memcg events recorded in any of the SSD/zswap
>  experiments. However, I do see significant number of memcg_swap_fail
>  events in some of the zswap runs, for all 3 compressors. This is not
>  consistent, because there are some runs with 0 memcg_swap_fail for all
>  compressors.
>
>  There is a possible co-relation between memcg_swap_fail events
>  (/sys/fs/cgroup/test/memory.swap.events) and the high # of memcg_high
>  events. The root-cause appears to be that there are no available swap
>  slots, memcg_swap_fail is incremented, add_to_swap() fails in
>  shrink_folio_list(), followed by "activate_locked:" for the folio.
>  The folio re-activation is recorded in cgroup memory.stat pgactivate
>  events. The failure to swap out folios due to lack of swap slots could
>  contribute towards memory.high breaches.

Yeah FWIW, that was gonna be my first suggestion. This swapfile size
is wayyyy too small...

But that said, the link is not clear to me at all. The only thing I
can think of is lz4's performance sucks so bad that it's not saving
enough memory, leading to regression. And since it's still taking up
swap slot, we cannot use swap either?

>
>  However, this is probably not the only cause for either the high # of
>  memory.high breaches or the over-reclaim with zswap, as seen in the lz4
>  data where the memory.high is significant even in cases where there are =
no
>  memcg_swap_fails.
>
> Some observations/questions based on the above 4K folios swapout data:
>
> 1) There are more memcg_high events as the swapout latency reduces
>    (i.e. faster swap-write path). This is even without charging zswap
>    utilization to the cgroup.

This is still inexplicable to me. If we are not charging zswap usage,
we shouldn't even be triggering the reclaim_high() path, no?

I'm curious - can you use bpftrace to tracks where/when reclaim_high
is being called?

>
> 2) There appears to be a direct co-relation between higher # of
>    memcg_swap_fail events, and an increase in memcg_high breaches and
>    reduction in usemem throughput. This combined with the observation in
>    (1) suggests that with a faster compressor, we need more swap slots,
>    that increases the probability of running out of swap slots with the 4=
G
>    SSD backing device.
>
> 3) Could the data shared earlier on reduction in memcg_high breaches with
>    64K mTHP swapout provide some more clues, if we agree with (1) and (2)=
:
>
>    "Interestingly, the # of memcg_high events reduces significantly with =
64K
>    mTHP as compared to the above 4K memcg_high events data, when tested
>    with v4 and no zswap charge: 3,069 (SSD-mTHP) and 19,656 (ZSWAP-mTHP).=
"
>
> 4) In the case of each zswap compressor, there are some runs that go
>    through with 0 memcg_swap_fail events. These runs generally have bette=
r
>    fewer memcg_high breaches and better sys time/throughput.
>
> 5) For a given swap setup, there is some amount of variance in
>    sys time for this workload.
>
> 6) All this suggests that the primary root cause is the concurrency setup=
,
>    where there could be randomness between runs as to the # of processes
>    that observe the memory.high breach due to other factors such as
>    availability of swap slots for alloc.
>
> To summarize, I believe the root-cause is the 4G SSD swapfile resulting i=
n
> running out of swap slots, and anomalous behavior with over-reclaim when =
70
> concurrent processes are working with the 60G memory limit while trying t=
o
> allocate 1G each; with randomness in processes reacting to the breach.
>
> The cgroup zswap charging exacerbates this situation, but is not a proble=
m
> in and of itself.
>
> Nhat, as you pointed out, this is somewhat of an unrealistic scenario tha=
t
> doesn't seem to indicate any specific problems to be solved, other than t=
he
> temporary cgroup zswap double-charging.
>
> Would it be fair to evaluate this patch-series based on a more realistic
> swapfile configuration based on 176G ZRAM, for which I had shared the dat=
a
> in v2? There weren't any problems with swap slots availability or any
> anomalies that I can think of with this setup, other than the fact that t=
he
> "Before" and "After" sys times could not be directly compared for 2 key
> reasons:
>
>  - ZRAM compressed data is not charged to the cgroup, similar to SSD.
>  - ZSWAP compressed data is charged to the cgroup.

Yeah that's a bit unfair still. Wild idea, but what about we compare
SSD without zswap (or SSD with zswap, but without this patch series so
that mTHP are not zswapped) v.s zswap-on-zram (i.e with a backing
swapfile on zram block device).

It is stupid, I know. But let's take advantage of the fact that zram
is not charged to cgroup, pretending that its memory foot print is
empty?

I don't know how zram works though, so my apologies if it's a stupid
suggestion :)

