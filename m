Return-Path: <linux-kernel+bounces-285277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57205950B95
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 19:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A78FAB21A91
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 17:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668651A2C24;
	Tue, 13 Aug 2024 17:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CLXep0O3"
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0738418C3D
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 17:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723571073; cv=none; b=sBwwB51rd3JCbfKJ9IJ4v/UUqjhiajEABy5O+mzqkOBAQ1aC0j/IEdLl6KSNTzQSTZ+DUf/zSZqt3OsJDQhV2qOR+3dnhokqOCr0UYYCmXS5W0UxFmiTnMbnjKnMKbdGjKOEFSj27to97nU+Alts2pKSI2OtBO3WVQPNLZQFKYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723571073; c=relaxed/simple;
	bh=pquwoTEVoqTwpDQUQ97BwgO1OmGvJXqKbpJUTk23478=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e3S6lCOb21th6IzZwhuXn/3kr61lRanYjwlWlf6XQzHGF/G6YhF7+hgOP/oIOoqqKE/mrW5cwxI1T1VMVM5nmmYZLrHy8noTZ7Rak0tHb6R7PT4tRlLElkIs7yVffkFknfhDy3WbDnBj6USkowxeRBccOkoj4r0G5sVJ83ftKcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CLXep0O3; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-492a01bce97so2030182137.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 10:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723571071; x=1724175871; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v5qCJWinHPwix2emDITqwEdfIFGgfIhzXmjEyYRNeqw=;
        b=CLXep0O3+GDOOTaafQYzZpXEvoiUl39IYUOLXhsnnhp1G2hjnrvKClw5tEAfNS7+MS
         4DvHwIr9lx//HxzED0HfSmYVIQs+ThjXWSWPeKkGq7bh0ssqwlTDkNK2d7X+Ac/ri0Ja
         K4C2uS3/TRNv4yodnh/D6XfOy1Oup1HyLm9ar1MbahbxCdZuIlXmVaLj2yl6ug4B50gV
         OkpKo+Q1Tcno5YZDZByzmWj7rZuuOL+5v1mDGBrHMrSQBKQuG5YLwgVvr78o/2dYEYHs
         WjFfuPpbNwF/9Nix4khKn8XV6BKcpXqdHXQhbGy3xlfzgU7T8OyVk33A2zjhyv8jgSwQ
         W3Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723571071; x=1724175871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v5qCJWinHPwix2emDITqwEdfIFGgfIhzXmjEyYRNeqw=;
        b=CiFsgQweNIpYn2BYvboHSOQQ2wFGMAZofMS12yWHYJmv2tZ+rDmOxXo/c6832iyWLv
         bpdOAubdSEMOaleDGiPZ8xR8P/sC5TBJpgH24E2dF+ip4zNRTDSote56qHajOvF1jSSf
         lEe9X7fpRyZJvxFrXdRU6kOKck7zHIQ64EoR227kXdThDrd1BDw1OOTnOH8kbSFlhPTg
         TKqeq1MX2rvOcs0aC49dO370H3E5UmhNXNA5eB/i0aaX5dNTSIZznCjOqd2XwJBhFS4e
         Wfl+qA9ZQXIzJS/hn8WoH6333Kw05VeIcLDlzkbzF3Bd5H6C/Jks84MgMXpFVHfO0lb3
         75Dg==
X-Forwarded-Encrypted: i=1; AJvYcCUA3y9WhqaUvbb49uNRCvb/m7sBLX2fXfo2FzsoJ4iirlqM1dbcrsvC44z1LPGX2FpnNYiHwGDPGqZm8MbUgq+pkOHZayv7Ik8X2aQT
X-Gm-Message-State: AOJu0Yz0i/lbCM1HM/L0zKQvAXmOfo7auqP76L2vnUTA1XLzroDLy+DB
	wa/50q7FZQV7TGYdpRqRQQFVmJ+fDnvpQqA7fyZ3RC0dMVNRZCg+uGtVMNV8XJMSKjlVF/pWXGl
	MQ3cuCPlmURwreAtP4j3+5cG7Cvofsm3TmI2G
X-Google-Smtp-Source: AGHT+IFO+uGUU98DqHRAX6nV1kqLGhOV24S8OffXAIkCtdUG1oMVYNt/OYhdrmrpePlnjVGOsEczG5rFBBOpcfVBhKg=
X-Received: by 2002:a05:6102:e0e:b0:492:9ef9:9d1b with SMTP id
 ada2fe7eead31-497599d9241mr403418137.22.1723571070651; Tue, 13 Aug 2024
 10:44:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d2841226-e27b-4d3d-a578-63587a3aa4f3@amd.com> <CAOUHufawNerxqLm7L9Yywp3HJFiYVrYO26ePUb1jH-qxNGWzyA@mail.gmail.com>
 <1998d479-eb1a-4bc8-a11e-59f8dd71aadb@amd.com> <CAOUHufYA-ZAHni1_aDQjjwB5UC9EFYPL_YqVN52DoL3J7SFziQ@mail.gmail.com>
 <7a06a14e-44d5-450a-bd56-1c348c2951b6@amd.com> <CAOUHufa7OBtNHKMhfu8wOOE4f0w3b0_2KzzV7-hrc9rVL8e=iw@mail.gmail.com>
 <0702c85c-abca-4a33-b91b-dadf68670364@gmail.com>
In-Reply-To: <0702c85c-abca-4a33-b91b-dadf68670364@gmail.com>
From: Yu Zhao <yuzhao@google.com>
Date: Tue, 13 Aug 2024 11:43:52 -0600
Message-ID: <CAOUHufYj1oHVy1OnqVMqsYbtMTqyCo-19ZH-UOiz46KDrp8m3w@mail.gmail.com>
Subject: Re: Hard and soft lockups with FIO and LTP runs on a large system
To: Usama Arif <usamaarif642@gmail.com>
Cc: Bharata B Rao <bharata@amd.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	nikunj@amd.com, "Upadhyay, Neeraj" <Neeraj.Upadhyay@amd.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, willy@infradead.org, 
	vbabka@suse.cz, kinseyho@google.com, Mel Gorman <mgorman@suse.de>, leitao@debian.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 5:04=E2=80=AFAM Usama Arif <usamaarif642@gmail.com>=
 wrote:
>
>
>
> On 09/07/2024 06:58, Yu Zhao wrote:
> > On Mon, Jul 8, 2024 at 10:31=E2=80=AFPM Bharata B Rao <bharata@amd.com>=
 wrote:
> >>
> >> On 08-Jul-24 9:47 PM, Yu Zhao wrote:
> >>> On Mon, Jul 8, 2024 at 8:34=E2=80=AFAM Bharata B Rao <bharata@amd.com=
> wrote:
> >>>>
> >>>> Hi Yu Zhao,
> >>>>
> >>>> Thanks for your patches. See below...
> >>>>
> >>>> On 07-Jul-24 4:12 AM, Yu Zhao wrote:
> >>>>> Hi Bharata,
> >>>>>
> >>>>> On Wed, Jul 3, 2024 at 9:11=E2=80=AFAM Bharata B Rao <bharata@amd.c=
om> wrote:
> >>>>>>
> >>>> <snip>
> >>>>>>
> >>>>>> Some experiments tried
> >>>>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>>>> 1) When MGLRU was enabled many soft lockups were observed, no hard
> >>>>>> lockups were seen for 48 hours run. Below is once such soft lockup=
.
> >>>>>
> >>>>> This is not really an MGLRU issue -- can you please try one of the
> >>>>> attached patches? It (truncate.patch) should help with or without
> >>>>> MGLRU.
> >>>>
> >>>> With truncate.patch and default LRU scheme, a few hard lockups are s=
een.
> >>>
> >>> Thanks.
> >>>
> >>> In your original report, you said:
> >>>
> >>>    Most of the times the two contended locks are lruvec and
> >>>    inode->i_lock spinlocks.
> >>>    ...
> >>>    Often times, the perf output at the time of the problem shows
> >>>    heavy contention on lruvec spin lock. Similar contention is
> >>>    also observed with inode i_lock (in clear_shadow_entry path)
> >>>
> >>> Based on this new report, does it mean the i_lock is not as contended=
,
> >>> for the same path (truncation) you tested? If so, I'll post
> >>> truncate.patch and add reported-by and tested-by you, unless you have
> >>> objections.
> >>
> >> truncate.patch has been tested on two systems with default LRU scheme
> >> and the lockup due to inode->i_lock hasn't been seen yet after 24 hour=
s run.
> >
> > Thanks.
> >
> >>>
> >>> The two paths below were contended on the LRU lock, but they already
> >>> batch their operations. So I don't know what else we can do surgicall=
y
> >>> to improve them.
> >>
> >> What has been seen with this workload is that the lruvec spinlock is
> >> held for a long time from shrink_[active/inactive]_list path. In this
> >> path, there is a case in isolate_lru_folios() where scanning of LRU
> >> lists can become unbounded. To isolate a page from ZONE_DMA, sometimes
> >> scanning/skipping of more than 150 million folios were seen. There is
> >> already a comment in there which explains why nr_skipped shouldn't be
> >> counted, but is there any possibility of re-looking at this condition?
> >
> > For this specific case, probably this can help:
> >
> > @@ -1659,8 +1659,15 @@ static unsigned long
> > isolate_lru_folios(unsigned long nr_to_scan,
> >                 if (folio_zonenum(folio) > sc->reclaim_idx ||
> >                                 skip_cma(folio, sc)) {
> >                         nr_skipped[folio_zonenum(folio)] +=3D nr_pages;
> > -                       move_to =3D &folios_skipped;
> > -                       goto move;
> > +                       list_move(&folio->lru, &folios_skipped);
> > +                       if (spin_is_contended(&lruvec->lru_lock)) {
> > +                               if (!list_empty(dst))
> > +                                       break;
> > +                               spin_unlock_irq(&lruvec->lru_lock);
> > +                               cond_resched();
> > +                               spin_lock_irq(&lruvec->lru_lock);
> > +                       }
> > +                       continue;

Nitpick:

if () {
  ...
  if (!spin_is_contended(&lruvec->lru_lock))
    continue;

  if (!list_empty(dst))
    break;

  spin_unlock_irq(&lruvec->lru_lock);
  cond_resched();
  spin_lock_irq(&lruvec->lru_lock);
}


> Hi Yu,
>
> We are seeing lockups and high memory pressure in Meta production due to =
this lock contention as well. My colleague highlighted it in https://lore.k=
ernel.org/all/ZrssOrcJIDy8hacI@gmail.com/ and was pointed to this fix.
>
> We removed skip_cma check as a temporary measure, but this is a proper fi=
x. I might have missed it but didn't see this as a patch on the mailing lis=
t. Just wanted to check if you were planning to send it as a patch? Happy t=
o send it on your behalf as well.

Please. Thank you.

