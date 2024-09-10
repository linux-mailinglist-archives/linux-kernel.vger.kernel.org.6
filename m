Return-Path: <linux-kernel+bounces-322703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 852B3972C86
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 10:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 402AE2846BC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 08:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571921862B8;
	Tue, 10 Sep 2024 08:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M7tfOyc2"
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF50E186E21
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 08:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725958332; cv=none; b=oUtDeYgu9BrM0sSmDYKwxC1j1tvLgCFzxo+57boUawRDJZb7KAgdTEUio0hYH/X6lHoEtq4DSUjlYUlQGPBemfUw97NAnkJRgFHiJSxObsQFu6Pog/KHlgDoV5576FkacqkMDVsSTz8inuFly0Gzj5ilcWbMC9lJT6Evo6VaBm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725958332; c=relaxed/simple;
	bh=yOkPM9wRRO1TMo81gN61dgIMav4o3kxbr/BgxbEhpek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r3b/vzAPhH4vXvwoMWKxKBuWdlWt1QrfXvuTVQ1muynm9Ponn9ELldQhPSnTX8zSeZcMyf3VNW7Q/qKXuCMleLnjWbF5B9HHvu8rtw3gjD6yd+4+Ukv4CY5NrSC/nday4xVv2SmSvb71lUyowocEFv7HiJcPee4FvSU5ERBqneA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M7tfOyc2; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-49bd32f6a11so158646137.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 01:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725958329; x=1726563129; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sJFYmvEycp/4ZX+4oPaDLoVQSwkBcf9SPGVQ9ODBUGA=;
        b=M7tfOyc2N3assf6uS1Yp+p3B1TCT3EE1N6ATcFBjingMTVa9y/t4pFOrTWHyTYThvl
         b099FR3/SRBlC2lkE8fzHa9D0OcpGXmI55ukzgJO4EI5N/pV4Z0Y7LH5M8zig49yiZEc
         rWVUo8o+K1rzj+u32XEam8uKHVIhFQHZNlrYD9xd4wjBEQFC3MvLsprk/mSpdKiBCiB0
         mfRlF2KhrWMwyox68sfVIwMEL0OrWPVWLxD5C78o/1MLnFBepnynOxIOibzybumC+wLz
         /CIKhrDruBYmjk24rqXYl18ciN4Di0KHezQOBTLE7KtKRZoljVhpvlJ7nlCixqgUjxNL
         dWcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725958329; x=1726563129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sJFYmvEycp/4ZX+4oPaDLoVQSwkBcf9SPGVQ9ODBUGA=;
        b=s/EhYcBD2LsCF5SXBoVcrQtws9xDeEGptTJazR/wy/n0VMkGhVzV/WFAUOxsXlgXcG
         H7r4EUWeOtwcyBr4ey/AAd612fqiPDJYwwq+q38MX8Kxhggy0DupKuNNWrSaqgib+NFZ
         Ou63dkolr74A3Z9RZTwfdGbqmAT/HMlKRB07kl2rfKWcB87TZLBGd2vQjSdEExprW4/f
         mkIp6t9sFItEqiY0Y1NoFoxVlknZlN2zbTcmYYt8cBxP4FhD4ZIthjP9IxWnTsdlLatG
         J8+Mtyj9e8IiON9FH89efVEuLfAggVYS2TqjfwGo8XwM6tOI633U9gCn6VEaQxU2eMZX
         F2xQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0W2bFTt6biYi9N7gyyMKdoy699tPl/eMVb+ZMa6MFVnCvie+aPfFxVII5Q9oqm0DcopOrrFR+unqXGhI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtoZfZiu1pUHFuHraGIZe13NUNj2SVIId4SLMl4EbxkQCac9GX
	YcPbT5SOOln0yGbUwCjq9ugku8HxL5GydwOwI06bskX/IjbFZqyuLlbAF2B8/KLByWTDJ3db8M0
	jLDM6O4MQhZ3MhLSwIW7bFluPRtY=
X-Google-Smtp-Source: AGHT+IHrGM9ewKbXyxNA9WVmk4gtj2LN5DtAXs+tjIcKrJgVUhXQ78KitivjcvGMKI16skJyxWLepnvpueNOe3o0AYk=
X-Received: by 2002:a05:6102:ccc:b0:493:b9a0:8ee8 with SMTP id
 ada2fe7eead31-49bece19587mr5744004137.22.1725958329343; Tue, 10 Sep 2024
 01:52:09 -0700 (PDT)
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
 <CAGsJ_4zAf7LuJNOrUSG=kvFQf5Px1mYLMvCyF=q31uwghGY-wA@mail.gmail.com>
 <CA+EESO4MsRxMcTA-_g55rtLE0QTfB3=E53eW8+MSfncwmDx5OQ@mail.gmail.com>
 <1757d01334ee4391beba1ea3dcdfed7c@honor.com> <Zs4TRi61grDvQNdW@google.com> <61f07b0979814462bae19b3cf5a34663@honor.com>
In-Reply-To: <61f07b0979814462bae19b3cf5a34663@honor.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 10 Sep 2024 20:51:58 +1200
Message-ID: <CAGsJ_4xSJw5vEV7Zm=cSoS1xZ=Nx92VYV51TDn2FW3pj05yCKQ@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW1BBVENIIHYyXSBtbTogYWRkIGxhenlmcmVlIGZvbGlvIHRvIGxydQ==?=
	=?UTF-8?B?IHRhaWw=?=
To: gaoxu <gaoxu2@honor.com>
Cc: Minchan Kim <minchan@kernel.org>, Lokesh Gidra <lokeshgidra@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Nicolas Geoffray <ngeoffray@google.com>, Michal Hocko <mhocko@suse.com>, 
	Andrew Morton <akpm@linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Shaohua Li <shli@fb.com>, 
	yipengxiang <yipengxiang@honor.com>, fengbaopeng <fengbaopeng@honor.com>, 
	Kalesh Singh <kaleshsingh@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 3:55=E2=80=AFPM gaoxu <gaoxu2@honor.com> wrote:
>
> > On Tue, Aug 27, 2024 at 04:07:57AM +0000, gaoxu wrote:
> > > >
> > > > On Mon, Aug 26, 2024 at 12:55=E2=80=AFPM Barry Song <21cnbao@gmail.=
com>
> > wrote:
> > > > >
> > > > > On Tue, Aug 27, 2024 at 4:37=E2=80=AFAM Lokesh Gidra <lokeshgidra=
@google.com>
> > > > wrote:
> > > > > >
> > > > > > Thanks Suren for looping in
> > > > > >
> > > > > > On Fri, Aug 23, 2024 at 4:39=E2=80=AFPM Suren Baghdasaryan
> > <surenb@google.com>
> > > > wrote:
> > > > > > >
> > > > > > > On Wed, Aug 21, 2024 at 2:47=E2=80=AFPM Barry Song <21cnbao@g=
mail.com>
> > > > wrote:
> > > > > > > >
> > > > > > > > On Wed, Aug 21, 2024 at 8:46=E2=80=AFPM Michal Hocko
> > <mhocko@suse.com>
> > > > wrote:
> > > > > > > > >
> > > > > > > > > On Fri 16-08-24 07:48:01, gaoxu wrote:
> > > > > > > > > > Replace lruvec_add_folio with lruvec_add_folio_tail in =
the
> > > > lru_lazyfree_fn:
> > > > > > > > > > 1. The lazy-free folio is added to the LRU_INACTIVE_FIL=
E list. If
> > it's
> > > > > > > > > >    moved to the LRU tail, it allows for faster release =
lazy-free
> > folio
> > > > and
> > > > > > > > > >    reduces the impact on file refault.
> > > > > > > > >
> > > > > > > > > This has been discussed when MADV_FREE was introduced. Th=
e
> > > > question was
> > > > > > > > > whether this memory has a lower priority than other inact=
ive
> > memory
> > > > that
> > > > > > > > > has been marked that way longer ago. Also consider severa=
l
> > > > MADV_FREE
> > > > > > > > > users should they be LIFO from the reclaim POV?
> > > > > >
> > > > > > Thinking from the user's perspective, it seems to me that FIFO =
within
> > > > > > MADV_FREE'ed pages makes more sense. As a user I expect the lon=
ger a
> > > > > > MADV_FREE'ed page hasn't been touched, the chances are higher t=
hat it
> > > > > > may not be around anymore.
> > > > > > > >
> > > > >
> > > > > Hi Lokesh,
> > > > > Thanks!
> > > > >
> > > > > > > > The priority of this memory compared to other inactive memo=
ry that
> > has
> > > > been
> > > > > > > > marked for a longer time likely depends on the user's expec=
tations -
> > How
> > > > soon
> > > > > > > > do users expect MADV_FREE to be reclaimed compared with old=
 file
> > > > folios.
> > > > > > > >
> > > > > > > > art guys moved to MADV_FREE from MADV_DONTNEED without any
> > > > > > > > useful performance data and reason in the changelog:
> > > > > > > > https://android-review.googlesource.com/c/platform/art/+/26=
33132
> > > > > > > >
> > > > > > > > Since art is the Android Java heap, it can be quite large. =
This increases
> > the
> > > > > > > > likelihood of packing the file LRU and reduces the chances =
of
> > reclaiming
> > > > > > > > anonymous memory, which could result in more file re-faults=
 while
> > > > helping
> > > > > > > > anonymous folio persist longer in memory.
> > > > > >
> > > > > > Individual heaps of android apps are not big, and even in there=
 we
> > > > > > don't call MADV_FREE on the entire heap.
> > > > >
> > > > > How do you define "Individual heaps of android apps", do you know=
 the
> > usual
> > > > > total_size for a phone with memory pressure by running multiple a=
pps and
> > > > how
> > > > > much for each app?
> > > > >
> > > > Every app is a separate process and therefore has its own private A=
RT
> > > > heap. Those numbers that you are asking vary drastically. But here'=
s
> > > > what I can tell you:
> > > >
> > > > Max heap size for an app is 512MB typically. But it is rarely entir=
ely
> > > > used. Typical heap usage is 50MB to 250MB. But as I said, not all o=
f
> > > > it is MADV_FREE'ed. Only those pages which are freed after GC
> > > > compaction are.
> > > > > > > >
> > > > > > > > I am really curious why art guys have moved to MADV_FREE if=
 we
> > have
> > > > > > > > an approach to reach them.
> > > > > >
> > > > > > Honestly, it makes little sense as a user that calling MADV_FRE=
E on an
> > > > > > anonymous mapping will impact file LRU. That was never the inte=
ntion
> > > > > > with our ART change.
> > > > > >
> > > > >
> > > > > This is just how MADV_FREE is implemented in the kernel, this kin=
d of
> > lazyfree
> > > > > anon folios are moved to file but *NOT* anon LRU.
> > > > >
> > > > > > From our perspective, once a set of pages are MADV_FREE'ed, the=
y are
> > > > > > like a page-cache. It gives an opportunity, without hurting mem=
ory
> > > > > > use, to avoid overhead of page-faults, which happen frequently =
after
> > > > > > GC is done on running apps.
> > > > > >
> > > > > > IMHO, within LRU_INACTIVE_FILE, MADV_FREE'ed pages should be
> > > > > > prioritized for reclamation over file ones.
> > > > >
> > > > > This is exactly what this patch is doing, putting lazyfree anon f=
olios
> > > > > to the tail of file LRU so that they can be reclaimed earlier tha=
n file
> > > > > folios. But the question is: is the requirement "MADV_FREE'ed pag=
es
> > > > > should be prioritized for reclamation over file ones" universally=
 true for
> > > > > all other non-Android users?
> > > > >
> > > > That's definitely an important question to get answered. But puttin=
g
> > > > my users hat on again, by explicitly MADV_FREE'ing we ask for that
> > > > behavior. IMHO, MADV_FREE'ed pages should be the first ones to be
> > > > reclaimed on memory pressure.
> > > For non-Android systems, perhaps the author of MADV_FREE can provide =
a
> > more
> > > reasonable opinion;
> > >
> > > Add Minchan Kim.
> > > Please forgive me for forgetting to add you when sending the patch.
> >
> > AFAIR, there were two concerns:
> >
> > 1. The file LRU would contain pages used only once.
> >
> > While MADV_FREE allows discarding pages under memory pressure, the syst=
em
> > would
> > still have non-working set pages within the file LRU (e.g., those used =
only once).
> >
> >
> > 2. LRU inversion among MADV_FREE users.
> >
> > Consider this time order:
> >
> > 1. A process: MADV_FREE
> > 2. B process: MADV_FREE
> > 3. C process: MADV_FREE
> >
> > The moving tail approach would discard the most recent pages from Proce=
ss C
> > first,
> > instead of those from Process A.
> >
> > Of course, this isn't universally true for all workloads, but it's the =
reality.
> After enabling MGLRU, the implementation of age and evict based on gen di=
lutes the FIFO mechanism. Although the joining time points are different, t=
hey are all reclaimed based on the same gen.
> Android has always been plagued by performance issues caused by high IO. =
Many engineers adjust strategies to prefer reclaiming anon when the system =
is low on memory. For the same reason,
> we believe lazy free folio should prioritize file reclamation.(If I misun=
derstood, please correct me.)
>
> For other discussions that lean towards reclaiming anon folio, please ref=
er to:
> https://patchwork.kernel.org/project/linux-mm/cover/20231108065818.19932-=
1-link@vivo.com/
>
> Adding lazyfree folio to the LRU tail has no impact on the Android system=
, allowing the system to normally utilize the reuse of MADV_FREE when not i=
n a low mem state.
> If added to the file LRU head, the Android system will encounter various =
issues such as high IO and heavy kswapd load, forcing us to prohibit Androi=
d ART from continuing to use MADV_FREE.
> Adding lazyfree folio to the LRU tail is not the best approach, but it is=
 more acceptable compared to adding it to the LRU head.
>
> >
> > At the time, I proposed introducing an additional "ez_reclaimable" LRU =
list to
> > store MADV_FREE pages
> > (and potentially other hinted pages in the future).
> > This would allow differentiating priority among LRU lists based on knob=
s or
> > heuristics.
> This solution looks good, might need to think about how to adapt it to mg=
lru.

That's right. Adapting to MGLRU isn't straightforward. We might need a sepa=
rate
generation smaller than min_seq for this, or alternatively, it could
be handled by
a separate LRU list that isn't tied to any MGLRU generation. both seem hard=
.

> > However, this idea wasn't well-received.

