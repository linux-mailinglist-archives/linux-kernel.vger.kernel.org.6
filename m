Return-Path: <linux-kernel+bounces-429827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D48C79E271F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 17:21:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DE77161893
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 16:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51BB51F8AE0;
	Tue,  3 Dec 2024 16:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OZ+9Nmeu"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87861E2613
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 16:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733242684; cv=none; b=SStRBrYXvIw0QWCOPez/kPHYuZSCyTiNVBt2mYzwWUKcquyfLCkUGJTpCSDDwFGPHD/Dg0mtT5qBBvSrsM5Zx8jSnx8JQu1ZS7skJmKLvOPlCNPtKKB2bEuPkC36XOCbuS45DJsWPdaElc4SNuic1D/5AJGXtem+93TPAgjsi0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733242684; c=relaxed/simple;
	bh=zqmGuKtzUhbp+0ab0kuVrLR/kbiBZSj/b5+95+hTlbs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MEkKSEN58YcpJkfUaFaMYGNPgZUo9vCrUVfYO1hQbLacMWpTCKM2ksKZCQ1eREY4sg3eDlU/KSxko7BK4Xlc8xfYa1o6B5slMtMiNAWWg2K5CbppNQfIvYXH90bGRDuHzffwnQb7PY7lI/IF9z5+Q5yV3SqfZT00cr+Jm8nXK+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OZ+9Nmeu; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ffc81cee68so59058051fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2024 08:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733242681; x=1733847481; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zqmGuKtzUhbp+0ab0kuVrLR/kbiBZSj/b5+95+hTlbs=;
        b=OZ+9NmeuYt9Ccfd7tkaoeZWsMyxI69xtneM7sOAXA9M7ZaODXwSYqVCIlVsXHbACAA
         x8wJRJIyhTy7LQmnBpYRqiMabyazlFa28L/Yx1w0ZHlbhvnKb5iQO0AMgPAvGykuhf3N
         eKMi2BO0D8WriirxIyU0aGOBPI8Wqp0CAlRZn/GMvh86IZyIq/6ivZdhEcc99Ztshu/q
         wFVqVc6rQZEbq7MS1QEcbRb0zeIToQ9Gu9Q5TN6wKDgaszxdrkD6yrq0w6lK2F1yB0iP
         xNzL24yAvpogI/uj/BQhbMLiF/6Dd2wRkZGIf3MTpl30LmduU9pVTJ7IgDFOZv3BgFg4
         buFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733242681; x=1733847481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zqmGuKtzUhbp+0ab0kuVrLR/kbiBZSj/b5+95+hTlbs=;
        b=ruJdmzuoI/IekliwkkABRrZxGA2SyxL6pnAuN6PCstIvZovkMNZA+pRTO6e8Zt3TsJ
         kDNw5VdqmXAgA+1nwR3lFzbI9IBvLuN3qxGkOqB+dQyfEzjMOMMNEdn7QchgGxSz9DPT
         e+62kLWy8mXTJltdeX3zjIF0HGyQWxnNaQ3XkxqarD4cdQcisKZK0SggSPka4cvynGmB
         H6z4gmMDLJ/LitJpdXbZqAFZ8xj0lkswgsvbWm8uBxoxDbACQ91QDiCgBhLCOxjCb/gQ
         dt1l3NxiYapuKFL+qWx3wUIdNbh2DyvUzxzfp4zovtBbuXjLGg4K/ZDzSUE8nGoeRBci
         N9rw==
X-Forwarded-Encrypted: i=1; AJvYcCVY6IfsFTzjoDEv0xpHrrEtC3HUYZfs62dsaSPnOD67rINw/BcZY+1chVQK6aC5hDGSRqrNQtv0mFcKcx0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQbobHDuqJKdWbUCenYVv7W1A/Y8V3m0FTuYxkCJ9drLK93izB
	jCRMzR/L929UAX/QB28IkNuDsD3Laael4Zb76wjDhCkZ4CAUwNT0cHBR7Ral9m+nWzsUqlI8Yfn
	0Yue526s5vfC8+a3+RfESf9B1G3w=
X-Gm-Gg: ASbGncttFpd1OOKusWnXFoIUzedAWcwDVH0iWnvY5w/AZdCtG0/YFRP3APswC2fWaIM
	3gwUn9Av+Cr5XpnBlr45kSiMhstBS
X-Google-Smtp-Source: AGHT+IH4/0E9XbjzYZeqJ56ZkCrmNBorgd3oAhdAoCsg9whUO2EU+pXbRui7fee8vx6r28ulNV7F8O2A5hiofId/cos=
X-Received: by 2002:a2e:a98a:0:b0:2fa:d84a:bd8f with SMTP id
 38308e7fff4ca-30009cab27cmr19183121fa.30.1733242680616; Tue, 03 Dec 2024
 08:18:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241202202058.3249628-1-fvdl@google.com> <3tqmyo3qqaykszxmrmkaa3fo5hndc4ok6xrxozjvlmq5qjv4cs@2geqqedyfzcf>
 <CAPTztWbmkFisL7qnmAnre5hv=UD1E60P0hr_kXNyLoQFy9OoTA@mail.gmail.com>
 <Z070YE81kJ-OnSX8@tiehlicka> <d1f224fb-c0fb-47f9-bea8-3c33137be161@oracle.com>
 <CAGudoHGY_NEJe6Pp6rv91v8p--phSX32C5Pm55c6jpUAJFLKmA@mail.gmail.com>
In-Reply-To: <CAGudoHGY_NEJe6Pp6rv91v8p--phSX32C5Pm55c6jpUAJFLKmA@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Tue, 3 Dec 2024 17:17:48 +0100
Message-ID: <CAGudoHHmko_=JwMrORryCQOF5baLTJRbi2x8yLp2s91F_xL57Q@mail.gmail.com>
Subject: Re: [PATCH] mm/hugetlb: optionally pre-zero hugetlb pages
To: Joao Martins <joao.m.martins@oracle.com>
Cc: Michal Hocko <mhocko@suse.com>, Frank van der Linden <fvdl@google.com>, linux-mm@kvack.org, 
	akpm@linux-foundation.org, Muchun Song <muchun.song@linux.dev>, 
	Miaohe Lin <linmiaohe@huawei.com>, Oscar Salvador <osalvador@suse.de>, 
	David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 4:57=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> wr=
ote:
>
> On Tue, Dec 3, 2024 at 3:26=E2=80=AFPM Joao Martins <joao.m.martins@oracl=
e.com> wrote:
> >
> > On 03/12/2024 12:06, Michal Hocko wrote:
> > > If the startup latency is a real problem is there a way to workaround
> > > that in the userspace by preallocating hugetlb pages ahead of time
> > > before those VMs are launched and hand over already pre-allocated pag=
es?
> >
> > It should be relatively simple to actually do this. Me and Mike had exp=
erimented
> > ourselves a couple years back but we never had the chance to send it ov=
er. IIRC
> > if we:
> >
> > - add the PageZeroed tracking bit when a page is zeroed
> > - clear it in the write (fixup/non-fixup) fault-path
> >
> > [somewhat similar to this series I suspect]
> >
> > Then what's left is to change the lookup of free hugetlb pages
> > (dequeue_hugetlb_folio_node_exact() I think) to search first for non-ze=
roed
> > pages. Provided we don't track its 'cleared' state, there's no UAPI cha=
nge in
> > behaviour. A daemon can just allocate/mmap+touch/etc them with read-onl=
y and
> > free them back 'as zeroed' to implement a userspace scrubber. And in pr=
inciple
> > existing apps should see no difference. The amount of changes is conseq=
uently
> > significantly smaller (or it looked as such in a quick PoC years back).
> >
> > Something extra on the top would perhaps be the ability so select a loo=
kup
> > heuristic such that we can pick the search method of
> > non-zero-first/only-nonzero/zeroed pages behind ioctl() (or a better ge=
neric
> > UAPI) to allow a scrubber to easily coexist with hugepage user (e.g. a =
VMM, etc)
> > without too much of a dance.
> >
>
> Ye after the qemu prefaulting got pointed out I started thinking about
> a userlevel daemon which would do the work proposed here.
>
> Except I got stuck at a good way to do it. The mmap + load from the
> area + munmap triple does work but also entails more overhead than
> necessary, but I only have some handwaving how to not do it. :)
>
> Suppose a daemon of the sort exists and there is a machine with 4 or
> more NUMA domains to deal with. Further suppose it spawns at least one
> thread per such domain and tasksets them accordingly.
>
> Then perhaps an ioctl somewhere on hugetlbfs(?) could take a parameter
> indicating how many pages to zero out (or even just accept one page).
> This would avoid crap on munmap.
>
> This would still need majority of the patch, but all the zeroing
> policy would be taken out. Key point being that whatever specific
> behavior one sees fit, they can implement it in userspace, preventing
> future kernel patches to add more tweaks.

How about this for a rough sketch (which I have 0 intention of
implementing myself):

/dev/hugepagectl or whatever is created with a bunch of ioctls, notably:
- something to query hugepage stats
- an event generated for epoll if count in any domain goes below a threshol=
d
- something to zero a page of given size from the free list

Perhaps make it so that fds require an upfront ioctl to set a numa
domain of interest before poll works -- for example if there is one
thread per domain, each of them sleeps on its own relevant fd. Or
maybe someone still wants the main thread to get the full view so they
poll on all of them.

then a google internal tool can react however it sees fit without
waking up in a periodic fashion. (replace google with any other
company which may want to mess with this).

optional:
- allocating and zeroing (but not mmaping!) a page

then a party which shares the file descriptor could obtain it by
passing the fd to mmap. munmap would just free it as it does now. this
would allow qemu et al to avoid the mmap/munmap dance just to zero,
but I don't know how useful it is for them

--=20
Mateusz Guzik <mjguzik gmail.com>

