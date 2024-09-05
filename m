Return-Path: <linux-kernel+bounces-316891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91ED596D699
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 13:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AFC32890BC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 11:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24EBE1991AC;
	Thu,  5 Sep 2024 11:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OCRFD2rY"
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2AE19882C
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 11:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725534055; cv=none; b=JH+Xyp3GYRPSb4CaVCqMsjEOAewXiugnwUhEcgmmT12DpRvOh7ufMnf9vi9kRr0eunoz4ZLLmTqvNO7hGYt5UfoKXSHuFpAXywOGGs/7bCtM8GPEU/b072NLEblkdWIwnt7EXRexGtf+asl5DpkOk7RDXH9caZZ3d2vkVF3wGTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725534055; c=relaxed/simple;
	bh=G9pcVKPZ4w2SeFbkKtO0U2eXIS+J+K/ydQYHJF85ZdA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OWu/J6SVm04E7KQtC/8fwcOQhxcNuOdpi7W18gv8Kizr4MsnxbRDTntpQsZRqNwKyeV/7OCT8G6bqvKn/zdhsPvo00JPtohtSO26hsJqBB5C5+AegLzNnTVH41SktOXFvUiNLCWrVBq9LCEOMtJGtZkHXDXgTOVU0PkXysD+oSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OCRFD2rY; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-4fd01b38dd7so220790e0c.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 04:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725534052; x=1726138852; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TX/t4BudZdupGh0RbfkCFE19KwqtGTdcusyaQxytRGA=;
        b=OCRFD2rYcANFGo0pDBRiKDvZGUUZlGeE+zztSa9fJ8PRA3Ayn4gCSoh+ySarLrN85l
         ReWj9iMjxlyVyOMQp4jP4AB7wcpsJ0axNKpbQkUGrQL8FoUCj1xuCgrIS4eUy0o4VGA3
         BQN9dbz/+2yzPJYPBBYxL76dN+ZmXTUD+HwAqqwLP61ID/8tKQ+eMa6hNv9uX24g8Ebp
         4QZmN63ObxcGmggeHHiBgIt9IvJTCq5jPF225GhuwvEbQ6AKLok2UcTr/XBW94tYlYCR
         6hxxObF9YkNpIgETmC+LwhVtXcHNXa9qO4RyT0rIvq7tROLL9LLvkmmdn06Yvhddzvub
         PixQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725534052; x=1726138852;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TX/t4BudZdupGh0RbfkCFE19KwqtGTdcusyaQxytRGA=;
        b=l8KRpl07xrEvz4Rg0pMwEx7WYJ1GuJfDr1Imymn1e4Rf+4pKxQG6QebOYCTEy7AGgr
         RQq5M80iPHnQXOtzwl2q0C/g7LMTjw9Ulx4ov3n/h91+n+roLldmLyVPHVbpQqy2EiKq
         QGURRDfj1bWGs1E7MlnUkHc94SM0SjqLmjR8/+188NUVDVztWGvihtxUEr5/8zn/RUX1
         iroH8dzSm3wLBu6VOMcPYr32tsfu3UA8+kKPHM3ra+tNycoyDistfdhPnAoUH1GRKUJF
         dXE0eujHs8YzJnxstFOIilp9e9blDkBUWkx6jxlLlnOL0YRrZT3BGHx0W5KMWTE6uU1W
         5TaA==
X-Forwarded-Encrypted: i=1; AJvYcCWUkKGWsjmRHK5rxqMJE2PXhGwbOqCQ6JqY8ond+YzMrdzLEuJrJfTjiOHflC1MxfPGtzgAyQL78u5GZMA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAo91B065QKEwn2uhh6DJvSRzMYO84bSRVoivONuwvskIgTtvW
	y7Q7pO+PzUzdAsw3LeK6dh+/N3zI/IhHhnqXGiog7ng/rqPU4+rbdnD0TeERbkD93En1BsFgcJH
	CuQDHAaYzew1GMYdqv+EnS7qHdudLMi2z5oI=
X-Google-Smtp-Source: AGHT+IEO5FQxHqX8ZSTRjCQFoGwHS9HkBclNdDzvhsTr3hAFbCCzHZiC4bn8BAFO5cNoLSv98QpUuKJQIwtCQrOY438=
X-Received: by 2002:a05:6122:328f:b0:4f5:14f9:e12c with SMTP id
 71dfb90a1353d-4fff16ee678mr27528077e0c.13.1725534051552; Thu, 05 Sep 2024
 04:00:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240612124750.2220726-2-usamaarif642@gmail.com>
 <20240904055522.2376-1-21cnbao@gmail.com> <CAJD7tkYNn51b3wQbNnJoy8TMVA+r+ookuZzNEEpYWwKiZPVRdg@mail.gmail.com>
 <CAGsJ_4w2k=704mgtQu97y5Qpidc-x+ZBmBXCytkzdcasfAaG0w@mail.gmail.com>
 <CAJD7tkYqk_raVy07cw9cz=RWo=6BpJc0Ax84MkXLRqCjYvYpeA@mail.gmail.com>
 <CAGsJ_4w4woc6st+nPqH7PnhczhQZ7j90wupgX28UrajobqHLnw@mail.gmail.com>
 <CAJD7tkY+wXUwmgZUfVqSXpXL_CxRO-4eKGCPunfJaTDGhNO=Kw@mail.gmail.com>
 <CAGsJ_4zP_tA4z-n=3MTPorNnmANdSJTg4jSx0-atHS1vdd2jmg@mail.gmail.com>
 <CAJD7tkZ7ZhGz5J5O=PEkoyN9WeSjXOLMqnASFc8T3Vpv5uiSRQ@mail.gmail.com>
 <CAGsJ_4x0y+RtghmFifm_pR-=P_t5hNW5qjvw-oF+-T_amuVuzQ@mail.gmail.com>
 <CAGsJ_4zB7za72xL94-1Oc+M2M1RtxftVYUAUk=1yngUoK65stw@mail.gmail.com>
 <CAGsJ_4yBFpyA4Znfgr7V=eoHAnhuLPDTqaVOre9waTKZ+R3R9A@mail.gmail.com> <ede9c691-9b94-486a-895e-a822615b2805@gmail.com>
In-Reply-To: <ede9c691-9b94-486a-895e-a822615b2805@gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 5 Sep 2024 23:00:39 +1200
Message-ID: <CAGsJ_4xRHtFvxc6kbpGdrvxpaQYCHNWpZsMO+GbX7LJwW841nw@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] mm: store zero pages to be swapped out in a bitmap
To: Usama Arif <usamaarif642@gmail.com>
Cc: Yosry Ahmed <yosryahmed@google.com>, akpm@linux-foundation.org, 
	chengming.zhou@linux.dev, david@redhat.com, hannes@cmpxchg.org, 
	hughd@google.com, kernel-team@meta.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, nphamcs@gmail.com, shakeel.butt@linux.dev, 
	willy@infradead.org, ying.huang@intel.com, hanchuanhua@oppo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 10:53=E2=80=AFPM Usama Arif <usamaarif642@gmail.com>=
 wrote:
>
>
>
> On 05/09/2024 11:33, Barry Song wrote:
> > On Thu, Sep 5, 2024 at 10:10=E2=80=AFPM Barry Song <21cnbao@gmail.com> =
wrote:
> >>
> >> On Thu, Sep 5, 2024 at 8:49=E2=80=AFPM Barry Song <21cnbao@gmail.com> =
wrote:
> >>>
> >>> On Thu, Sep 5, 2024 at 7:55=E2=80=AFPM Yosry Ahmed <yosryahmed@google=
.com> wrote:
> >>>>
> >>>> On Thu, Sep 5, 2024 at 12:03=E2=80=AFAM Barry Song <21cnbao@gmail.co=
m> wrote:
> >>>>>
> >>>>> On Thu, Sep 5, 2024 at 5:41=E2=80=AFAM Yosry Ahmed <yosryahmed@goog=
le.com> wrote:
> >>>>>>
> >>>>>> [..]
> >>>>>>>> I understand the point of doing this to unblock the synchronous =
large
> >>>>>>>> folio swapin support work, but at some point we're gonna have to
> >>>>>>>> actually handle the cases where a large folio being swapped in i=
s
> >>>>>>>> partially in the swap cache, zswap, the zeromap, etc.
> >>>>>>>>
> >>>>>>>> All these cases will need similar-ish handling, and I suspect we=
 won't
> >>>>>>>> just skip swapping in large folios in all these cases.
> >>>>>>>
> >>>>>>> I agree that this is definitely the goal. `swap_read_folio()` sho=
uld be a
> >>>>>>> dependable API that always returns reliable data, regardless of w=
hether
> >>>>>>> `zeromap` or `zswap` is involved. Despite these issues, mTHP swap=
-in shouldn't
> >>>>>>> be held back. Significant efforts are underway to support large f=
olios in
> >>>>>>> `zswap`, and progress is being made. Not to mention we've already=
 allowed
> >>>>>>> `zeromap` to proceed, even though it doesn't support large folios=
.
> >>>>>>>
> >>>>>>> It's genuinely unfair to let the lack of mTHP support in `zeromap=
` and
> >>>>>>> `zswap` hold swap-in hostage.
> >>>>>>
> >>>>>
> >>>>> Hi Yosry,
> >>>>>
> >>>>>> Well, two points here:
> >>>>>>
> >>>>>> 1. I did not say that we should block the synchronous mTHP swapin =
work
> >>>>>> for this :) I said the next item on the TODO list for mTHP swapin
> >>>>>> support should be handling these cases.
> >>>>>
> >>>>> Thanks for your clarification!
> >>>>>
> >>>>>>
> >>>>>> 2. I think two things are getting conflated here. Zswap needs to
> >>>>>> support mTHP swapin*. Zeromap already supports mTHPs AFAICT. What =
is
> >>>>>> truly, and is outside the scope of zswap/zeromap, is being able to
> >>>>>> support hybrid mTHP swapin.
> >>>>>>
> >>>>>> When swapping in an mTHP, the swapped entries can be on disk, in t=
he
> >>>>>> swapcache, in zswap, or in the zeromap. Even if all these things
> >>>>>> support mTHPs individually, we essentially need support to form an
> >>>>>> mTHP from swap entries in different backends. That's what I meant.
> >>>>>> Actually if we have that, we may not really need mTHP swapin suppo=
rt
> >>>>>> in zswap, because we can just form the large folio in the swap lay=
er
> >>>>>> from multiple zswap entries.
> >>>>>>
> >>>>>
> >>>>> After further consideration, I've actually started to disagree with=
 the idea
> >>>>> of supporting hybrid swapin (forming an mTHP from swap entries in d=
ifferent
> >>>>> backends). My reasoning is as follows:
> >>>>
> >>>> I do not have any data about this, so you could very well be right
> >>>> here. Handling hybrid swapin could be simply falling back to the
> >>>> smallest order we can swapin from a single backend. We can at least
> >>>> start with this, and collect data about how many mTHP swapins fallba=
ck
> >>>> due to hybrid backends. This way we only take the complexity if
> >>>> needed.
> >>>>
> >>>> I did imagine though that it's possible for two virtually contiguous
> >>>> folios to be swapped out to contiguous swap entries and end up in
> >>>> different media (e.g. if only one of them is zero-filled). I am not
> >>>> sure how rare it would be in practice.
> >>>>
> >>>>>
> >>>>> 1. The scenario where an mTHP is partially zeromap, partially zswap=
, etc.,
> >>>>> would be an extremely rare case, as long as we're swapping out the =
mTHP as
> >>>>> a whole and all the modules are handling it accordingly. It's highl=
y
> >>>>> unlikely to form this mix of zeromap, zswap, and swapcache unless t=
he
> >>>>> contiguous VMA virtual address happens to get some small folios wit=
h
> >>>>> aligned and contiguous swap slots. Even then, they would need to be
> >>>>> partially zeromap and partially non-zeromap, zswap, etc.
> >>>>
> >>>> As I mentioned, we can start simple and collect data for this. If it=
's
> >>>> rare and we don't need to handle it, that's good.
> >>>>
> >>>>>
> >>>>> As you mentioned, zeromap handles mTHP as a whole during swapping
> >>>>> out, marking all subpages of the entire mTHP as zeromap rather than=
 just
> >>>>> a subset of them.
> >>>>>
> >>>>> And swap-in can also entirely map a swapcache which is a large foli=
o based
> >>>>> on our previous patchset which has been in mainline:
> >>>>> "mm: swap: entirely map large folios found in swapcache"
> >>>>> https://lore.kernel.org/all/20240529082824.150954-1-21cnbao@gmail.c=
om/
> >>>>>
> >>>>> It seems the only thing we're missing is zswap support for mTHP.
> >>>>
> >>>> It is still possible for two virtually contiguous folios to be swapp=
ed
> >>>> out to contiguous swap entries. It is also possible that a large fol=
io
> >>>> is swapped out as a whole, then only a part of it is swapped in late=
r
> >>>> due to memory pressure. If that part is later reclaimed again and ge=
ts
> >>>> added to the swapcache, we can run into the hybrid swapin situation.
> >>>> There may be other scenarios as well, I did not think this through.
> >>>>
> >>>>>
> >>>>> 2. Implementing hybrid swap-in would be extremely tricky and could =
disrupt
> >>>>> several software layers. I can share some pseudo code below:
> >>>>
> >>>> Yeah it definitely would be complex, so we need proper justification=
 for it.
> >>>>
> >>>>>
> >>>>> swap_read_folio()
> >>>>> {
> >>>>>        if (zeromap_full)
> >>>>>                folio_read_from_zeromap()
> >>>>>        else if (zswap_map_full)
> >>>>>               folio_read_from_zswap()
> >>>>>        else {
> >>>>>               folio_read_from_swapfile()
> >>>>>               if (zeromap_partial)
> >>>>>                        folio_read_from_zeromap_fixup()  /* fill zer=
o
> >>>>> for partially zeromap subpages */
> >>>>>               if (zwap_partial)
> >>>>>                        folio_read_from_zswap_fixup()  /* zswap_load
> >>>>> for partially zswap-mapped subpages */
> >>>>>
> >>>>>                folio_mark_uptodate()
> >>>>>                folio_unlock()
> >>>>> }
> >>>>>
> >>>>> We'd also need to modify folio_read_from_swapfile() to skip
> >>>>> folio_mark_uptodate()
> >>>>> and folio_unlock() after completing the BIO. This approach seems to
> >>>>> entirely disrupt
> >>>>> the software layers.
> >>>>>
> >>>>> This could also lead to unnecessary IO operations for subpages that
> >>>>> require fixup.
> >>>>> Since such cases are quite rare, I believe the added complexity isn=
't worth it.
> >>>>>
> >>>>> My point is that we should simply check that all PTEs have consiste=
nt zeromap,
> >>>>> zswap, and swapcache statuses before proceeding, otherwise fall bac=
k to the next
> >>>>> lower order if needed. This approach improves performance and avoid=
s complex
> >>>>> corner cases.
> >>>>
> >>>> Agree that we should start with that, although we should probably
> >>>> fallback to the largest order we can swapin from a single backend,
> >>>> rather than the next lower order.
> >>>>
> >>>>>
> >>>>> So once zswap mTHP is there, I would also expect an API similar to
> >>>>> swap_zeromap_entries_check()
> >>>>> for example:
> >>>>> zswap_entries_check(entry, nr) which can return if we are having
> >>>>> full, non, and partial zswap to replace the existing
> >>>>> zswap_never_enabled().
> >>>>
> >>>> I think a better API would be similar to what Usama had. Basically
> >>>> take in (entry, nr) and return how much of it is in zswap starting a=
t
> >>>> entry, so that we can decide the swapin order.
> >>>>
> >>>> Maybe we can adjust your proposed swap_zeromap_entries_check() as we=
ll
> >>>> to do that? Basically return the number of swap entries in the zerom=
ap
> >>>> starting at 'entry'. If 'entry' itself is not in the zeromap we retu=
rn
> >>>> 0 naturally. That would be a small adjustment/fix over what Usama ha=
d,
> >>>> but implementing it with bitmap operations like you did would be
> >>>> better.
> >>>
> >>> I assume you means the below
> >>>
> >>> /*
> >>>  * Return the number of contiguous zeromap entries started from entry
> >>>  */
> >>> static inline unsigned int swap_zeromap_entries_count(swp_entry_t ent=
ry, int nr)
> >>> {
> >>>         struct swap_info_struct *sis =3D swp_swap_info(entry);
> >>>         unsigned long start =3D swp_offset(entry);
> >>>         unsigned long end =3D start + nr;
> >>>         unsigned long idx;
> >>>
> >>>         idx =3D find_next_bit(sis->zeromap, end, start);
> >>>         if (idx !=3D start)
> >>>                 return 0;
> >>>
> >>>         return find_next_zero_bit(sis->zeromap, end, start) - idx;
> >>> }
> >>>
> >>> If yes, I really like this idea.
> >>>
> >>> It seems much better than using an enum, which would require adding a=
 new
> >>> data structure :-) Additionally, returning the number allows callers
> >>> to fall back
> >>> to the largest possible order, rather than trying next lower orders
> >>> sequentially.
> >>
> >> No, returning 0 after only checking first entry would still reintroduc=
e
> >> the current bug, where the start entry is zeromap but other entries
> >> might not be. We need another value to indicate whether the entries
> >> are consistent if we want to avoid the enum:
> >>
> >> /*
> >>  * Return the number of contiguous zeromap entries started from entry;
> >>  * If all entries have consistent zeromap, *consistent will be true;
> >>  * otherwise, false;
> >>  */
> >> static inline unsigned int swap_zeromap_entries_count(swp_entry_t entr=
y,
> >>                 int nr, bool *consistent)
> >> {
> >>         struct swap_info_struct *sis =3D swp_swap_info(entry);
> >>         unsigned long start =3D swp_offset(entry);
> >>         unsigned long end =3D start + nr;
> >>         unsigned long s_idx, c_idx;
> >>
> >>         s_idx =3D find_next_bit(sis->zeromap, end, start);
> >>         if (s_idx =3D=3D end) {
> >>                 *consistent =3D true;
> >>                 return 0;
> >>         }
> >>
> >>         c_idx =3D find_next_zero_bit(sis->zeromap, end, start);
> >>         if (c_idx =3D=3D end) {
> >>                 *consistent =3D true;
> >>                 return nr;
> >>         }
> >>
> >>         *consistent =3D false;
> >>         if (s_idx =3D=3D start)
> >>                 return 0;
> >>         return c_idx - s_idx;
> >> }
> >>
> >> I can actually switch the places of the "consistent" and returned
> >> number if that looks
> >> better.
> >
> > I'd rather make it simpler by:
> >
> > /*
> >  * Check if all entries have consistent zeromap status, return true if
> >  * all entries are zeromap or non-zeromap, else return false;
> >  */
> > static inline bool swap_zeromap_entries_check(swp_entry_t entry, int nr=
)
> > {
> >         struct swap_info_struct *sis =3D swp_swap_info(entry);
> >         unsigned long start =3D swp_offset(entry);
> >         unsigned long end =3D start + *nr;
> >
> I guess you meant end=3D start + nr here?

right.

>
> >         if (find_next_bit(sis->zeromap, end, start) =3D=3D end)
> >                 return true;
> >         if (find_next_zero_bit(sis->zeromap, end, start) =3D=3D end)
> >                 return true;
> >
> So if zeromap is all false, this still returns true. We cant use this fun=
ction in swap_read_folio_zeromap,
> to check at time of swapin if all were zeros, right?

We can, my point is that swap_read_folio_zeromap() is the only
function that actually
needs the real value of zeromap; the others only care about
consistency. So if we can
avoid introducing a new enum across modules, we avoid it :-)

static bool swap_read_folio_zeromap(struct folio *folio)
{
        struct swap_info_struct *sis =3D swp_swap_info(folio->swap)
        unsigned int nr_pages =3D folio_nr_pages(folio);
        swp_entry_t entry =3D folio->swap;

        /*
         * Swapping in a large folio that is partially in the zeromap is no=
t
         * currently handled. Return true without marking the folio uptodat=
e so
         * that an IO error is emitted (e.g. do_swap_page() will sigbus).
         */
        if (WARN_ON_ONCE(!swap_zeromap_entries_check(entry, nr_pages)))
                return true;

        if (!test_bit(swp_offset(entry), sis->zeromap))
                return false;

        folio_zero_range(folio, 0, folio_size(folio));
        folio_mark_uptodate(folio);
        return true;
}

mm/memory.c only needs true or false, it doesn't care about the real value.

>
>
> >         return false;
> > }
> >
> > mm/page_io.c can combine this with reading the zeromap of first entry t=
o
> > decide if it will read folio from zeromap; mm/memory.c only needs the b=
ool
> > to fallback to the largest possible order.
> >
> > static inline unsigned long thp_swap_suitable_orders(...)
> > {
> >         int order, nr;
> >
> >         order =3D highest_order(orders);
> >
> >         while (orders) {
> >                 nr =3D 1 << order;
> >                 if ((addr >> PAGE_SHIFT) % nr =3D=3D swp_offset % nr &&
> >                     swap_zeromap_entries_check(entry, nr))
> >                         break;
> >                 order =3D next_order(&orders, order);
> >         }
> >
> >         return orders;
> > }
> >
> >>
> >>>
> >>> Hi Usama,
> >>> what is your take on this?
> >>>
> >>>>
> >>>>>
> >>>>> Though I am not sure how cheap zswap can implement it,
> >>>>> swap_zeromap_entries_check()
> >>>>> could be two simple bit operations:
> >>>>>
> >>>>> +static inline zeromap_stat_t swap_zeromap_entries_check(swp_entry_=
t
> >>>>> entry, int nr)
> >>>>> +{
> >>>>> +       struct swap_info_struct *sis =3D swp_swap_info(entry);
> >>>>> +       unsigned long start =3D swp_offset(entry);
> >>>>> +       unsigned long end =3D start + nr;
> >>>>> +
> >>>>> +       if (find_next_bit(sis->zeromap, end, start) =3D=3D end)
> >>>>> +               return SWAP_ZEROMAP_NON;
> >>>>> +       if (find_next_zero_bit(sis->zeromap, end, start) =3D=3D end=
)
> >>>>> +               return SWAP_ZEROMAP_FULL;
> >>>>> +
> >>>>> +       return SWAP_ZEROMAP_PARTIAL;
> >>>>> +}
> >>>>>
> >>>>> 3. swapcache is different from zeromap and zswap. Swapcache indicat=
es
> >>>>> that the memory
> >>>>> is still available and should be re-mapped rather than allocating a
> >>>>> new folio. Our previous
> >>>>> patchset has implemented a full re-map of an mTHP in do_swap_page()=
 as mentioned
> >>>>> in 1.
> >>>>>
> >>>>> For the same reason as point 1, partial swapcache is a rare edge ca=
se.
> >>>>> Not re-mapping it
> >>>>> and instead allocating a new folio would add significant complexity=
.
> >>>>>
> >>>>>>>
> >>>>>>> Nonetheless, `zeromap` and `zswap` are distinct cases. With `zero=
map`, we
> >>>>>>> permit almost all mTHP swap-ins, except for those rare situations=
 where
> >>>>>>> small folios that were swapped out happen to have contiguous and =
aligned
> >>>>>>> swap slots.
> >>>>>>>
> >>>>>>> swapcache is another quite different story, since our user scenar=
ios begin from
> >>>>>>> the simplest sync io on mobile phones, we don't quite care about =
swapcache.
> >>>>>>
> >>>>>> Right. The reason I bring this up is as I mentioned above, there i=
s a
> >>>>>> common problem of forming large folios from different sources, whi=
ch
> >>>>>> includes the swap cache. The fact that synchronous swapin does not=
 use
> >>>>>> the swapcache was a happy coincidence for you, as you can add supp=
ort
> >>>>>> mTHP swapins without handling this case yet ;)
> >>>>>
> >>>>> As I mentioned above, I'd really rather filter out those corner cas=
es
> >>>>> than support
> >>>>> them, not just for the current situation to unlock swap-in series :=
-)
> >>>>
> >>>> If they are indeed corner cases, then I definitely agree.
> >>>
> >

Thanks
Barry

