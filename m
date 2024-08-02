Return-Path: <linux-kernel+bounces-272823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC0694619F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 18:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89AC31F224E2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 16:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277D11537A0;
	Fri,  2 Aug 2024 16:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QZENU/kZ"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857821A83D5
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 16:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722615094; cv=none; b=sOU82QI4efVZWNJGLuJ4KLfyRlOGy7BtBwJrB42ZGpes+g2YCBMn3Zuv4Ts4FjKcqLvE5EYby2ZiyLMw7DpTbjeWC6fAxSk2k8YVlb//6xt3TLYXHkzY41mvxjPRDRU+p7S+Ilq1jrAk0fwWWRf6wwTjsWpNLl7vEAfhck29Qzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722615094; c=relaxed/simple;
	bh=/DSfTtxn+/vucKERqa2i2kiMdVpjCpBQvKmAqAZLey8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B23BQCbOtSQ6Mt8eLJvNG4XpmhbRNOZm94z5hu9YVZyQ8AKUZA6AFXD+PAbOtTULCL7S+GEwDB97XcRqqu4WFNH1/FwdVOiJhOnBzq4VaRWm5dNBb0FMZCHY5bEuaAzKnwqMCwcu+GxXw8MuIEP1FsPoN2vS6Y60cYoSXGWTHHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QZENU/kZ; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a7ab5fc975dso767002566b.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 09:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722615090; x=1723219890; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aq+V7tIZ4SVhLEkffkvPe2h7pXCT1loXoSAK6ImEdLQ=;
        b=QZENU/kZ+l51R4Tsdambtb3ebMxC254hpFb2FsPHwSbQNTLSyUPBjeMBJcyvHzcNzq
         xPId8wCtuh67ReMxS900UxvC7DrGMV2/Ic6MD81kzxmj23jhMHYcG5FCnA5uHQlkf12m
         0RM4+wFDKiVxKibCDjWDQOqN+33VP1BCa5qOLsHfctRQO8gkYnlx86Fcvl8+D53B6SNC
         mfRQauig28QxXO8dVidixK0pOiGREx+eK+Jt9gAtwl5Ei2P0ca4vWAbEz36YLcTt5eAn
         C5rNIGK5lc5ZajKk7E0EDMnp5NAxsX4qH3T9wnMcv5bqKTUqzyrJN0YW1TWsyxx0dncY
         hA/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722615090; x=1723219890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aq+V7tIZ4SVhLEkffkvPe2h7pXCT1loXoSAK6ImEdLQ=;
        b=JlLGGDB4oMh20m+F0UqxR1+MGNuXuSP3T4vvFwGRYD9BvfhPXJd2iOkA799Rwu9V9k
         /oIMBJlXi0bP2Jb55s61UBYZRQP4MmrDkJucGbl/X1L35dMaOfLoBJf6LHUij/dgUe1m
         KMPMskBza6oI6d7Or9CqrfPxnWjSJJ8LPhd0bSACaApZX2dU7jhLjt9sJKjSn5Oy6f4D
         S33/MrFCsNJ3zu5+J4uSbpn+uH3RgrdlnUHc2klwhvZ0HBzj66uqclpFkyMSUob/WG8h
         4yQeZzIS7xxkld9KFsxw8WTOUiX4LkqAzFDq/3jxGGRLnGkKyurhPYI8ODdW82NvRhpX
         y4Gg==
X-Forwarded-Encrypted: i=1; AJvYcCWcGv9sdGL+gw2GAtYlEWT/JZSOLuGC4g6y71QF6ipvuh20r1Z8X5WhewASCTmEfdGEFSGsBYsLaDU89zJOuVPmMBQDwP93dc3KOyxO
X-Gm-Message-State: AOJu0YwyxNrOA1CWNgqqCVuy3A08cPSYbRwjqMJVpypRKpeAx+ScSgdf
	h2CKHY6f5jdtHoDsI/VgCakH7JCILx9ZT+lGoAhCqQmfIRQlBrQGyKnAWVB1xt2BPAH2qkDuhZN
	B1YQGsxQ2CROMqzm95WIjsuFoQaNI/DwzOqA/
X-Google-Smtp-Source: AGHT+IHn1JKs7M+6B7ipAt+vMTtY97ynjMO8RepS7WO1SGKTKodx/tcEcGxw5ix4N3R93xXO6kJsj0HWYTe6g4sOnn0=
X-Received: by 2002:a17:907:1c19:b0:a7a:8876:4429 with SMTP id
 a640c23a62f3a-a7dc506f5aamr352379666b.45.1722615089045; Fri, 02 Aug 2024
 09:11:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <172139415725.3084888.13770938453137383953.stgit@firesoul>
 <CAJD7tkaVwpYWu_c+vgr7mJiWzFofq9jmx-hyOx1i5kkHWc62dg@mail.gmail.com>
 <c55f852b-39b7-4bf9-a054-0e7933912730@kernel.org> <CAJD7tkaZuiSCj4RZ2v6jOCtwiv++YNQxA0x6MEp-HrHaYO6_9g@mail.gmail.com>
 <ee0f7d29-1385-4799-ab4b-6080ca7fd74b@kernel.org>
In-Reply-To: <ee0f7d29-1385-4799-ab4b-6080ca7fd74b@kernel.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Fri, 2 Aug 2024 09:10:51 -0700
Message-ID: <CAJD7tkYL-az+bSXH-CYBLJS2FQ6WtNDOSsxnUZhkixHeBrBmbg@mail.gmail.com>
Subject: Re: [PATCH V8 1/2] cgroup/rstat: Avoid flushing if there is an
 ongoing overlapping flush
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: tj@kernel.org, cgroups@vger.kernel.org, shakeel.butt@linux.dev, 
	hannes@cmpxchg.org, lizefan.x@bytedance.com, longman@redhat.com, 
	kernel-team@cloudflare.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 2, 2024 at 4:43=E2=80=AFAM Jesper Dangaard Brouer <hawk@kernel.=
org> wrote:
>
>
>
> On 30/07/2024 20.54, Yosry Ahmed wrote:
> > [..]
> >>
> >> Well... I'm still not convinced that it makes sense to have level >=3D=
 2
> >> be the ongoing flusher.
> >>
> >> E.g. if a level 2 cgroup becomes ongoing flusher, and kswapd starts 12
> >> NUMA flushes at the same time, then the code will have these 12 kswapd
> >> threads spin on the lock, until ongoing flusher finishes. That is like=
ly
> >> what happened above (for a level 1).  These 12 spinning (root) flusher=
s
> >> will not recheck ongoing_flusher and will all flush the root
> >> (unnecessarily 11 times).
> >
> > Hmm regardless of whether or not the level-2 cgroup becomes the
> > ongoing flusher, the kswapd threads will all spin on the lock anyway
> > since none of them can be the ongoing flusher until the level-2 cgroup
> > finishes. Right?
> >
> > Is the scenario you have in mind that the level-2 cgroup starts
> > flushing at the same time as kswapd, so there is a race on who gets to
> > be the ongoing flusher? In this case as well, whoever gets the lock
> > will be the ongoing flusher anyway.
> >
> > Not allowing whoever is holding the lock to be the ongoing flusher
> > based on level is only useful when we can have multiple ongoing
> > flushers (with lock yielding). Right?
> >
> > Perhaps I am missing something here.
> >
> >>
> >> So, I don't think it is a good idea to have anything else that the roo=
t
> >> as the ongoing flusher.
> >>
> >> Can you explain/convince me why having sub-cgroups as ongoing flusher =
is
> >> an advantage?
> >
> > I just don't see the benefit of the special casing here as I mentioned
> > above. If I missed something please let me know.
> >
>
> I do think you missed something. Let me try to explain this in another
> way. (I hope my frustrations doesn't shine through).
>
> The main purpose of the patch is/was to stop the thundering herd of
> kswapd thread flushing (root-cgrp) at exactly the same time, leading to
> lock contention. This happens all-the-time/constantly in production.
>
> The first versions (where ongoing was limited to root/level=3D0) solved
> this 100%.  The patches that generalized this to be all levels can
> become ongoing flush, doesn't solve the problem any-longer!
>
> I hope it is clear what fails. E.g. When a level>0 becomes ongoing
> flusher, and 12 kswapd simultaneously does a level=3D0/root-cgrp flush,
> then we have 12 CPU cores spinning on the rstat lock. (These 12 kswapd
> threads will all go-through completing the flush, as they do not
> discover/recheck that ongoing flush was previously became their own level=
).

I think we may be speaking past one another, let me try to clarify :)

I agree with your assessment, all I am saying is that this restriction
is only needed because of lock yielding, and can be removed after that
IIUC.

The problem when we allow non-root ongoing flushers now is that when
the kswapd thread are woken up and the first one of them gets the lock
and does the flush, it may be find that the ongoing_flusher is already
set by another non-root flusher that yielded the lock. In this case,
the following kswapd flushers will spin on the lock instead of waiting
for the first kswapd to finish.

If we remove lock yielding, then the above scenario cannot happen.
When the lock/mutex is held by a flusher, it is guaranteed that
ongoing_flusher is NULL and can be set by the flusher. In this case,
we should allow any cgroup to be the ongoing_flusher because there can
only be one anyway.

Does this make sense to you?

>
> I think we need to go back to only having root-cgroup as ongoing flusher.
>
> --Jesper

