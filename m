Return-Path: <linux-kernel+bounces-301649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40DCC95F39F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 16:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAA74285455
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 14:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAB13189500;
	Mon, 26 Aug 2024 14:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CmD7ubdH"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA38018891B
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 14:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724681564; cv=none; b=BrtwbpHlwFwmk9Sc5rdRNbSXxKVi7AqBxuxHlnnXG66hX7XD65qwf8JFPHSUK0MeUtCN6836Xis2hERa1ns6IohM4f1wlYXBC+QbznMBwFBI9eZ7tc6a8SvXQ2ii4RMY25GivpCqLXOkc5PP4qNd62skBvqVlqz7iQCM+Lrljmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724681564; c=relaxed/simple;
	bh=hwTJibkKpYI3nczDXzczioM7VYsF168NdTMi/uV4Lm0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Wn3jQ0ob0PEqJhUI1snTmfR+TvLpUJMy03uJRrpn1Rzl+u6cIXijzLxKOIvGJbvk+kU+ssZWCdKYbnJxcOWQxhGq9FlhabszNXtac0TKMvzQ0l054U+JHMQ01L1pDiazizwmP3+7xApl3F0oZyLlI8uQhWnlwYiU5QycgDR13PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CmD7ubdH; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6bf6beda038so24302146d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 07:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724681561; x=1725286361; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HAdS38Dnpv3232aSEHTdTlxB0uTzfx/7U0MqX+bHCY8=;
        b=CmD7ubdHKbbCK/lPoNc9G5T+jo8ScaptujYWvHKgjfYENykc3GEL3wiOqNvQQtHSeU
         2kBjdGEyND8s2zyKVVPOwVMfFdWRgWBbAW2pY7ON/uSzFU/S4g9yV6c0o/scYYuwGvxD
         RESboL/WRgfbi6L0Z5MGZVnQanhHY9k5dI2KKbgQldjW9oTRDaNNEmPMfpQY4Zrst9B6
         DcUnJ5yzqBgdrkC4oLJc+SmWQmKLGUHN20h5Z31AkW6J+2eJxaHkTaRrojH9YSEdYJPg
         teKek9TGHW261HBX5mZVgQjgDfmVUcbDTHx9E3chw9ONoFed7m3uuHOAiEdYc07qWDRc
         Dv2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724681561; x=1725286361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HAdS38Dnpv3232aSEHTdTlxB0uTzfx/7U0MqX+bHCY8=;
        b=qzjt+B3oyEeOql7VaU8Ewfj1JVLsZ9kFShgxtUWtSbuu4ncBrBvQRhi56Wto9tdlyo
         OhUI0jS6QIt8WYcDwZw9bWcuZXinBEuQacuudYiTqbchRCFAwyRVWHaIZY8fMf7uqqFl
         tdKiW9quRll9OcfKwmrzGK8J85BoQ7FY+y2K/o5eKSSJqddnjrsh3iC4Uv5DH04Z822w
         twYLGBdsYOy2BDAmkpCW4Zw5BBoZ87EuR9ugYAUzr+HCzRJ2kchWYzOfi4LrqQ99Lhsq
         o5VmeiNse8crzvMN7Z8P7E5Oo23m3N0vykotIGmoDPsWiCr6kKhk5a+txEsvweyfNcms
         ALqw==
X-Gm-Message-State: AOJu0YwzwtNfm7AUYB7xQdy0bjZp3zywNTv5uAUjCi69PxPt6gtWFu1q
	anv9pTAfZhsyccOtqPtrEP56xUGiOO04DiKLtbJmXmB7AGrjtJ7FkGDq0Oqbg4F9JmKJ52QWLOC
	34317HaGgZGNZHT88BhXM282Vo+k=
X-Google-Smtp-Source: AGHT+IG2n6stkY8pTfoEO4LLm9pVEwG2PYvjwRib/R4Qo+co3ytx8Flifhcb4xQb0V5Y8iDzrN4ftzqSwlxm7vumKdc=
X-Received: by 2002:a05:6214:568b:b0:6bf:8099:8d4 with SMTP id
 6a1803df08f44-6c16dc63aeemr115555836d6.21.1724681560979; Mon, 26 Aug 2024
 07:12:40 -0700 (PDT)
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
In-Reply-To: <SJ0PR11MB567801EE747E2810EF183C73C9892@SJ0PR11MB5678.namprd11.prod.outlook.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Mon, 26 Aug 2024 07:12:28 -0700
Message-ID: <CAKEwX=PYv4Cn_a7WSnbUyhwSBO61xoDPSexXxS0uwwxu5P6XLw@mail.gmail.com>
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

On Fri, Aug 23, 2024 at 11:21=E2=80=AFPM Sridhar, Kanchana P
<kanchana.p.sridhar@intel.com> wrote:
>
> Hi Nhat,
>
>
> I started out with 2 main hypotheses to explain why zswap incurs more
> reclaim wrt SSD:
>
> 1) The cgroup zswap charge, that hastens the memory.high limit to be
>    breached, and adds to the reclaim being triggered in
>    mem_cgroup_handle_over_high().
>
> 2) Does a faster reclaim path somehow cause less allocation stalls; there=
by
>    causing more breaches of memory.high, hence more reclaim -- and does t=
his
>    cycle repeat, potentially leading to higher swapout activity with zswa=
p?

By faster reclaim path, do you mean zswap has a lower reclaim latency?

>
> I focused on gathering data with lz4 for this debug, under the reasonable
> assumption that results with deflate-iaa will be better. Once we figure o=
ut
> an overall direction on next steps, I will publish results with zswap lz4=
,
> deflate-iaa, etc.
>
> All experiments except "Exp 1.A" are run with
> usemem --init-time -w -O -n 70 1g.
>
> General settings for all data presented in this patch-series:
>
> vm.swappiness =3D 100
> zswap shrinker_enabled =3D N
>
>  Experiment 1 - impact of not doing cgroup zswap charge:
>  -------------------------------------------------------
>
> I wanted to first understand by how much we improve without the cgroup
> zswap charge. I commented out both, the calls to obj_cgroup_charge_zswap(=
)
> and obj_cgroup_uncharge_zswap() in zswap.c in my patch-set.
> We improve throughput by quite a bit with this change, and are now better
> than mTHP getting swapped out to SSD. We have also slightly improved on t=
he
> sys time, though this is still a regression as compared to SSD. If you
> recall, we were worse on throughput and sys time with v4.

I'm not 100% sure about the validity this pair of experiments.

The thing is, you cannot ignore zswap's memory footprint altogether.
That's the whole point of the trade-off. It's probably gigabytes worth
of unaccounted memory usage - I see that your SSD size is 4G, and
since compression ratio is less than 2, that's potentially 2G worth of
memory give or take you are not charging to the cgroup, which can
altogether alter the memory pressure and reclaim dynamics.

The zswap charging itself is not the problem - that's fair and
healthy. It might be the overreaction by the memory reclaim subsystem
that seems anomalous?

>
> Averages over 3 runs are summarized in each case.
>
>  Exp 1.A: usemem -n 1 58g:
>  -------------------------
>
>  64KB mTHP (cgroup memory.high set to 60G):
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>                 SSD mTHP    zswap mTHP v4   zswap mTHP no_charge
>  ----------------------------------------------------------------
>  pswpout          586,352                0                      0
>  zswpout            1,005        1,042,963                587,181
>  ----------------------------------------------------------------
>  Total swapout    587,357        1,042,963                587,181
>  ----------------------------------------------------------------
>
> Without the zswap charge to cgroup, the total swapout activity for
> zswap-mTHP is on par with that of SSD-mTHP for the single process case.
>
>
>  Exp 1.B: usemem -n 70 1g:
>  -------------------------
>  v4 results with cgroup zswap charge:
>  ------------------------------------
>
>  64KB mTHP (cgroup memory.high set to 60G):
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   ------------------------------------------------------------------
>  |                    |                   |            |            |
>  |Kernel              | mTHP SWAP-OUT     | Throughput |     Change |
>  |                    |                   |       KB/s |            |
>  |--------------------|-------------------|------------|------------|
>  |v6.11-rc3 mainline  | SSD               |    335,346 |   Baseline |
>  |zswap-mTHP-Store    | ZSWAP lz4         |    271,558 |       -19% |
>  |------------------------------------------------------------------|
>  |                    |                   |            |            |
>  |Kernel              | mTHP SWAP-OUT     |   Sys time |     Change |
>  |                    |                   |        sec |            |
>  |--------------------|-------------------|------------|------------|
>  |v6.11-rc3 mainline  | SSD               |      91.37 |   Baseline |
>  |zswap-mTHP=3DStore    | ZSWAP lz4         |     265.43 |      -191% |
>   ------------------------------------------------------------------
>
>   -----------------------------------------------------------------------
>  | VMSTATS, mTHP ZSWAP/SSD stats|  v6.11-rc3 |  zswap-mTHP |  zswap-mTHP =
|
>  |                              |   mainline |       Store |       Store =
|
>  |                              |            |         lz4 | deflate-iaa =
|
>  |-----------------------------------------------------------------------=
|
>  | pswpout                      |    174,432 |           0 |           0 =
|
>  | zswpout                      |      1,501 |   1,491,654 |   1,398,805 =
|
>  |-----------------------------------------------------------------------=
|
>  | hugepages-64kB/stats/zswpout |            |      63,200 |      63,244 =
|
>  |-----------------------------------------------------------------------=
|
>  | hugepages-64kB/stats/swpout  |     10,902 |           0 |           0 =
|
>   -----------------------------------------------------------------------
>
>  Debug results without cgroup zswap charge in both, "Before" and "After":
>  ------------------------------------------------------------------------
>
>  64KB mTHP (cgroup memory.high set to 60G):
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>   ------------------------------------------------------------------
>  |                    |                   |            |            |
>  |Kernel              | mTHP SWAP-OUT     | Throughput |     Change |
>  |                    |                   |       KB/s |            |
>  |--------------------|-------------------|------------|------------|
>  |v6.11-rc3 mainline  | SSD               |    300,565 |   Baseline |
>  |zswap-mTHP-Store    | ZSWAP lz4         |    420,125 |        40% |
>  |------------------------------------------------------------------|
>  |                    |                   |            |            |
>  |Kernel              | mTHP SWAP-OUT     |   Sys time |     Change |
>  |                    |                   |        sec |            |
>  |--------------------|-------------------|------------|------------|
>  |v6.11-rc3 mainline  | SSD               |      90.76 |   Baseline |
>  |zswap-mTHP=3DStore    | ZSWAP lz4         |     213.09 |      -135% |
>   ------------------------------------------------------------------
>
>   ---------------------------------------------------------
>  | VMSTATS, mTHP ZSWAP/SSD stats|  v6.11-rc3 |  zswap-mTHP |
>  |                              |   mainline |       Store |
>  |                              |            |         lz4 |
>  |----------------------------------------------------------
>  | pswpout                      |    330,640 |           0 |
>  | zswpout                      |      1,527 |   1,384,725 |
>  |----------------------------------------------------------
>  | hugepages-64kB/stats/zswpout |            |      63,335 |
>  |----------------------------------------------------------
>  | hugepages-64kB/stats/swpout  |     18,242 |           0 |
>   ---------------------------------------------------------
>

Hmm, in the 70 processes case, it looks like we're still seeing
latency regression, and that same pattern of overreclaiming, even
without zswap cgroup charging?

That seems like a hint - concurrency exacerbates the problem?

>
> Based on these results, I kept the cgroup zswap charging commented out in
> subsequent debug steps, so as to not place zswap at a disadvantage when
> trying to determine further causes for hypothesis (1).
>
>
> Experiment 2 - swap latency/reclamation with 64K mTHP:
> ------------------------------------------------------
>
> Number of swap_writepage    Total swap_writepage  Average swap_writepage
>     calls from all cores      Latency (millisec)      Latency (microsec)
> -------------------------------------------------------------------------=
--
> SSD               21,373               165,434.9                   7,740
> zswap            344,109                55,446.8                     161
> -------------------------------------------------------------------------=
--
>
>
> Reclamation analysis: 64k mTHP swapout:
> ---------------------------------------
> "Before":
>   Total SSD compressed data size   =3D  1,362,296,832  bytes
>   Total SSD write IO latency       =3D        887,861  milliseconds
>
>   Average SSD compressed data size =3D      1,089,837  bytes
>   Average SSD write IO latency     =3D        710,289  microseconds
>
> "After":
>   Total ZSWAP compressed pool size =3D  2,610,657,430  bytes
>   Total ZSWAP compress latency     =3D         55,984  milliseconds
>
>   Average ZSWAP compress length    =3D          2,055  bytes
>   Average ZSWAP compress latency   =3D             44  microseconds
>
>   zswap-LZ4 mTHP compression ratio =3D  1.99
>   All moderately compressible pages. 0 zswap_store errors.
>   84% of pages compress to 2056 bytes.

Hmm this ratio isn't very good indeed - it is less than 2-to-1 memory savin=
g...

Internally, we often see 1-3 or 1-4 saving ratio (or even more).

Probably does not explain everything, but worth double checking -
could you check with zstd to see if the ratio improves.

>
>
>  Experiment 3 - 4K folios swap characteristics SSD vs. ZSWAP:
>  ------------------------------------------------------------
>
>  I wanted to take a step back and understand how the mainline v6.11-rc3
>  handles 4K folios when swapped out to SSD (CONFIG_ZSWAP is off) and when
>  swapped out to ZSWAP. Interestingly, higher swapout activity is observed
>  with 4K folios and v6.11-rc3 (with the debug change to not charge zswap =
to
>  cgroup).
>
>  v6.11-rc3 with no zswap charge, only 4K folios, no (m)THP:
>
>  -------------------------------------------------------------
>  SSD (CONFIG_ZSWAP is OFF)       ZSWAP          lz4    lzo-rle
>  -------------------------------------------------------------
>  cgroup memory.events:           cgroup memory.events:
>
>  low                 0           low              0          0
>  high            5,068           high       321,923    375,116
>  max                 0           max              0          0
>  oom                 0           oom              0          0
>  oom_kill            0           oom_kill         0          0
>  oom_group_kill      0           oom_group_kill   0          0
>  -------------------------------------------------------------
>
>  SSD (CONFIG_ZSWAP is OFF):
>  --------------------------
>  pswpout            415,709
>  sys time (sec)      301.02
>  Throughput KB/s    155,970
>  memcg_high events    5,068
>  --------------------------
>
>
>  ZSWAP                  lz4         lz4         lz4     lzo-rle
>  --------------------------------------------------------------
>  zswpout          1,598,550   1,515,151   1,449,432   1,493,917
>  sys time (sec)      889.36      481.21      581.22      635.75
>  Throughput KB/s     35,176      14,765      20,253      21,407
>  memcg_high events  321,923     412,733     369,976     375,116
>  --------------------------------------------------------------
>
>  This shows that there is a performance regression of -60% to -195% with
>  zswap as compared to SSD with 4K folios. The higher swapout activity wit=
h
>  zswap is seen here too (i.e., this doesn't appear to be mTHP-specific).
>
>  I verified this to be the case even with the v6.7 kernel, which also
>  showed a 2.3X throughput improvement when we don't charge zswap:
>
>  ZSWAP lz4                 v6.7      v6.7 with no cgroup zswap charge
>  --------------------------------------------------------------------
>  zswpout              1,419,802       1,398,620
>  sys time (sec)           535.4          613.41

systime increases without zswap cgroup charging? That's strange...

>  Throughput KB/s          8,671          20,045
>  memcg_high events      574,046         451,859

So, on 4k folio setup, even without cgroup charge, we are still seeing:

1. More zswpout (than observed in SSD)
2. 40-50% worse latency - in fact it is worse without zswap cgroup charging=
.
3. 100 times the amount of memcg_high events? This is perhaps the
*strangest* to me. You're already removing zswap cgroup charging, then
where does this comes from? How can we have memory.high violation when
zswap does *not* contribute to memory usage?

Is this due to swap limit charging? Do you have a cgroup swap limit?

mem_high =3D page_counter_read(&memcg->memory) >
           READ_ONCE(memcg->memory.high);
swap_high =3D page_counter_read(&memcg->swap) >
           READ_ONCE(memcg->swap.high);
[...]

if (mem_high || swap_high) {
    /*
    * The allocating tasks in this cgroup will need to do
    * reclaim or be throttled to prevent further growth
    * of the memory or swap footprints.
    *
    * Target some best-effort fairness between the tasks,
    * and distribute reclaim work and delay penalties
    * based on how much each task is actually allocating.
    */
    current->memcg_nr_pages_over_high +=3D batch;
    set_notify_resume(current);
    break;
}


>  --------------------------------------------------------------------
>
>
> Summary from the debug:
> -----------------------
> 1) Excess reclaim is exacerbated by zswap charge to cgroup. Without the
>    charge, reclaim is on par with SSD for mTHP in the single process
>    case. The multiple process excess reclaim seems to be most likely
>    resulting from over-reclaim done by the cores, in their respective cal=
ls
>    to mem_cgroup_handle_over_high().

Exarcebate, yes. I'm not 100% it's the sole or even the main cause.

You still see a degree of overreclaiming without zswap cgroup charging in:

1. 70 processes, with mTHP
2. 70 processes, with 4K folios.

>
> 2) The higher swapout activity with zswap as compared to SSD does not
>    appear to be specific to mTHP. Higher reclaim activity and sys time
>    regression with zswap (as compared to a setup where there is only SSD
>    configured as swap) exists with 4K pages as far back as v6.7.

Yeah I can believe that without mthp, the same-ish workload would
cause the same regression.

>
> 3) The debug indicates the hypothesis (2) is worth more investigation:
>    Does a faster reclaim path somehow cause less allocation stalls; there=
by
>    causing more breaches of memory.high, hence more reclaim -- and does t=
his
>    cycle repeat, potentially leading to higher swapout activity with zswa=
p?
>    Any advise on this being a possibility, and suggestions/pointers to
>    verify this, would be greatly appreciated.

Add stalls along the zswap path? :)

>
> 4) Interestingly, the # of memcg_high events reduces significantly with 6=
4K
>    mTHP as compared to the above 4K high events data, when tested with v4
>    and no zswap charge: 3,069 (SSD-mTHP) and 19,656 (ZSWAP-mTHP). This
>    potentially indicates something to do with allocation efficiency
>    countering the higher reclaim that seems to be caused by swapout
>    efficiency.
>
> 5) Nhat, Yosry: would it be possible for you to run the 4K folios
>    usemem -n 70 1g (with 60G memory.high) expmnt with 4G and some higher
>    value SSD configuration in your setup and say, v6.11-rc3. I would like
>    to rule out the memory constrained 4G SSD in my setup somehow skewing
>    the behavior of zswap vis-a-vis
>    allocation/memcg_handle_over_high/reclaim. I realize your time is
>    valuable, however I think an independent confirmation of what I have
>    been observing, would be really helpful for us to figure out potential
>    root-causes and solutions.

It might take awhile for me to set up your benchmark, but yeah 4G
swapfile seems small on a 64G host - of course it depends on the
workload, but this has a lot memory usage. In fact the total memory
usage (70G?) is slightly above memory.high + 4G swapfile - note that
this is exarcebated by, once again, zswap's less-than-100% memory
saving ratio.

>
> 6) I tried a small change in memcontrol.c::mem_cgroup_handle_over_high() =
to
>    break out of the loop if we have reclaimed a total of at least
>    "nr_pages":
>
>         nr_reclaimed =3D reclaim_high(memcg,
>                                     in_retry ? SWAP_CLUSTER_MAX : nr_page=
s,
>                                     gfp_mask);
>
> +       nr_reclaimed_total +=3D nr_reclaimed;
> +
> +       if (nr_reclaimed_total >=3D nr_pages)
> +               goto out;
>
>
>    This was only for debug purposes, and did seem to mitigate the higher
>    reclaim behavior for 4K folios:
>
>  ZSWAP                  lz4             lz4             lz4
>  ----------------------------------------------------------
>  zswpout          1,305,367       1,349,195       1,529,235
>  sys time (sec)      472.06          507.76          646.39
>  Throughput KB/s     55,144          21,811          88,310
>  memcg_high events  257,890         343,213         172,351
>  ----------------------------------------------------------
>
> On average, this change results in 17% improvement in sys time, 2.35X
> improvement in throughput and 30% fewer memcg_high events.
>
> I look forward to further inputs on next steps.
>
> Thanks,
> Kanchana
>
>
> >
> > Thanks for this analysis. I will debug this some more, so we can better
> > understand these results.
> >
> > Thanks,
> > Kanchana

