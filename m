Return-Path: <linux-kernel+bounces-302460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8337495FEF7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 04:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E6681F225CC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 02:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C3F1401C;
	Tue, 27 Aug 2024 02:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X6d/Ra16"
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DAC2F22
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 02:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724725317; cv=none; b=uemrh4LCuKtF6ndWgWxZpeQCmbfp5R2gI6szyrTyU75NQ9XgU1DDMHmk+9IPingTCxEP4Bw5QKApe7UBKOp42gayqvpo9dUxueS6/y1M7nQy7s6gT3VIensbm37rxidI67J8yFxeZyy3XXJIJ0G/wm2xG+dHX709MougUo1/dFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724725317; c=relaxed/simple;
	bh=EQhzT51nmgr5WpNqOqvHg6ov5tKDoc5taml+lWZ4Wd0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n24Tg4bqMK61P+Q09I0AUZACm65oW73EDvFoclfWcWgzUdYjAQc4LuYAiPwpfpjR4IrCbQxkLxujYgRtLbYgmMzTmlEvUnN4eounxvRXs3b+nmsI1njQz+dfO6CJlGbQHaQXrMWc9wdcz/d91rEi+j3kIEti5KF2YnT9m2InMFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X6d/Ra16; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-4fcfcd21235so1294075e0c.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 19:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724725314; x=1725330114; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/GXXn2FFJ/DjUCmJ68K445AX+nSevjwrVhmRcNlSs/g=;
        b=X6d/Ra16M7zkO4KIST5SvXtArJcp7I7UtpbR8JHuxQ0sYoeMdwlAaBUC0mIAn7+THp
         CSKQeUYbXwacJbgr3He1laXFUQD/PM00qc5maeId6D+Mz+I4KX7W8Aqw8pnpuh/oVkV4
         9YH8aHKyblhAPAwwco7XHBQv417QX+lTlfSfHNWEbdnNiiXqEjB0k0wz0Ga4Q2nXBn+s
         FvdGp2tvG6NcbvqC4flhaqfI/rkBw9o0WLSak8lNU/lW+l0h6jrSggGLlNNtaad22+Oa
         cHlr1TtNjvRr8A1UcURxzx21LIr1++iSFGX/35inhYZyb2EccpIgkHyGhYau5SVt+z4A
         M1xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724725314; x=1725330114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/GXXn2FFJ/DjUCmJ68K445AX+nSevjwrVhmRcNlSs/g=;
        b=pxZ9pNW/vAEh5L2ohrlDnxPEalH95fsTK4iurglwNUGbmss8aBb2OTasWVtb0k695F
         JghMbkXq/3qsnosqBWNCAdhz5oRKp+5Qos3hFCslVgggLv/GSs32tOUbx5Kpl++DDFCC
         zXowiI6eNVct8n7ccsE19U1bMRyvvJWP1AgeNfTrMnXuF4RABrbb7UGTwCeeamDqQAGQ
         Ftxb3O+ZrYwir5l78g6aHu+fDT5MHh+883aubCiIn/2lbD+PkY5/zkat6INay7FDGZIY
         E/maSOFilJQtYID6vMwd+548KN4IKMwMQLKkQgc6MJV+Bp4obSgpwexlBSDkhpM0y2IS
         qzXw==
X-Forwarded-Encrypted: i=1; AJvYcCVCYGTTfgk+n0OQTabuOgm4uX96QH56x5LTAX+lJ+FozDdb4sG7jxz/jZYbR4S8MHDUv0nSIdTYeGyGgh4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh5J532WcGUaSG3wsCPAPEhCLTU/SD5mN5glUnFC89BGxSmfKd
	Wh8aYKhkeZJjMcgzYmgMix3yFXDFK5uD++p1PRS5qwaL3+MUuAmfQBZl78E6OlEVwAvNXEAyyJj
	wq8pMg5umugThi6Aj9zBPQVzfRnU=
X-Google-Smtp-Source: AGHT+IFGRvVJKZzhsvIzEksY/0kJq2esAYdnR/hYST+sLJhvuxKLuA+bnUtkW1bRSeHDHtzpNDWBtSfoHkRl0ef8st0=
X-Received: by 2002:a05:6122:2a13:b0:4fc:e3c2:2c71 with SMTP id
 71dfb90a1353d-4fed5d674bcmr1868769e0c.2.1724725313688; Mon, 26 Aug 2024
 19:21:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f29f64e29c08427b95e3df30a5770056@honor.com> <ZsXho27uAbQ5rEgS@tiehlicka>
 <CAGsJ_4zgQ0MBV-yucc0-7BcDgjMMdCUDWK330mrd7SS4ej6Q8Q@mail.gmail.com>
 <CAJuCfpE7qsbFPseGzcBp27uNDhwtKLypKiPnqebE5=T8WDTyEQ@mail.gmail.com>
 <CA+EESO7BuywqjM9pk3KbgdfsYJerpU1-5d9AN20mBjA6e_97UQ@mail.gmail.com>
 <CAGsJ_4zAf7LuJNOrUSG=kvFQf5Px1mYLMvCyF=q31uwghGY-wA@mail.gmail.com> <CA+EESO4MsRxMcTA-_g55rtLE0QTfB3=E53eW8+MSfncwmDx5OQ@mail.gmail.com>
In-Reply-To: <CA+EESO4MsRxMcTA-_g55rtLE0QTfB3=E53eW8+MSfncwmDx5OQ@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 27 Aug 2024 14:21:42 +1200
Message-ID: <CAGsJ_4xhcjt6QMOfqsGK8_EpPHORAeHmPLusmirS1vg_ss1=tA@mail.gmail.com>
Subject: Re: [PATCH v2] mm: add lazyfree folio to lru tail
To: Lokesh Gidra <lokeshgidra@google.com>
Cc: Suren Baghdasaryan <surenb@google.com>, Nicolas Geoffray <ngeoffray@google.com>, 
	Michal Hocko <mhocko@suse.com>, gaoxu <gaoxu2@honor.com>, 
	Andrew Morton <akpm@linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Shaohua Li <shli@fb.com>, 
	yipengxiang <yipengxiang@honor.com>, fengbaopeng <fengbaopeng@honor.com>, 
	Kalesh Singh <kaleshsingh@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 27, 2024 at 12:12=E2=80=AFPM Lokesh Gidra <lokeshgidra@google.c=
om> wrote:
>
> On Mon, Aug 26, 2024 at 12:55=E2=80=AFPM Barry Song <21cnbao@gmail.com> w=
rote:
> >
> > On Tue, Aug 27, 2024 at 4:37=E2=80=AFAM Lokesh Gidra <lokeshgidra@googl=
e.com> wrote:
> > >
> > > Thanks Suren for looping in
> > >
> > > On Fri, Aug 23, 2024 at 4:39=E2=80=AFPM Suren Baghdasaryan <surenb@go=
ogle.com> wrote:
> > > >
> > > > On Wed, Aug 21, 2024 at 2:47=E2=80=AFPM Barry Song <21cnbao@gmail.c=
om> wrote:
> > > > >
> > > > > On Wed, Aug 21, 2024 at 8:46=E2=80=AFPM Michal Hocko <mhocko@suse=
.com> wrote:
> > > > > >
> > > > > > On Fri 16-08-24 07:48:01, gaoxu wrote:
> > > > > > > Replace lruvec_add_folio with lruvec_add_folio_tail in the lr=
u_lazyfree_fn:
> > > > > > > 1. The lazy-free folio is added to the LRU_INACTIVE_FILE list=
. If it's
> > > > > > >    moved to the LRU tail, it allows for faster release lazy-f=
ree folio and
> > > > > > >    reduces the impact on file refault.
> > > > > >
> > > > > > This has been discussed when MADV_FREE was introduced. The ques=
tion was
> > > > > > whether this memory has a lower priority than other inactive me=
mory that
> > > > > > has been marked that way longer ago. Also consider several MADV=
_FREE
> > > > > > users should they be LIFO from the reclaim POV?
> > >
> > > Thinking from the user's perspective, it seems to me that FIFO within
> > > MADV_FREE'ed pages makes more sense. As a user I expect the longer a
> > > MADV_FREE'ed page hasn't been touched, the chances are higher that it
> > > may not be around anymore.
> > > > >
> >
> > Hi Lokesh,
> > Thanks!
> >
> > > > > The priority of this memory compared to other inactive memory tha=
t has been
> > > > > marked for a longer time likely depends on the user's expectation=
s - How soon
> > > > > do users expect MADV_FREE to be reclaimed compared with old file =
folios.
> > > > >
> > > > > art guys moved to MADV_FREE from MADV_DONTNEED without any
> > > > > useful performance data and reason in the changelog:
> > > > > https://android-review.googlesource.com/c/platform/art/+/2633132
> > > > >
> > > > > Since art is the Android Java heap, it can be quite large. This i=
ncreases the
> > > > > likelihood of packing the file LRU and reduces the chances of rec=
laiming
> > > > > anonymous memory, which could result in more file re-faults while=
 helping
> > > > > anonymous folio persist longer in memory.
> > >
> > > Individual heaps of android apps are not big, and even in there we
> > > don't call MADV_FREE on the entire heap.
> >
> > How do you define "Individual heaps of android apps", do you know the u=
sual
> > total_size for a phone with memory pressure by running multiple apps an=
d how
> > much for each app?
> >
> Every app is a separate process and therefore has its own private ART
> heap. Those numbers that you are asking vary drastically. But here's
> what I can tell you:
>
> Max heap size for an app is 512MB typically. But it is rarely entirely

On my phone, I am seeing a VMA named "dalvik-main space", its
virtual address is 0x14000000-0x34000000 and its size is 0x20000000
(512MB). I guess this is exactly the ART heap we are talking about?

> used. Typical heap usage is 50MB to 250MB. But as I said, not all of

Thank you! Considering we might have dozens of apps running in the
background and foreground, will the total size of the ART heaps on a
phone still be large?

> it is MADV_FREE'ed. Only those pages which are freed after GC
> compaction are.

Are you saying that some memory in the ART heap is marked with
MADV_DONTNEED instead of MADV_FREE? If so, when did this happen?
Alternatively, is my understanding incorrect and you are referring to memor=
y
that is neither MADV_DONTNEED nor MADV_FREE?

> > > > >
> > > > > I am really curious why art guys have moved to MADV_FREE if we ha=
ve
> > > > > an approach to reach them.
> > >
> > > Honestly, it makes little sense as a user that calling MADV_FREE on a=
n
> > > anonymous mapping will impact file LRU. That was never the intention
> > > with our ART change.
> > >
> >
> > This is just how MADV_FREE is implemented in the kernel, this kind of l=
azyfree
> > anon folios are moved to file but *NOT* anon LRU.
> >
> > > From our perspective, once a set of pages are MADV_FREE'ed, they are
> > > like a page-cache. It gives an opportunity, without hurting memory
> > > use, to avoid overhead of page-faults, which happen frequently after
> > > GC is done on running apps.
> > >
> > > IMHO, within LRU_INACTIVE_FILE, MADV_FREE'ed pages should be
> > > prioritized for reclamation over file ones.
> >
> > This is exactly what this patch is doing, putting lazyfree anon folios
> > to the tail of file LRU so that they can be reclaimed earlier than file
> > folios. But the question is: is the requirement "MADV_FREE'ed pages
> > should be prioritized for reclamation over file ones" universally true =
for
> > all other non-Android users?
> >
> That's definitely an important question to get answered. But putting
> my users hat on again, by explicitly MADV_FREE'ing we ask for that
> behavior. IMHO, MADV_FREE'ed pages should be the first ones to be
> reclaimed on memory pressure.

Thanks for clarification! I'd also like to collect some performance data wi=
th
this patch.

> > > >
> > > > Adding Lokesh.
> > > > Lokesh, could you please comment on the reasoning behind the above
> > > > mentioned change?
> > >
> > > Adding Nicolas as well, in case he wants to add something.
> > > >
> > > > >
> > > > > >
> > > > > > --
> > > > > > Michal Hocko
> > > > > > SUSE Labs
> > > > > >
> > > > >
> >

Thanks
Barry

