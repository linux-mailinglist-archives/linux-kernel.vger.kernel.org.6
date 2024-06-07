Return-Path: <linux-kernel+bounces-206562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A2E900B77
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 19:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD9F71C20CCD
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 17:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A752519ADB1;
	Fri,  7 Jun 2024 17:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e8WCn8YP"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDA833C0
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 17:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717782238; cv=none; b=cki7GCMkBtDJ1eftawPJ8lLtViOuyH4jExHMjdynED3voIfqyc2ygMjpt3iW0LpJJaE6xYmtKN8ru6DbZSNVsbQAuV2RaQmDiBK9E90uhlqESWBtYXZMjN54JAhwqNC9TauKSRFznOd13j52DUb6unoe3J4kXb2V0iX8HGgZjJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717782238; c=relaxed/simple;
	bh=ilmcCibTM0qvjPx6dOGaSD2VkqyTIFXoWUcc/ceWdF4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RBXoTXlsrwhrezCgKOFMojO+dn27+/7kYcKT+291+/rWZTSuA6NxKQNTYJ8io7ox7ot6AvF29a9XkBGaOIsbsACa6ubM2QA54OFUfaqsYsctqVgRgzvKgdzzt4VVI+DtOVCcadj7L6tvuSnDFOQjefYb2ZXXgQDtbB3gKeBogRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e8WCn8YP; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a68ee841138so315845666b.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 10:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717782235; x=1718387035; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GHxIdxIvUyWbgQDNhvFlgl5LM/lfPBj3QHKybJCJWNU=;
        b=e8WCn8YPhUJz7e7Ffv+5PUFiQ+1PPwEZ+0rR1QehMo/Fae6txXX1kaTYPX5xrblajD
         fFFN90vZk4IiHfRDnRgbPSvm32N5Yty4bm5MgiMQPBI7mWF+3oUB+x735KiWQ5/HLkJ1
         eb4goo7J68SuaHTrVe6L0h6JTYqpIkQkY02NZ7OL5jiTr/8zjvoDJCHGx68weNzKVIqJ
         +ILMALX/cnU1x9aRIB9L8ni6RwBMPLkcxgbahGckyjMbo9LvqV1DdxKXDhVorOVxGP+0
         d3MVhmxpgsVLt6YzlC42u0FWOj2BSBKWkZ0/+q5DK98qSe82OXyd/NBgfwWyYYTyBRHz
         aB+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717782235; x=1718387035;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GHxIdxIvUyWbgQDNhvFlgl5LM/lfPBj3QHKybJCJWNU=;
        b=etAzNC57iBTMeR7CB/I9EcW+dcReS5C9VfOndKGlDDZFmdlrpJGnilOkMuabi1bIE5
         pYGmzsbFtcrBsO8hSIw935p6tCzV0b6OKksajoeKIXIjCLc9ulRG/FSx1gpnnc28vZFx
         Gju9i4x224cp7E96dRZB66H69eycwyXO17OhMdOicHVxfOEnCbJUopa4Nt+q0X0Rzkf4
         nJ4LhybNRYjP7/VoETgHWcc+oa+Sb3FwS4h16mJ9Qc2i9UeyRrmC+6XTvjhLuFcI7N12
         ZkBxgTycm186RBu7Jf9d53At911EcagrKMCWgYslv1d7Q6DZ1MqEjHuUq133SYIybOTA
         qVcg==
X-Forwarded-Encrypted: i=1; AJvYcCVhkGAbiz0Hrbjc4P90lIdj3mknvRvB2Zf4AvdIaC9AS14OMy9+CtX14QxPHe3OI0SGEhmVLQcqKTfG8OSVeQhkmGP5fDN51Zs1Ybsz
X-Gm-Message-State: AOJu0YyG0XvbR7rEdQetXpO1do0Qwxc4X1aZg/vibvGABxY/U3YBuRoD
	jkNdBTxZR59YgYWOxGjTtxFL5ja0ufL6Scj3B7ncdpk4iWIyY0BL3D9XP4CJ/5YhcS8dOorYO8x
	Syv0jsYZBCHCkvP525hoAa9rwCmPCdN9Gz92YVfGNKRGhAVmWPHI+/ko=
X-Google-Smtp-Source: AGHT+IFmXnedXaVPyjmrFAOaHxx15wNLRbJ4QTjwP83kqQYCY1tghWoHbftW3ost19NsRKWJ9Ol51YXKoh5LO3SRtWI=
X-Received: by 2002:a17:906:fd85:b0:a69:edd:3332 with SMTP id
 a640c23a62f3a-a6cd5616814mr288461766b.12.1717782234660; Fri, 07 Jun 2024
 10:43:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606184818.1566920-1-yosryahmed@google.com>
 <84d78362-e75c-40c8-b6c2-56d5d5292aa7@redhat.com> <CAJD7tkZH9C21nx75W9Erun=oUvmad5ujmDyGYWRRHEwPCCizUw@mail.gmail.com>
 <7507d075-9f4d-4a9b-836c-1fbb2fbd2257@redhat.com> <CAGsJ_4w_dEyLsPhdJCtRMReXDD116p+U979Yk-8EBu=zx5FWgQ@mail.gmail.com>
 <CAJD7tkYnZCvwUSTAx-N-08b+mVF4yHEdDTbp9oqYrVQXX8M1Cw@mail.gmail.com>
 <CAGsJ_4wAYbofjg99iEr7cEAptH9Ve9WcrSXho8A-Sw54vb8Msw@mail.gmail.com> <9374758d-9f81-4e4f-8405-1f972234173e@redhat.com>
In-Reply-To: <9374758d-9f81-4e4f-8405-1f972234173e@redhat.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Fri, 7 Jun 2024 10:43:16 -0700
Message-ID: <CAJD7tkZBzSB_6pAZP0n0nq+W=J1XKQGFzZZLzPmSH0apwaqTNg@mail.gmail.com>
Subject: Re: [PATCH] mm: zswap: add VM_BUG_ON() if large folio swapin is attempted
To: David Hildenbrand <david@redhat.com>
Cc: Barry Song <21cnbao@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Chris Li <chrisl@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>, 
	Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 7, 2024 at 12:11=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 06.06.24 23:53, Barry Song wrote:
> > On Fri, Jun 7, 2024 at 9:37=E2=80=AFAM Yosry Ahmed <yosryahmed@google.c=
om> wrote:
> >>
> >> On Thu, Jun 6, 2024 at 2:30=E2=80=AFPM Barry Song <21cnbao@gmail.com> =
wrote:
> >>>
> >>> On Fri, Jun 7, 2024 at 9:17=E2=80=AFAM David Hildenbrand <david@redha=
t.com> wrote:
> >>>>
> >>>> On 06.06.24 22:31, Yosry Ahmed wrote:
> >>>>> On Thu, Jun 6, 2024 at 1:22=E2=80=AFPM David Hildenbrand <david@red=
hat.com> wrote:
> >>>>>>
> >>>>>> On 06.06.24 20:48, Yosry Ahmed wrote:
> >>>>>>> With ongoing work to support large folio swapin, it is important =
to make
> >>>>>>> sure we do not pass large folios to zswap_load() without implemen=
ting
> >>>>>>> proper support.
> >>>>>>>
> >>>>>>> For example, if a swapin fault observes that contiguous PTEs are
> >>>>>>> pointing to contiguous swap entries and tries to swap them in as =
a large
> >>>>>>> folio, swap_read_folio() will pass in a large folio to zswap_load=
(), but
> >>>>>>> zswap_load() will only effectively load the first page in the fol=
io. If
> >>>>>>> the first page is not in zswap, the folio will be read from disk,=
 even
> >>>>>>> though other pages may be in zswap.
> >>>>>>>
> >>>>>>> In both cases, this will lead to silent data corruption.
> >>>>>>>
> >>>>>>> Proper large folio swapin support needs to go into zswap before z=
swap
> >>>>>>> can be enabled in a system that supports large folio swapin.
> >>>>>>>
> >>>>>>> Looking at callers of swap_read_folio(), it seems like they are e=
ither
> >>>>>>> allocated from __read_swap_cache_async() or do_swap_page() in the
> >>>>>>> SWP_SYNCHRONOUS_IO path. Both of which allocate order-0 folios, s=
o we
> >>>>>>> are fine for now.
> >>>>>>>
> >>>>>>> Add a VM_BUG_ON() in zswap_load() to make sure that we detect cha=
nges in
> >>>>>>> the order of those allocations without proper handling of zswap.
> >>>>>>>
> >>>>>>> Alternatively, swap_read_folio() (or its callers) can be updated =
to have
> >>>>>>> a fallback mechanism that splits large folios or reads subpages
> >>>>>>> separately. Similar logic may be needed anyway in case part of a =
large
> >>>>>>> folio is already in the swapcache and the rest of it is swapped o=
ut.
> >>>>>>>
> >>>>>>> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> >>>>>>> ---
> >>>>>>>
> >>>>>>> Sorry for the long CC list, I just found myself repeatedly lookin=
g at
> >>>>>>> new series that add swap support for mTHPs / large folios, making=
 sure
> >>>>>>> they do not break with zswap or make incorrect assumptions. This =
debug
> >>>>>>> check should give us some peace of mind. Hopefully this patch wil=
l also
> >>>>>>> raise awareness among people who are working on this.
> >>>>>>>
> >>>>>>> ---
> >>>>>>>     mm/zswap.c | 3 +++
> >>>>>>>     1 file changed, 3 insertions(+)
> >>>>>>>
> >>>>>>> diff --git a/mm/zswap.c b/mm/zswap.c
> >>>>>>> index b9b35ef86d9be..6007252429bb2 100644
> >>>>>>> --- a/mm/zswap.c
> >>>>>>> +++ b/mm/zswap.c
> >>>>>>> @@ -1577,6 +1577,9 @@ bool zswap_load(struct folio *folio)
> >>>>>>>         if (!entry)
> >>>>>>>                 return false;
> >>>>>>>
> >>>>>>> +     /* Zswap loads do not handle large folio swapins correctly =
yet */
> >>>>>>> +     VM_BUG_ON(folio_test_large(folio));
> >>>>>>> +
> >>>>>>
> >>>>>> There is no way we could have a WARN_ON_ONCE() and recover, right?
> >>>>>
> >>>>> Not without making more fundamental changes to the surrounding swap
> >>>>> code. Currently zswap_load() returns either true (folio was loaded
> >>>>> from zswap) or false (folio is not in zswap).
> >>>>>
> >>>>> To handle this correctly zswap_load() would need to tell
> >>>>> swap_read_folio() which subpages are in zswap and have been loaded,
> >>>>> and then swap_read_folio() would need to read the remaining subpage=
s
> >>>>> from disk. This of course assumes that the caller of swap_read_foli=
o()
> >>>>> made sure that the entire folio is swapped out and protected agains=
t
> >>>>> races with other swapins.
> >>>>>
> >>>>> Also, because swap_read_folio() cannot split the folio itself, othe=
r
> >>>>> swap_read_folio_*() functions that are called from it should be
> >>>>> updated to handle swapping in tail subpages, which may be questiona=
ble
> >>>>> in its own right.
> >>>>>
> >>>>> An alternative would be that zswap_load() (or a separate interface)
> >>>>> could tell swap_read_folio() that the folio is partially in zswap,
> >>>>> then we can just bail and tell the caller that it cannot read the
> >>>>> large folio and that it should be split.
> >>>>>
> >>>>> There may be other options as well, but the bottom line is that it =
is
> >>>>> possible, but probably not something that we want to do right now.
> >>>>>
> >>>>> A stronger protection method would be to introduce a config option =
or
> >>>>> boot parameter for large folio swapin, and then make CONFIG_ZSWAP
> >>>>> depend on it being disabled, or have zswap check it at boot and ref=
use
> >>>>> to be enabled if it is on.
> >>>>
> >>>> Right, sounds like the VM_BUG_ON() really is not that easily avoidab=
le.
> >>>>
> >>>> I was wondering, if we could WARN_ON_ONCE and make the swap code det=
ect
> >>>> this like a read-error from disk.
> >>>>
> >>>> I think do_swap_page() detects that by checking if the folio is not
> >>>> uptodate:
> >>>>
> >>>> if (unlikely(!folio_test_uptodate(folio))) {
> >>>>          ret =3D VM_FAULT_SIGBUS;
> >>>>          goto out_nomap;
> >>>> }
> >>>>
> >>>> So maybe WARN_ON_ONCE() + triggering that might be a bit nicer to th=
e
> >>>> system (but the app would crash either way, there is no way around i=
t).
> >>>>
> >>>
> >>> I'd rather fallback to small folios swapin instead crashing apps till=
 we fix
> >>> the large folio swapin in zswap :-)
> >>
> >> I think David is referring to catching the buggy cases that do not
> >> properly fallback to small folios with zswap, not as an alternative to
> >> the fallback. This is at least what I had in mind with the patch.
> >
> > Cool. Thanks for the clarification. I'm fine with keeping the fallback,
> > whether it's the current VM_BUG_ON or David's recommended
> > SIGBUS.
> >
> > Currently, mainline doesn't support large folios swap-in, so I see
> > your patch as a helpful warning for those attempting large folio
> > swap-in to avoid making mistakes like loading large folios from
> > zswap.
> >
> > In fact, I spent a week trying to figure out why my app was crashing
> > before I added 'if (zswap_is_enabled()) goto fallback'. If your patch
> > had come earlier, it would have saved me that week of work :-)
> >
> > To me, a direct crash seems like a more straightforward way to
> > prompt people to fallback when attempting large folio swap-ins.
> > So, I am slightly in favor of your current patch.
>
> BUG_ON and friends are frowned-upon, in particular in scenarios where we
> can recover or that are so unexpected that they can be found during
> early testing.
>
> I have no strong opinion on this one, but likely a VM_WARN_ON would also
> be sufficient to find such issues early during testing. No need to crash
> the machine.

I thought VM_BUG_ON() was less frowned-upon than BUG_ON(), but after
some digging I found your patches to checkpatch and Linus clearly
stating that it isn't.

How about something like the following (untested), it is the minimal
recovery we can do but should work for a lot of cases, and does
nothing beyond a warning if we can swapin the large folio from disk:

diff --git a/mm/page_io.c b/mm/page_io.c
index f1a9cfab6e748..8f441dd8e109f 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -517,7 +517,6 @@ void swap_read_folio(struct folio *folio, struct
swap_iocb **plug)
        delayacct_swapin_start();

        if (zswap_load(folio)) {
-               folio_mark_uptodate(folio);
                folio_unlock(folio);
        } else if (data_race(sis->flags & SWP_FS_OPS)) {
                swap_read_folio_fs(folio, plug);
diff --git a/mm/zswap.c b/mm/zswap.c
index 6007252429bb2..cc04db6bb217e 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1557,6 +1557,22 @@ bool zswap_load(struct folio *folio)

        VM_WARN_ON_ONCE(!folio_test_locked(folio));

+       /*
+        * Large folios should not be swapped in while zswap is being used,=
 as
+        * they are not properly handled.
+        *
+        * If any of the subpages are in zswap, reading from disk would res=
ult
+        * in data corruption, so return true without marking the folio upt=
odate
+        * so that an IO error is emitted (e.g. do_swap_page() will sigfaul=
t).
+        *
+        * Otherwise, return false and read the folio from disk.
+        */
+       if (WARN_ON_ONCE(folio_test_large(folio))) {
+               if (xa_find(tree, &offset, offset +
folio_nr_pages(folio) - 1, 0))
+                       return true;
+               return false;
+       }
+
        /*
         * When reading into the swapcache, invalidate our entry. The
         * swapcache can be the authoritative owner of the page and
@@ -1593,7 +1609,7 @@ bool zswap_load(struct folio *folio)
                zswap_entry_free(entry);
                folio_mark_dirty(folio);
        }
-
+       folio_mark_uptodate(folio);
        return true;
 }

One problem is that even if zswap was never enabled, the warning will
be emitted just if CONFIG_ZSWAP is on. Perhaps we need a variable or
static key if zswap was "ever" enabled.

Barry, I suspect your is_zswap_enabled() check is deficient for
similar reasons, zswap could have been enabled before then became
disabled.

