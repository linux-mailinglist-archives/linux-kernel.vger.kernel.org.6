Return-Path: <linux-kernel+bounces-209061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D7E902C82
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 01:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88E1B284B65
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 23:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEEB4152196;
	Mon, 10 Jun 2024 23:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QbBTELiD"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCF43C0C
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 23:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718062495; cv=none; b=VmSjwcvBiHWiA0YLCkEcuCtlmZ/bLW+jrZt/2kg0wQsbYYAwv2mBBv0tBsdqRw8pjXMrKRtsLs/QgrQbqmhg/WMSYZIaHOSieGSLitcgYyTiOhbrgfi85NtXIBp3jX5UUUODkQ8Taa7CKLu4WysKk6kbQAUStheNvK4bycaPd18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718062495; c=relaxed/simple;
	bh=zpxDXt5iwYQiVrXKuyQt6romYrsEr9RpSNPylLrjYE4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=haxRy0MSzRi3I/b7Swbs1z35FaVlScSRXZiRHOkuJ5DeYfxmgKX5cPLS+cCA+01IiQ5ijnOGIzQzSp5ZakCTtnd5QmG+SZCSw6jXUgz6fXdMj7sARY+BAChW5vV0pf709yDisr4RbWOAGaweBu7psNddyiGtv42lYgq2Jm/0QTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QbBTELiD; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6b081c675e7so6610716d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 16:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718062493; x=1718667293; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oAWl7Ib5EETyb6qKQYzVD1vbK0fWMfxkINjvghmTwZ4=;
        b=QbBTELiDoe8JovoZQUNgJfc/NJS/L1A5HPwHKAw9Wl/c3bHRE2GzOMC4/2VErNzTyt
         a0g57ylfMUVkEGoRS+sOnZ56NjAzoLeNNd/2WGKSO2bKFDCgIbLKkYmR4GseciTzS1QQ
         +IvHGeqLSTg66n6CVThDFDk+bCr6MS9lgRs7NMh1oAF6tioRpO9Tv6/giXIhWmgo3HRC
         k6f9n5XA6caMZIwEyXYDtE7RkzwQHdxUYGtYCj3TE4K46zNv2Ye4x/A6iTpulNNJxL+l
         Ffj0nqpnDgCSBjgZ7FTXMfrxBmN2VPiiBeyle1BmwSRp+oIfwxPSn3ENqvYS+l6PKVHk
         wn9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718062493; x=1718667293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oAWl7Ib5EETyb6qKQYzVD1vbK0fWMfxkINjvghmTwZ4=;
        b=dj1ZyDkTP8e0gy5xpIO7fwuHqBdXikWE5TecjhqBRGv9XMj1KmEE/VTqxktCkUW+ug
         CZn6TeBv2xtM8+2lWCv1YOZroaWKRrzNa1BNq+IOWp6OCTqbO7sUs/cgF3eaXwTSg/7M
         s3/DDcg++tlwRGPqSA2NHwP+1lEcAF1XA6yoORWO8VmeNxvdciq146b2JDR1bzRzdNCq
         1bYK2I0+XUKARLVRATZKhPD96pI6UcXQ6XTGoy73DKoI7lH7Ijl3eZGdLB5F9V7weDER
         fv5R9RWpQlZMqko1NE7adhEhL3Phcz2mJa5q8iVF9u+KIqaoXcQ+mONg4LuLGSiJcU3e
         YILQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBq6wwNurY6rlYqggzTW1YILiIU9cepSo7a654O11OxlKpYCfCt0VapEeWwgIuSAkT8lSFV+U2RFmiE8QLd5KAh9Z9DOU5x8Ko7VFR
X-Gm-Message-State: AOJu0YxSQzRr/r4b9y9ssmiDWtazpjBRx7Ml2f3DKDPNI1pSkKf3tEvM
	1CoMbUPraGWHIZ7rC9DtOYr6XhQnfMS6Gd/o/4275PDjlZaVUSrEYXFni/J+Y3DeI8CL1azx9hM
	AD6z66idusREmxfvjEKTft5S0LFs=
X-Google-Smtp-Source: AGHT+IE3oosJo4kcNHuGcr9G0RD1oLhJ87BJKZd85tjQHgfR4fr0b5ZzGYFIIPFIBItYUIkwkHriHcoN+l3mh86XlVk=
X-Received: by 2002:a05:6214:46a1:b0:6b0:7864:90ac with SMTP id
 6a1803df08f44-6b078649246mr85341986d6.11.1718062492825; Mon, 10 Jun 2024
 16:34:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240608023654.3513385-1-yosryahmed@google.com>
 <CAGsJ_4yVmDKtcKKAdjPOkOMWB+=ZT5TrrWz188xJaTV4EpM1Bw@mail.gmail.com>
 <CAJD7tkaHLVcjUgiUFfBK+ztCqxBTRfyVbSVH9vytK=5JYOw+Sw@mail.gmail.com>
 <CAGsJ_4w-magFysq4uLBm46AzHLD+r=v6pJphwmQn+OFvECHjrA@mail.gmail.com>
 <CAJD7tkYdq533Z7nubjFT5jQYuS4oq2u15RAz2oGHGxYSk5Oicg@mail.gmail.com>
 <CAGsJ_4zNxC5u088RRnKeM18skEJvwTd22mB_FWSA67K3S-CKPw@mail.gmail.com> <CAJD7tkb0Rv4mSPS3DXqF888iVwd++nd99N3WrZYuJhLPDN+dhA@mail.gmail.com>
In-Reply-To: <CAJD7tkb0Rv4mSPS3DXqF888iVwd++nd99N3WrZYuJhLPDN+dhA@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 11 Jun 2024 11:34:41 +1200
Message-ID: <CAGsJ_4ztBavP+ic15V1F0-KUhoE1zh08xuOZ3jMMfuHu=JHNEw@mail.gmail.com>
Subject: Re: [PATCH v2] mm: zswap: handle incorrect attempts to load of large folios
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Nhat Pham <nphamcs@gmail.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Chris Li <chrisl@kernel.org>, 
	Ryan Roberts <ryan.roberts@arm.com>, David Hildenbrand <david@redhat.com>, 
	Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 9:12=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> On Mon, Jun 10, 2024 at 2:00=E2=80=AFPM Barry Song <21cnbao@gmail.com> wr=
ote:
> >
> > On Tue, Jun 11, 2024 at 4:12=E2=80=AFAM Yosry Ahmed <yosryahmed@google.=
com> wrote:
> > >
> > > On Mon, Jun 10, 2024 at 1:06=E2=80=AFPM Barry Song <21cnbao@gmail.com=
> wrote:
> > > >
> > > > On Tue, Jun 11, 2024 at 1:42=E2=80=AFAM Yosry Ahmed <yosryahmed@goo=
gle.com> wrote:
> > > > >
> > > > > On Fri, Jun 7, 2024 at 9:13=E2=80=AFPM Barry Song <21cnbao@gmail.=
com> wrote:
> > > > > >
> > > > > > On Sat, Jun 8, 2024 at 10:37=E2=80=AFAM Yosry Ahmed <yosryahmed=
@google.com> wrote:
> > > > > > >
> > > > > > > Zswap does not support storing or loading large folios. Until=
 proper
> > > > > > > support is added, attempts to load large folios from zswap ar=
e a bug.
> > > > > > >
> > > > > > > For example, if a swapin fault observes that contiguous PTEs =
are
> > > > > > > pointing to contiguous swap entries and tries to swap them in=
 as a large
> > > > > > > folio, swap_read_folio() will pass in a large folio to zswap_=
load(), but
> > > > > > > zswap_load() will only effectively load the first page in the=
 folio. If
> > > > > > > the first page is not in zswap, the folio will be read from d=
isk, even
> > > > > > > though other pages may be in zswap.
> > > > > > >
> > > > > > > In both cases, this will lead to silent data corruption. Prop=
er support
> > > > > > > needs to be added before large folio swapins and zswap can wo=
rk
> > > > > > > together.
> > > > > > >
> > > > > > > Looking at callers of swap_read_folio(), it seems like they a=
re either
> > > > > > > allocated from __read_swap_cache_async() or do_swap_page() in=
 the
> > > > > > > SWP_SYNCHRONOUS_IO path. Both of which allocate order-0 folio=
s, so
> > > > > > > everything is fine for now.
> > > > > > >
> > > > > > > However, there is ongoing work to add to support large folio =
swapins
> > > > > > > [1]. To make sure new development does not break zswap (or ge=
t broken by
> > > > > > > zswap), add minimal handling of incorrect loads of large foli=
os to
> > > > > > > zswap.
> > > > > > >
> > > > > > > First, move the call folio_mark_uptodate() inside zswap_load(=
).
> > > > > > >
> > > > > > > If a large folio load is attempted, and any page in that foli=
o is in
> > > > > > > zswap, return 'true' without calling folio_mark_uptodate(). T=
his will
> > > > > > > prevent the folio from being read from disk, and will emit an=
 IO error
> > > > > > > because the folio is not uptodate (e.g. do_swap_fault() will =
return
> > > > > > > VM_FAULT_SIGBUS). It may not be reliable recovery in all case=
s, but it
> > > > > > > is better than nothing.
> > > > > > >
> > > > > > > This was tested by hacking the allocation in __read_swap_cach=
e_async()
> > > > > > > to use order 2 and __GFP_COMP.
> > > > > > >
> > > > > > > In the future, to handle this correctly, the swapin code shou=
ld:
> > > > > > > (a) Fallback to order-0 swapins if zswap was ever used on the=
 machine,
> > > > > > > because compressed pages remain in zswap after it is disabled=
.
> > > > > > > (b) Add proper support to swapin large folios from zswap (ful=
ly or
> > > > > > > partially).
> > > > > > >
> > > > > > > Probably start with (a) then followup with (b).
> > > > > > >
> > > > > > > [1]https://lore.kernel.org/linux-mm/20240304081348.197341-6-2=
1cnbao@gmail.com/
> > > > > > >
> > > > > > > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> > > > > > > ---
> > > > > > >
> > > > > > > v1: https://lore.kernel.org/lkml/20240606184818.1566920-1-yos=
ryahmed@google.com/
> > > > > > >
> > > > > > > v1 -> v2:
> > > > > > > - Instead of using VM_BUG_ON() use WARN_ON_ONCE() and add som=
e recovery
> > > > > > >   handling (David Hildenbrand).
> > > > > > >
> > > > > > > ---
> > > > > > >  mm/page_io.c |  1 -
> > > > > > >  mm/zswap.c   | 22 +++++++++++++++++++++-
> > > > > > >  2 files changed, 21 insertions(+), 2 deletions(-)
> > > > > > >
> > > > > > > diff --git a/mm/page_io.c b/mm/page_io.c
> > > > > > > index f1a9cfab6e748..8f441dd8e109f 100644
> > > > > > > --- a/mm/page_io.c
> > > > > > > +++ b/mm/page_io.c
> > > > > > > @@ -517,7 +517,6 @@ void swap_read_folio(struct folio *folio,=
 struct swap_iocb **plug)
> > > > > > >         delayacct_swapin_start();
> > > > > > >
> > > > > > >         if (zswap_load(folio)) {
> > > > > > > -               folio_mark_uptodate(folio);
> > > > > > >                 folio_unlock(folio);
> > > > > > >         } else if (data_race(sis->flags & SWP_FS_OPS)) {
> > > > > > >                 swap_read_folio_fs(folio, plug);
> > > > > > > diff --git a/mm/zswap.c b/mm/zswap.c
> > > > > > > index b9b35ef86d9be..ebb878d3e7865 100644
> > > > > > > --- a/mm/zswap.c
> > > > > > > +++ b/mm/zswap.c
> > > > > > > @@ -1557,6 +1557,26 @@ bool zswap_load(struct folio *folio)
> > > > > > >
> > > > > > >         VM_WARN_ON_ONCE(!folio_test_locked(folio));
> > > > > > >
> > > > > > > +       /*
> > > > > > > +        * Large folios should not be swapped in while zswap =
is being used, as
> > > > > > > +        * they are not properly handled. Zswap does not prop=
erly load large
> > > > > > > +        * folios, and a large folio may only be partially in=
 zswap.
> > > > > > > +        *
> > > > > > > +        * If any of the subpages are in zswap, reading from =
disk would result
> > > > > > > +        * in data corruption, so return true without marking=
 the folio uptodate
> > > > > > > +        * so that an IO error is emitted (e.g. do_swap_page(=
) will sigfault).
> > > > > > > +        *
> > > > > > > +        * Otherwise, return false and read the folio from di=
sk.
> > > > > > > +        */
> > > > > > > +       if (folio_test_large(folio)) {
> > > > > > > +               if (xa_find(tree, &offset,
> > > > > > > +                           offset + folio_nr_pages(folio) - =
1, XA_PRESENT)) {
> > > > > > > +                       WARN_ON_ONCE(1);
> > > > > > > +                       return true;
> > > > > > > +               }
> > > > > > > +               return false;
> > > > > >
> > > > > > IMHO, this appears to be over-designed. Personally, I would opt=
 to
> > > > > > use
> > > > > >
> > > > > >  if (folio_test_large(folio))
> > > > > >                return true;
> > > > >
> > > > > I am sure you mean "return false" here. Always returning true mea=
ns we
> > > > > will never read a large folio from either zswap or disk, whether =
it's
> > > > > in zswap or not. Basically guaranteeing corrupting data for large
> > > > > folio swapin, even if zswap is disabled :)
> > > > >
> > > > > >
> > > > > > Before we address large folio support in zswap, it=E2=80=99s es=
sential
> > > > > > not to let them coexist. Expecting valid data by lunchtime is
> > > > > > not advisable.
> > > > >
> > > > > The goal here is to enable development for large folio swapin wit=
hout
> > > > > breaking zswap or being blocked on adding support in zswap. If we
> > > > > always return false for large folios, as you suggest, then even i=
f the
> > > > > folio is in zswap (or parts of it), we will go read it from disk.=
 This
> > > > > will result in silent data corruption.
> > > > >
> > > > > As you mentioned before, you spent a week debugging problems with=
 your
> > > > > large folio swapin series because of a zswap problem, and even af=
ter
> > > > > then, the zswap_is_enabled() check you had is not enough to preve=
nt
> > > > > problems as I mentioned before (if zswap was enabled before). So =
we
> > > > > need stronger checks to make sure we don't break things when we
> > > > > support large folio swapin.
> > > > >
> > > > > Since we can't just check if zswap is enabled or not, we need to
> > > > > rather check if the folio (or any part of it) is in zswap or not.=
 We
> > > > > can only WARN in that case, but delivering the error to userspace=
 is a
> > > > > couple of extra lines of code (not set uptodate), and will make t=
he
> > > > > problem much easier to notice.
> > > > >
> > > > > I am not sure I understand what you mean. The alternative is to
> > > > > introduce a config option (perhaps internal) for large folio swap=
in,
> > > > > and make this depend on !CONFIG_ZSWAP, or make zswap refuse to ge=
t
> > > > > enabled if large folio swapin is enabled (through config or boot
> > > > > option). This is until proper handling is added, of course.
> > > >
> > > > Hi Yosry,
> > > > My point is that anybody attempts to do large folios swap-in should
> > > > either
> > > > 1. always use small folios if zswap has been once enabled before or=
 now
> > > > or
> > > > 2. address the large folios swapin issues in zswap
> > > >
> > > > there is no 3rd way which you are providing.
> > > >
> > > > it is over-designed to give users true or false based on if data is=
 zswap
> > > > as there is always a chance data could be in zswap. so before appro=
ach
> > > > 2 is done, we should always WARN_ON large folios and report data
> > > > corruption.
> > >
> > > We can't always WARN_ON for large folios, as this will fire even if
> > > zswap was never enabled. The alternative is tracking whether zswap wa=
s
> > > ever enabled, and checking that instead of checking if any part of th=
e
> > > folio is in zswap.
> > >
> > > Basically replacing xa_find(..) with zswap_was_enabled(..) or somethi=
ng.
> >
> > My point is that mm core should always fallback
> >
> > if (zswap_was_or_is_enabled())
> >      goto fallback;
> >
> > till zswap fixes the issue. This is the only way to enable large folios=
 swap-in
> > development before we fix zswap.
>
> I agree with this, I just want an extra fallback in zswap itself in
> case something was missed during large folio swapin development (which
> can evidently happen).

yes. then i feel we only need to warn_on the case mm-core fails to fallback=
.

I mean, only WARN_ON  is_zswap_ever_enabled&&large folio. there is no
need to do more. Before zswap brings up the large folio support, mm-core
will need is_zswap_ever_enabled() to do fallback.

diff --git a/include/linux/zswap.h b/include/linux/zswap.h
index 2a85b941db97..035e51ed89c4 100644
--- a/include/linux/zswap.h
+++ b/include/linux/zswap.h
@@ -36,6 +36,7 @@ void zswap_memcg_offline_cleanup(struct mem_cgroup *memcg=
);
 void zswap_lruvec_state_init(struct lruvec *lruvec);
 void zswap_folio_swapin(struct folio *folio);
 bool is_zswap_enabled(void);
+bool is_zswap_ever_enabled(void);
 #else

 struct zswap_lruvec_state {};
@@ -65,6 +66,10 @@ static inline bool is_zswap_enabled(void)
        return false;
 }

+static inline bool is_zswap_ever_enabled(void)
+{
+       return false;
+}
 #endif

 #endif /* _LINUX_ZSWAP_H */
diff --git a/mm/zswap.c b/mm/zswap.c
index b9b35ef86d9b..bf2da5d37e47 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -86,6 +86,9 @@ static int zswap_setup(void);
 static bool zswap_enabled =3D IS_ENABLED(CONFIG_ZSWAP_DEFAULT_ON);
 static int zswap_enabled_param_set(const char *,
                                   const struct kernel_param *);
+
+static bool zswap_ever_enable;
+
 static const struct kernel_param_ops zswap_enabled_param_ops =3D {
        .set =3D          zswap_enabled_param_set,
        .get =3D          param_get_bool,
@@ -136,6 +139,11 @@ bool is_zswap_enabled(void)
        return zswap_enabled;
 }

+bool is_zswap_ever_enabled(void)
+{
+       return zswap_enabled || zswap_ever_enabled;
+}
+
 /*********************************
 * data structures
 **********************************/
@@ -1734,6 +1742,7 @@ static int zswap_setup(void)
                pr_info("loaded using pool %s/%s\n", pool->tfm_name,
                        zpool_get_type(pool->zpools[0]));
                list_add(&pool->list, &zswap_pools);
+               zswap_ever_enabled =3D true;
                zswap_has_pool =3D true;
        } else {
                pr_err("pool creation failed\n");

Thanks
Barry

