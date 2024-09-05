Return-Path: <linux-kernel+bounces-316850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 688D096D62C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 12:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF74DB2192D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 10:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92FD1957FC;
	Thu,  5 Sep 2024 10:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CzrOyAYG"
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEA91EBFEC
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 10:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725532435; cv=none; b=h53Mge3htnoFDWflmzfuHxoiZGQjb28mStqAHJMYiMP82jwnSxkNX20V3xSciit+jDko0ZAdLEXhlEkVTgXsr9qJWVabp57JVB/mE8/Q5fMNhbmz3lzuUQT+B5B3a5EYlZuTU17PKQns16IaWPK+7gIUZIin2W7f+zk8IoZ6EjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725532435; c=relaxed/simple;
	bh=8TtfUBAnHrv0FSF0Sxa6r/eppmgLtBJ5/LNpI1fVhek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XQMJbLiW+YB8Xnl0eHWrRuLFqibV81fDI0RxHlOC4XIUct0fegp2jBKwRwLkhjomccO0WaSFmf4FvUwX1V4uhFxW1rh3phkwge1XntF3nQfwo4oKn6QXnGO7UUSqt7I2lORxbao7EkqG8DTeXkeAntpbpl70LP7Q8q8ymAKDOHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CzrOyAYG; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-8487af8a274so221664241.0
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 03:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725532433; x=1726137233; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MYbSda3fgGkg0HT3KqDmd0rydVyaknJZi57LVzoZMa0=;
        b=CzrOyAYGH1mdWvj34n2NorSmgzqbmszXeg2zJuomp5fv0SQsa9wfuLPbW7NjAZLY2S
         enCAXtIfZq+KE+CvINUBtiyDeXpI4Qg0wAa1kx7p8K8w9xx4B7lyfFlGlXrlPI9JPNUe
         mxysT/qyKXVb/72D1NEkWvzhvWSEEt3mD8DGUoXh94YLv5p5FSb4xDu5PnR34n2uNBKU
         yHJbb5qXszXnDxOIpattBaUMR5eH0VvR22/QWPq9eX2bDQpLgt2Sffoe3DBEs/WlYe9S
         fD3ZZFRwcALFhD351pC/Z6tM55wazm0J5txPvvnHPCaFUpdKsI0V/alTq8a9Osz63iIN
         8lmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725532433; x=1726137233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MYbSda3fgGkg0HT3KqDmd0rydVyaknJZi57LVzoZMa0=;
        b=hzJlyf8Xb2BzT2YMhwG5VCTtZF/GI8+Pqzn5wf2IIvlbUfIB/sRN1rf9xOJgkinuHy
         r9AJ7GJ6davkmPOlq2VxrwFPtD2JnmZVRk4qJfY937t7jtoFCRfQY4mUP7Jka6XTrEGG
         46UHYm7Wo9mqBpBHuBovNK2igDK/FpofQjMBaD6rXcy1i/93QGIclPpsDw1hng00dziG
         dmhh0Tuc3YrZ2LZRWfHHrc3YyBFRVSenCFGErlAlgSF6MWCXqi2wYhkap5jSBya0rjT+
         Pps7G94EyKlun4ppr/6UGFEXMS8JNW2uSwLZe5c+0d1tmdDScHPIhFt5GiGAZeTEfw2J
         6Pag==
X-Forwarded-Encrypted: i=1; AJvYcCUt4ZqsDVq8vJyFhDTpkXHzW36lvMFkurlUD3KPrp94BCtbLe4w/vH3hwyPQwpiuo4GwW3ULxCoBMzWxt8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsliOIhAt8mO+akk0+11ZY3BbldsL3hjKXimfCsnyRzwVBDMaG
	7hVEJyLekyjxmAxOARQw59kQDI0xA0c6JJOrY9HKbUIEWd3mYTvzVFx15ubPftcPKNgOa5IdVaf
	V1LNHeqO3bGZPeYlKBxWLnvDSaUw=
X-Google-Smtp-Source: AGHT+IHoZGPm1eRUefvZSSgL9MDtntFTP+bK0YYBsgFtosJQrVViSSUn0a+LlD0aYrEIZmnWcoOb5iwLEvxuLzwPuD8=
X-Received: by 2002:a05:6102:c0c:b0:48f:e759:94bc with SMTP id
 ada2fe7eead31-49a5b0900d2mr22177464137.16.1725532432511; Thu, 05 Sep 2024
 03:33:52 -0700 (PDT)
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
 <CAGsJ_4x0y+RtghmFifm_pR-=P_t5hNW5qjvw-oF+-T_amuVuzQ@mail.gmail.com> <CAGsJ_4zB7za72xL94-1Oc+M2M1RtxftVYUAUk=1yngUoK65stw@mail.gmail.com>
In-Reply-To: <CAGsJ_4zB7za72xL94-1Oc+M2M1RtxftVYUAUk=1yngUoK65stw@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 5 Sep 2024 22:33:41 +1200
Message-ID: <CAGsJ_4yBFpyA4Znfgr7V=eoHAnhuLPDTqaVOre9waTKZ+R3R9A@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] mm: store zero pages to be swapped out in a bitmap
To: Yosry Ahmed <yosryahmed@google.com>
Cc: usamaarif642@gmail.com, akpm@linux-foundation.org, 
	chengming.zhou@linux.dev, david@redhat.com, hannes@cmpxchg.org, 
	hughd@google.com, kernel-team@meta.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, nphamcs@gmail.com, shakeel.butt@linux.dev, 
	willy@infradead.org, ying.huang@intel.com, hanchuanhua@oppo.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 10:10=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> On Thu, Sep 5, 2024 at 8:49=E2=80=AFPM Barry Song <21cnbao@gmail.com> wro=
te:
> >
> > On Thu, Sep 5, 2024 at 7:55=E2=80=AFPM Yosry Ahmed <yosryahmed@google.c=
om> wrote:
> > >
> > > On Thu, Sep 5, 2024 at 12:03=E2=80=AFAM Barry Song <21cnbao@gmail.com=
> wrote:
> > > >
> > > > On Thu, Sep 5, 2024 at 5:41=E2=80=AFAM Yosry Ahmed <yosryahmed@goog=
le.com> wrote:
> > > > >
> > > > > [..]
> > > > > > > I understand the point of doing this to unblock the synchrono=
us large
> > > > > > > folio swapin support work, but at some point we're gonna have=
 to
> > > > > > > actually handle the cases where a large folio being swapped i=
n is
> > > > > > > partially in the swap cache, zswap, the zeromap, etc.
> > > > > > >
> > > > > > > All these cases will need similar-ish handling, and I suspect=
 we won't
> > > > > > > just skip swapping in large folios in all these cases.
> > > > > >
> > > > > > I agree that this is definitely the goal. `swap_read_folio()` s=
hould be a
> > > > > > dependable API that always returns reliable data, regardless of=
 whether
> > > > > > `zeromap` or `zswap` is involved. Despite these issues, mTHP sw=
ap-in shouldn't
> > > > > > be held back. Significant efforts are underway to support large=
 folios in
> > > > > > `zswap`, and progress is being made. Not to mention we've alrea=
dy allowed
> > > > > > `zeromap` to proceed, even though it doesn't support large foli=
os.
> > > > > >
> > > > > > It's genuinely unfair to let the lack of mTHP support in `zerom=
ap` and
> > > > > > `zswap` hold swap-in hostage.
> > > > >
> > > >
> > > > Hi Yosry,
> > > >
> > > > > Well, two points here:
> > > > >
> > > > > 1. I did not say that we should block the synchronous mTHP swapin=
 work
> > > > > for this :) I said the next item on the TODO list for mTHP swapin
> > > > > support should be handling these cases.
> > > >
> > > > Thanks for your clarification!
> > > >
> > > > >
> > > > > 2. I think two things are getting conflated here. Zswap needs to
> > > > > support mTHP swapin*. Zeromap already supports mTHPs AFAICT. What=
 is
> > > > > truly, and is outside the scope of zswap/zeromap, is being able t=
o
> > > > > support hybrid mTHP swapin.
> > > > >
> > > > > When swapping in an mTHP, the swapped entries can be on disk, in =
the
> > > > > swapcache, in zswap, or in the zeromap. Even if all these things
> > > > > support mTHPs individually, we essentially need support to form a=
n
> > > > > mTHP from swap entries in different backends. That's what I meant=
.
> > > > > Actually if we have that, we may not really need mTHP swapin supp=
ort
> > > > > in zswap, because we can just form the large folio in the swap la=
yer
> > > > > from multiple zswap entries.
> > > > >
> > > >
> > > > After further consideration, I've actually started to disagree with=
 the idea
> > > > of supporting hybrid swapin (forming an mTHP from swap entries in d=
ifferent
> > > > backends). My reasoning is as follows:
> > >
> > > I do not have any data about this, so you could very well be right
> > > here. Handling hybrid swapin could be simply falling back to the
> > > smallest order we can swapin from a single backend. We can at least
> > > start with this, and collect data about how many mTHP swapins fallbac=
k
> > > due to hybrid backends. This way we only take the complexity if
> > > needed.
> > >
> > > I did imagine though that it's possible for two virtually contiguous
> > > folios to be swapped out to contiguous swap entries and end up in
> > > different media (e.g. if only one of them is zero-filled). I am not
> > > sure how rare it would be in practice.
> > >
> > > >
> > > > 1. The scenario where an mTHP is partially zeromap, partially zswap=
, etc.,
> > > > would be an extremely rare case, as long as we're swapping out the =
mTHP as
> > > > a whole and all the modules are handling it accordingly. It's highl=
y
> > > > unlikely to form this mix of zeromap, zswap, and swapcache unless t=
he
> > > > contiguous VMA virtual address happens to get some small folios wit=
h
> > > > aligned and contiguous swap slots. Even then, they would need to be
> > > > partially zeromap and partially non-zeromap, zswap, etc.
> > >
> > > As I mentioned, we can start simple and collect data for this. If it'=
s
> > > rare and we don't need to handle it, that's good.
> > >
> > > >
> > > > As you mentioned, zeromap handles mTHP as a whole during swapping
> > > > out, marking all subpages of the entire mTHP as zeromap rather than=
 just
> > > > a subset of them.
> > > >
> > > > And swap-in can also entirely map a swapcache which is a large foli=
o based
> > > > on our previous patchset which has been in mainline:
> > > > "mm: swap: entirely map large folios found in swapcache"
> > > > https://lore.kernel.org/all/20240529082824.150954-1-21cnbao@gmail.c=
om/
> > > >
> > > > It seems the only thing we're missing is zswap support for mTHP.
> > >
> > > It is still possible for two virtually contiguous folios to be swappe=
d
> > > out to contiguous swap entries. It is also possible that a large foli=
o
> > > is swapped out as a whole, then only a part of it is swapped in later
> > > due to memory pressure. If that part is later reclaimed again and get=
s
> > > added to the swapcache, we can run into the hybrid swapin situation.
> > > There may be other scenarios as well, I did not think this through.
> > >
> > > >
> > > > 2. Implementing hybrid swap-in would be extremely tricky and could =
disrupt
> > > > several software layers. I can share some pseudo code below:
> > >
> > > Yeah it definitely would be complex, so we need proper justification =
for it.
> > >
> > > >
> > > > swap_read_folio()
> > > > {
> > > >        if (zeromap_full)
> > > >                folio_read_from_zeromap()
> > > >        else if (zswap_map_full)
> > > >               folio_read_from_zswap()
> > > >        else {
> > > >               folio_read_from_swapfile()
> > > >               if (zeromap_partial)
> > > >                        folio_read_from_zeromap_fixup()  /* fill zer=
o
> > > > for partially zeromap subpages */
> > > >               if (zwap_partial)
> > > >                        folio_read_from_zswap_fixup()  /* zswap_load
> > > > for partially zswap-mapped subpages */
> > > >
> > > >                folio_mark_uptodate()
> > > >                folio_unlock()
> > > > }
> > > >
> > > > We'd also need to modify folio_read_from_swapfile() to skip
> > > > folio_mark_uptodate()
> > > > and folio_unlock() after completing the BIO. This approach seems to
> > > > entirely disrupt
> > > > the software layers.
> > > >
> > > > This could also lead to unnecessary IO operations for subpages that
> > > > require fixup.
> > > > Since such cases are quite rare, I believe the added complexity isn=
't worth it.
> > > >
> > > > My point is that we should simply check that all PTEs have consiste=
nt zeromap,
> > > > zswap, and swapcache statuses before proceeding, otherwise fall bac=
k to the next
> > > > lower order if needed. This approach improves performance and avoid=
s complex
> > > > corner cases.
> > >
> > > Agree that we should start with that, although we should probably
> > > fallback to the largest order we can swapin from a single backend,
> > > rather than the next lower order.
> > >
> > > >
> > > > So once zswap mTHP is there, I would also expect an API similar to
> > > > swap_zeromap_entries_check()
> > > > for example:
> > > > zswap_entries_check(entry, nr) which can return if we are having
> > > > full, non, and partial zswap to replace the existing
> > > > zswap_never_enabled().
> > >
> > > I think a better API would be similar to what Usama had. Basically
> > > take in (entry, nr) and return how much of it is in zswap starting at
> > > entry, so that we can decide the swapin order.
> > >
> > > Maybe we can adjust your proposed swap_zeromap_entries_check() as wel=
l
> > > to do that? Basically return the number of swap entries in the zeroma=
p
> > > starting at 'entry'. If 'entry' itself is not in the zeromap we retur=
n
> > > 0 naturally. That would be a small adjustment/fix over what Usama had=
,
> > > but implementing it with bitmap operations like you did would be
> > > better.
> >
> > I assume you means the below
> >
> > /*
> >  * Return the number of contiguous zeromap entries started from entry
> >  */
> > static inline unsigned int swap_zeromap_entries_count(swp_entry_t entry=
, int nr)
> > {
> >         struct swap_info_struct *sis =3D swp_swap_info(entry);
> >         unsigned long start =3D swp_offset(entry);
> >         unsigned long end =3D start + nr;
> >         unsigned long idx;
> >
> >         idx =3D find_next_bit(sis->zeromap, end, start);
> >         if (idx !=3D start)
> >                 return 0;
> >
> >         return find_next_zero_bit(sis->zeromap, end, start) - idx;
> > }
> >
> > If yes, I really like this idea.
> >
> > It seems much better than using an enum, which would require adding a n=
ew
> > data structure :-) Additionally, returning the number allows callers
> > to fall back
> > to the largest possible order, rather than trying next lower orders
> > sequentially.
>
> No, returning 0 after only checking first entry would still reintroduce
> the current bug, where the start entry is zeromap but other entries
> might not be. We need another value to indicate whether the entries
> are consistent if we want to avoid the enum:
>
> /*
>  * Return the number of contiguous zeromap entries started from entry;
>  * If all entries have consistent zeromap, *consistent will be true;
>  * otherwise, false;
>  */
> static inline unsigned int swap_zeromap_entries_count(swp_entry_t entry,
>                 int nr, bool *consistent)
> {
>         struct swap_info_struct *sis =3D swp_swap_info(entry);
>         unsigned long start =3D swp_offset(entry);
>         unsigned long end =3D start + nr;
>         unsigned long s_idx, c_idx;
>
>         s_idx =3D find_next_bit(sis->zeromap, end, start);
>         if (s_idx =3D=3D end) {
>                 *consistent =3D true;
>                 return 0;
>         }
>
>         c_idx =3D find_next_zero_bit(sis->zeromap, end, start);
>         if (c_idx =3D=3D end) {
>                 *consistent =3D true;
>                 return nr;
>         }
>
>         *consistent =3D false;
>         if (s_idx =3D=3D start)
>                 return 0;
>         return c_idx - s_idx;
> }
>
> I can actually switch the places of the "consistent" and returned
> number if that looks
> better.

I'd rather make it simpler by:

/*
 * Check if all entries have consistent zeromap status, return true if
 * all entries are zeromap or non-zeromap, else return false;
 */
static inline bool swap_zeromap_entries_check(swp_entry_t entry, int nr)
{
        struct swap_info_struct *sis =3D swp_swap_info(entry);
        unsigned long start =3D swp_offset(entry);
        unsigned long end =3D start + *nr;

        if (find_next_bit(sis->zeromap, end, start) =3D=3D end)
                return true;
        if (find_next_zero_bit(sis->zeromap, end, start) =3D=3D end)
                return true;

        return false;
}

mm/page_io.c can combine this with reading the zeromap of first entry to
decide if it will read folio from zeromap; mm/memory.c only needs the bool
to fallback to the largest possible order.

static inline unsigned long thp_swap_suitable_orders(...)
{
        int order, nr;

        order =3D highest_order(orders);

        while (orders) {
                nr =3D 1 << order;
                if ((addr >> PAGE_SHIFT) % nr =3D=3D swp_offset % nr &&
                    swap_zeromap_entries_check(entry, nr))
                        break;
                order =3D next_order(&orders, order);
        }

        return orders;
}

>
> >
> > Hi Usama,
> > what is your take on this?
> >
> > >
> > > >
> > > > Though I am not sure how cheap zswap can implement it,
> > > > swap_zeromap_entries_check()
> > > > could be two simple bit operations:
> > > >
> > > > +static inline zeromap_stat_t swap_zeromap_entries_check(swp_entry_=
t
> > > > entry, int nr)
> > > > +{
> > > > +       struct swap_info_struct *sis =3D swp_swap_info(entry);
> > > > +       unsigned long start =3D swp_offset(entry);
> > > > +       unsigned long end =3D start + nr;
> > > > +
> > > > +       if (find_next_bit(sis->zeromap, end, start) =3D=3D end)
> > > > +               return SWAP_ZEROMAP_NON;
> > > > +       if (find_next_zero_bit(sis->zeromap, end, start) =3D=3D end=
)
> > > > +               return SWAP_ZEROMAP_FULL;
> > > > +
> > > > +       return SWAP_ZEROMAP_PARTIAL;
> > > > +}
> > > >
> > > > 3. swapcache is different from zeromap and zswap. Swapcache indicat=
es
> > > > that the memory
> > > > is still available and should be re-mapped rather than allocating a
> > > > new folio. Our previous
> > > > patchset has implemented a full re-map of an mTHP in do_swap_page()=
 as mentioned
> > > > in 1.
> > > >
> > > > For the same reason as point 1, partial swapcache is a rare edge ca=
se.
> > > > Not re-mapping it
> > > > and instead allocating a new folio would add significant complexity=
.
> > > >
> > > > > >
> > > > > > Nonetheless, `zeromap` and `zswap` are distinct cases. With `ze=
romap`, we
> > > > > > permit almost all mTHP swap-ins, except for those rare situatio=
ns where
> > > > > > small folios that were swapped out happen to have contiguous an=
d aligned
> > > > > > swap slots.
> > > > > >
> > > > > > swapcache is another quite different story, since our user scen=
arios begin from
> > > > > > the simplest sync io on mobile phones, we don't quite care abou=
t swapcache.
> > > > >
> > > > > Right. The reason I bring this up is as I mentioned above, there =
is a
> > > > > common problem of forming large folios from different sources, wh=
ich
> > > > > includes the swap cache. The fact that synchronous swapin does no=
t use
> > > > > the swapcache was a happy coincidence for you, as you can add sup=
port
> > > > > mTHP swapins without handling this case yet ;)
> > > >
> > > > As I mentioned above, I'd really rather filter out those corner cas=
es
> > > > than support
> > > > them, not just for the current situation to unlock swap-in series :=
-)
> > >
> > > If they are indeed corner cases, then I definitely agree.
> >

Thanks
 Barry

