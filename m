Return-Path: <linux-kernel+bounces-372108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F6119A4485
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 19:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A27F2289DBD
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 17:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8CDF204009;
	Fri, 18 Oct 2024 17:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PvvnSOzd"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097C0257D
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 17:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729272084; cv=none; b=F1J4IUxrvJdZOECus0lgQheBvY+TFbMyskM724MgZxJAD4HsPQ0gxCyfJC4+7eFGn/PhGlnF6PyWkcJFbkxR4+UgCRFZ5+CiZswoJggNT+k/yDQwLDODv0ik/FsquaqxOKMI/c+Cbt7QPAQGk5dUPzP9GDlj+IAxFCf7xe0LRqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729272084; c=relaxed/simple;
	bh=wo1d/q16W+PPcajFaUmDLAeeB3/SzRNIa1peoxxnJRI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AWkv+cRtCDr9xs+Npvz6b+mKTsUbTOC0D+NFKhjIQj+5kFA1rUkBoFy4pC94SmQ+wcwZfVRxdZq8gkLOHDajjcP1XzrLVls2Kwln4Ua2sA9mKHf1MEpgz2Yzpf0EJUD6dyU/enmXs4RnxKwnZ1O2N606d5s6VUlIexBx/HlCgrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PvvnSOzd; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6cb82317809so15398286d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 10:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729272081; x=1729876881; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nQVAcZ2nJlYpO9S9j+dRNzkbpkPjGUWLEdeCXu7RkWI=;
        b=PvvnSOzdyZtH3QyrQVtRFWkCmjpmKKpiFaCC2BuANWQR+tNUoqWn2TqbZGDkZri86v
         epHK/u6aFZG2q7sDwY/q8Iey/b2VEs3u/bYl8+qqBxMFaAo3sGtPyv3Rq0KYTA2S2oMX
         Bs6zkb2D+ZU6Ntd1AMl0k6EO5VbbM9Fq7YvBr81Yc/DxECQCC81XE8Y1J2RYkek0eAZ8
         uY7M4Ax16OgjEbiPQiuSULToorkw9a5E1WgJb5C9dQMsm0Ez+movzjAwc1E4P7nsKHeX
         FmaUA0VgZfXT42mhgmtN2ackOcKsIKSk/vSALJzHUUKfV0fIAPlKGT8ymq4VLbC98AtV
         /ZFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729272081; x=1729876881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nQVAcZ2nJlYpO9S9j+dRNzkbpkPjGUWLEdeCXu7RkWI=;
        b=vysTrP7szGOC4OWF5bZAjC3I/5vwX1+PB1cIgZMLsFcaO5i2Xuesv0cisElFYczxxA
         Am40qK03RdsaZYQZkPQOaTqKHOQncaGFOGn/oRTqV2ZYLY14hSVRhlj7YN3Jznygs7Yc
         gGKhWF69DcfCpWXrWR3G+geFHOhEAFiARHeqfxSTnfpkXwnQoRsNVGC50KkWnoN9/R6z
         1sdjSRGn83kpQ579bftyInMmzVpB+GOO4UJg3XziS6AusMLBdn5jNdIbk9QpTgzvtQrk
         69k1pVcy8Mxk0qBcuRO0XnYu4L3v0jYt1xOKmKS0f91aR6d7gbp1RhPcIqMTR77Lim1v
         SrYw==
X-Forwarded-Encrypted: i=1; AJvYcCX7X5vaegDcwONhN5s05h4vFOm06GIN9vw3Q4szyyvCEyR+833dhv0ECrzOhgRBKK7QK/yB32G1nv0PuS0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1Jq24S8AjUO5ATyls/rxrvZxS4A1QlgYpeRu/lmjAOw9oSabm
	lTCros0sHwC0PCec5oxt7wkSzpFedDEl0TeShnmvbfnNRTSKbusEEPNY51w+Gw8axcoTM8XUAXa
	tmapssnuAbXfND91XsW/VODm8b4g=
X-Google-Smtp-Source: AGHT+IGb3M/z9O6DLeA4VaQDCxdnsZS6tG6uEbi4RvdZyUwvzcHQVFG3rE2WBH5VTcH9QSYUv8S0sDOsC8Wkwz7Rw/0=
X-Received: by 2002:a05:6214:3901:b0:6cb:c9bb:b040 with SMTP id
 6a1803df08f44-6cde14c5adamr46942506d6.3.1729272080648; Fri, 18 Oct 2024
 10:21:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018064805.336490-1-kanchana.p.sridhar@intel.com>
 <20241018064805.336490-7-kanchana.p.sridhar@intel.com> <71bcbd3f-a8bd-4014-aabe-081006cc62f8@redhat.com>
 <169e5cb6-701a-474c-a703-60daee8b4d3f@gmail.com>
In-Reply-To: <169e5cb6-701a-474c-a703-60daee8b4d3f@gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Fri, 18 Oct 2024 10:21:09 -0700
Message-ID: <CAKEwX=NVUkjDgxvsr1g3o_2dWGjEF91_+q==MQE8VQc8o5vwtQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 6/7] mm: do_swap_page() calls swapin_readahead()
 zswap load batching interface.
To: Usama Arif <usamaarif642@gmail.com>
Cc: David Hildenbrand <david@redhat.com>, Kanchana P Sridhar <kanchana.p.sridhar@intel.com>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, hannes@cmpxchg.org, 
	yosryahmed@google.com, chengming.zhou@linux.dev, ryan.roberts@arm.com, 
	ying.huang@intel.com, 21cnbao@gmail.com, akpm@linux-foundation.org, 
	hughd@google.com, willy@infradead.org, bfoster@redhat.com, 
	dchinner@redhat.com, chrisl@kernel.org, wajdi.k.feghali@intel.com, 
	vinodh.gopal@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 18, 2024 at 4:04=E2=80=AFAM Usama Arif <usamaarif642@gmail.com>=
 wrote:
>
>
> On 18/10/2024 08:26, David Hildenbrand wrote:
> > On 18.10.24 08:48, Kanchana P Sridhar wrote:
> >> This patch invokes the swapin_readahead() based batching interface to
> >> prefetch a batch of 4K folios for zswap load with batch decompressions
> >> in parallel using IAA hardware. swapin_readahead() prefetches folios b=
ased
> >> on vm.page-cluster and the usefulness of prior prefetches to the
> >> workload. As folios are created in the swapcache and the readahead cod=
e
> >> calls swap_read_folio() with a "zswap_batch" and a "non_zswap_batch", =
the
> >> respective folio_batches get populated with the folios to be read.
> >>
> >> Finally, the swapin_readahead() procedures will call the newly added
> >> process_ra_batch_of_same_type() which:
> >>
> >>   1) Reads all the non_zswap_batch folios sequentially by calling
> >>      swap_read_folio().
> >>   2) Calls swap_read_zswap_batch_unplug() with the zswap_batch which c=
alls
> >>      zswap_finish_load_batch() that finally decompresses each
> >>      SWAP_CRYPTO_SUB_BATCH_SIZE sub-batch (i.e. upto 8 pages in a pref=
etch
> >>      batch of say, 32 folios) in parallel with IAA.
> >>
> >> Within do_swap_page(), we try to benefit from batch decompressions in =
both
> >> these scenarios:
> >>
> >>   1) single-mapped, SWP_SYNCHRONOUS_IO:
> >>        We call swapin_readahead() with "single_mapped_path =3D true". =
This is
> >>        done only in the !zswap_never_enabled() case.
> >>   2) Shared and/or non-SWP_SYNCHRONOUS_IO folios:
> >>        We call swapin_readahead() with "single_mapped_path =3D false".
> >>
> >> This will place folios in the swapcache: a design choice that handles =
cases
> >> where a folio that is "single-mapped" in process 1 could be prefetched=
 in
> >> process 2; and handles highly contended server scenarios with stabilit=
y.
> >> There are checks added at the end of do_swap_page(), after the folio h=
as
> >> been successfully loaded, to detect if the single-mapped swapcache fol=
io is
> >> still single-mapped, and if so, folio_free_swap() is called on the fol=
io.
> >>
> >> Within the swapin_readahead() functions, if single_mapped_path is true=
, and
> >> either the platform does not have IAA, or, if the platform has IAA and=
 the
> >> user selects a software compressor for zswap (details of sysfs knob
> >> follow), readahead/batching are skipped and the folio is loaded using
> >> zswap_load().
> >>
> >> A new swap parameter "singlemapped_ra_enabled" (false by default) is a=
dded
> >> for platforms that have IAA, zswap_load_batching_enabled() is true, an=
d we
> >> want to give the user the option to run experiments with IAA and with
> >> software compressors for zswap (swap device is SWP_SYNCHRONOUS_IO):
> >>
> >> For IAA:
> >>   echo true > /sys/kernel/mm/swap/singlemapped_ra_enabled
> >>
> >> For software compressors:
> >>   echo false > /sys/kernel/mm/swap/singlemapped_ra_enabled
> >>
> >> If "singlemapped_ra_enabled" is set to false, swapin_readahead() will =
skip
> >> prefetching folios in the "single-mapped SWP_SYNCHRONOUS_IO" do_swap_p=
age()
> >> path.
> >>
> >> Thanks Ying Huang for the really helpful brainstorming discussions on =
the
> >> swap_read_folio() plug design.
> >>
> >> Suggested-by: Ying Huang <ying.huang@intel.com>
> >> Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
> >> ---
> >>   mm/memory.c     | 187 +++++++++++++++++++++++++++++++++++++---------=
--
> >>   mm/shmem.c      |   2 +-
> >>   mm/swap.h       |  12 ++--
> >>   mm/swap_state.c | 157 ++++++++++++++++++++++++++++++++++++----
> >>   mm/swapfile.c   |   2 +-
> >>   5 files changed, 299 insertions(+), 61 deletions(-)
> >>
> >> diff --git a/mm/memory.c b/mm/memory.c
> >> index b5745b9ffdf7..9655b85fc243 100644
> >> --- a/mm/memory.c
> >> +++ b/mm/memory.c
> >> @@ -3924,6 +3924,42 @@ static vm_fault_t remove_device_exclusive_entry=
(struct vm_fault *vmf)
> >>       return 0;
> >>   }
> >>   +/*
> >> + * swapin readahead based batching interface for zswap batched loads =
using IAA:
> >> + *
> >> + * Should only be called for and if the faulting swap entry in do_swa=
p_page
> >> + * is single-mapped and SWP_SYNCHRONOUS_IO.
> >> + *
> >> + * Detect if the folio is in the swapcache, is still mapped to only t=
his
> >> + * process, and further, there are no additional references to this f=
olio
> >> + * (for e.g. if another process simultaneously readahead this swap en=
try
> >> + * while this process was handling the page-fault, and got a pointer =
to the
> >> + * folio allocated by this process in the swapcache), besides the ref=
erences
> >> + * that were obtained within __read_swap_cache_async() by this proces=
s that is
> >> + * faulting in this single-mapped swap entry.
> >> + */
> >
> > How is this supposed to work for large folios?
> >
>
> Hi,
>
> I was looking at zswapin large folio support and have posted a RFC in [1]=
.
> I got bogged down with some prod stuff, so wasn't able to send it earlier=
.
>
> It looks quite different, and I think simpler from this series, so might =
be
> a good comparison.
>
> [1] https://lore.kernel.org/all/20241018105026.2521366-1-usamaarif642@gma=
il.com/
>
> Thanks,
> Usama

I agree.

I think the lower hanging fruit here is to build upon Usama's patch.
Kanchana, do you think we can just use the new batch decompressing
infrastructure, and apply it to Usama's large folio zswap loading?

I'm not denying the readahead idea outright, but that seems much more
complicated. There are questions regarding the benefits of
readahead-ing when apply to zswap in the first place - IIUC, zram
circumvents that logic in several cases, and zswap shares many
characteristics with zram (fast, synchronous compression devices).

So let's reap the low hanging fruits first, get the wins as well as
stress test the new infrastructure. Then we can discuss the readahead
idea later?

