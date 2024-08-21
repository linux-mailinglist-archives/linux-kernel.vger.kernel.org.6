Return-Path: <linux-kernel+bounces-294745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5261B9591F5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 02:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5D061F239DB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 00:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B695E18E2A;
	Wed, 21 Aug 2024 00:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ncJYtE3u"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D860495E5
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 00:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724201522; cv=none; b=hmXjuwKSQ2tcGgC/3IB6JwDmIy8PRmJYxzbZYl8Erv3OjUOaWKRUSSE0Wt6omY7lalvdW0r0owRNaM2PwAc5949GYfJ2lVZzmGDTT4GzY0SWhvpjBy75ZR+ylSKQfNpT2WyFVwGL4ii77Y0vMzfoENCsHn/rzV+6yi5QHlSeoXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724201522; c=relaxed/simple;
	bh=i/N+69G40ywTa/bb+N8dXxUssHAE9EXNU0fE505RoWk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dWLfmt6rFEnBY+WkZhAF8vaCKKt1xL8iSjiaUsfCE++rifoVhyZr4jY9EoJXypzThzosaBnPAYzsXJB6CHmV414+OCvfTiD9lyIBUkTnHbn3AR9PMZWnFUdKjdY/8nGn4rRFk7yziZRQl/+czhf8pyJjeZUOXg4IhMaBlbYD/p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ncJYtE3u; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-533446e53b5so47441e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 17:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724201518; x=1724806318; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YED1s2NlUy4sx0Bb0LTzlsmbFJV3dBZkqQc5zTeHHAI=;
        b=ncJYtE3uSd/aUQDNxnAjRIUlPVqP4Cut4iyLpoeUgRJPQNfaS/NAwPANrMj8xJtnDx
         +RXQ2oEPvBcKd7j2qIlWhy5ZFnoF0+MY+jNBaZTy/wWKAHvUU0LdHJXnabFI20yXgwwo
         GSYT0fHJXeMl0pGj9PsmvRtwQiSBE/cSv1hlX2srdf1gmhuXCZZJiZqTlvxi0yvEiMxc
         cvYlTuxuEwrZpUEmXeYj6nSCPy8e9LDp2FvVtFu2mOL90NujF0o/m3xo2G5ZFnt3dpFw
         Wq9PMo9pVIehH4YpTArkvA/HD2u7K4BvAw0KHXJdfJDCB26ooh7VEH2L1RXzy7rbj7ut
         Zsow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724201518; x=1724806318;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YED1s2NlUy4sx0Bb0LTzlsmbFJV3dBZkqQc5zTeHHAI=;
        b=suHLLKR41+AWJxuynfGvh2K0F0QirR3V5SQYnJb4gkOJTVZzmb0fC5JJebxog+xrHc
         8uHsiCSBnMDNVWWHo219IOrQe/X29f7/KtZJgp34TTJeL2N+M+gqyjVFI8qeTcsCd1qB
         b95s00OEC16VZxt5APC4gxxaEHLdJ9UAw8aBonkfBNJaDWtLa8I3dDLjT/5eiy5i8DnT
         PKIimqP1TSytp2PglQC+Z4GGxCJeHK1O/QbpakraV3PHcQcgtemhLhUEWWk7He0IkN6O
         qgi8PXJ7p2qa1akOWmK+VpPSq6BNbJg3B5H38PrYGIMnMCZxU++ICUQC9MWxkO6xg7ST
         W63A==
X-Forwarded-Encrypted: i=1; AJvYcCWwPmG5FWKDWqBYRWJXp1rEOqf7mRp8fuHe61LzflFAX95swIYt8XAB44t16x59Ai294md/JIBHoxxKHpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yytxlmkcc+BxsKppoNPRuoROVUuI60Cizu+cgOp/h75WLKi0jTD
	65lJr9pGSQJLmwv/gQdx/n7szKmpvqmW2Q/FAD78HZEwvAp0DjoYt+oc6xzzRY/qYRwPyu6tnbD
	8WAxQ3R7NL8KURX3O4YUwOfu1QAI=
X-Google-Smtp-Source: AGHT+IFfdURqjhlqRM/sXcxGKPtFCyHYSmES6CQOtCteQfo4LTG1K8SwO+Oycp9mbEOybOkjfc5MLeuhZ7lZcCfkMyM=
X-Received: by 2002:a05:6512:114d:b0:533:dde:bf07 with SMTP id
 2adb3069b0e04-5334858bf0dmr163810e87.5.1724201517657; Tue, 20 Aug 2024
 17:51:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819184648.2175883-1-usamaarif642@gmail.com>
 <20240819181743.926f37da3b155215c088c809@linux-foundation.org> <29e481af-b5e1-4320-a672-8251f5099595@gmail.com>
In-Reply-To: <29e481af-b5e1-4320-a672-8251f5099595@gmail.com>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Wed, 21 Aug 2024 08:51:46 +0800
Message-ID: <CAGWkznFLUcyyqW9yGA-Sy6+Y22yqt0C5cWkxZnpq9VarPiH7gQ@mail.gmail.com>
Subject: Re: [PATCH RESEND] mm: drop lruvec->lru_lock if contended when
 skipping folio
To: Usama Arif <usamaarif642@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, yuzhao@google.com, david@redhat.com, 
	leitao@debian.org, bharata@amd.com, willy@infradead.org, vbabka@suse.cz, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	Johannes Weiner <hannes@cmpxchg.org>, zhaoyang.huang@unisoc.com, 
	Rik van Riel <riel@surriel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 20, 2024 at 11:45=E2=80=AFPM Usama Arif <usamaarif642@gmail.com=
> wrote:
>
>
>
> On 20/08/2024 02:17, Andrew Morton wrote:
> > On Mon, 19 Aug 2024 19:46:48 +0100 Usama Arif <usamaarif642@gmail.com> =
wrote:
> >
> >> lruvec->lru_lock is highly contended and is held when calling
> >> isolate_lru_folios. If the lru has a large number of CMA folios
> >> consecutively, while the allocation type requested is not MIGRATE_MOVA=
BLE,
> >> isolate_lru_folios can hold the lock for a very long time while it
> >> skips those. vmscan_lru_isolate tracepoint showed that skipped can go
> >> above 70k in production and lockstat shows that waittime-max is x1000
> >> higher without this patch.
> >> This can cause lockups [1] and high memory pressure for extended perio=
ds of
> >> time [2]. Hence release the lock if its contended when skipping a foli=
o to
> >> give other tasks a chance to acquire it and not stall.
> >>
> >> ...
> >>
> >> --- a/mm/vmscan.c
> >> +++ b/mm/vmscan.c
> >> @@ -1695,8 +1695,14 @@ static unsigned long isolate_lru_folios(unsigne=
d long nr_to_scan,
> >>              if (folio_zonenum(folio) > sc->reclaim_idx ||
> >>                              skip_cma(folio, sc)) {
> >>                      nr_skipped[folio_zonenum(folio)] +=3D nr_pages;
> >> -                    move_to =3D &folios_skipped;
> >> -                    goto move;
> >> +                    list_move(&folio->lru, &folios_skipped);
> >> +                    if (!spin_is_contended(&lruvec->lru_lock))
> >> +                            continue;
> >> +                    if (!list_empty(dst))
> >> +                            break;
> >> +                    spin_unlock_irq(&lruvec->lru_lock);
> >> +                    cond_resched();
> >> +                    spin_lock_irq(&lruvec->lru_lock);
> >>              }
> >
> > Oh geeze ugly thing.  Must we do this?
> >
> > The games that function plays with src, dst and move_to are a bit hard
> > to follow.  Some tasteful comments explaining what's going on would
> > help.
> >
> > Also that test of !list_empty(dst).  It would be helpful to comment the
> > dynamics which are happening in this case - why we're testing dst here.
> >
> >
>
> So Johannes pointed out to me that this is not going to properly fix the =
problem of holding the lru_lock for a long time introduced in [1] because o=
f 2 reasons:
> - the task that is doing lock break is hoarding folios on folios_skipped =
and making the lru shorter, I didn't see it in the usecase I was trying, bu=
t it could be that yielding the lock to the other task is not of much use a=
s it is going to go through a much shorter lru list or even an empty lru li=
st and would OOM, while the folio it is looking for is on folios_skipped. W=
e would be substituting one OOM problem for another with this patch.
Other tasks can not get folios either if they can not use CMA after
the reclaiming even without the original patch. I am ok with your fix
patch except the 'if (!list_empty(dst))' puzzled me.
> - Compaction code goes through pages by pfn and not using the list, as th=
is patch does not clear lru flag, compaction could claim this folio.
>
> The patch in [1] is severely breaking production at Meta and its not a pr=
oper fix to the problem that the commit was trying to be solved. It results=
 in holding the lru_lock for a very significant amount of time, stalling al=
l other processes trying to claim memory, creating very high memory pressur=
e for large periods of time and causing OOM.
>
> The way forward would be to revert it and try to come up with a longer te=
rm solution that the original commit tried to solve. If no one is opposed t=
o it, I will wait a couple of days for comments and send a revert patch.
I mainly focus on android systems which have no such scenarios as
server encountered. I agree with reverting it if this fix can not be
accepted.
>
> [1] https://lore.kernel.org/all/1685501461-19290-1-git-send-email-zhaoyan=
g.huang@unisoc.com/
>
> Thanks,
> Usama

