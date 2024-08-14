Return-Path: <linux-kernel+bounces-287126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E5B95234F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 22:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 795D81C21495
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 20:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379A51C579D;
	Wed, 14 Aug 2024 20:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y2nzp383"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994361BE86D
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 20:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723666963; cv=none; b=a/C/Rz30GrLnB8Tm3IfG0IjJ9vx89wbvA/1yS+7V55a7+EXiukOo2hLeJtsCqKPhIDSzCRhezP87I1zR3IcnXKJnV5JpyXcnBEK/6EAAKotj0SPIBZLoYaPwEUIbyrCcDQ8OdcVf+dWRGZOf1yVqX7gC/pm6rucw2cB81/DZ3ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723666963; c=relaxed/simple;
	bh=2f7WeL/F6hdyZXXE2Ld3C8xDMLscvOaz+ELyawQJbHM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HolxE+BOJTkbTwh2PCtrKRLG3RMnU63Y0BgoXnMNwEWqBDKZUAHfehrNaHjm1CMnSjaDEC11PI0+qPSPFu39eRBe90VgYdz7M8mcR6Cv4BTcuXfH/62IG+TvSgDnmJm1cCfGHv5rW7xV9H1sPO3fN79YE4OuCMQJVULr+6Ar5Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y2nzp383; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5bba25c1e15so485353a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 13:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723666960; x=1724271760; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2f7WeL/F6hdyZXXE2Ld3C8xDMLscvOaz+ELyawQJbHM=;
        b=Y2nzp383hm/P9Ds87Lnz1p1kg8hSmdwWSfPNT0GitZTIy2xevbY4xye8VqV119CDzT
         L7AJCH87qNHT3Z7b9dOPam0W15OO2BObY6frJcX55q+8wvwKacCSyKy1cDQuOskBoG4+
         ZrTO9Q1eKaTBYc8+P7XpmL11mC+jVSIE2x6PTtosheZe1JHFZWfHD5P9aGVfDNvONXhO
         7U8skFNyEMTHY76n0Ae5qoPWBFBa790KDLc/DpzdTyXAd0dZnYhVaMfCaT4oo7LIUekL
         HfNbwFJ1Nq7X/4zjI+B/TgadGzJAGSEmRHsqs3JlaygUezWlA+05EWqWBNNeucdHOKWO
         tXcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723666960; x=1724271760;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2f7WeL/F6hdyZXXE2Ld3C8xDMLscvOaz+ELyawQJbHM=;
        b=GWlrmsDQT12NXr0EKr7RdWDQl4kZgrXFkru4ZyyqSi9jdGZuUaDME4jHPgZ4epuoa1
         qSy9EWSMKYhmN7QRXiCl8ai/ibXbuUoTph4JYut2ZlHcoBE4pceG3mzsYN7evvdBmmz4
         OlGM3HEfNyZ3TG8e4nF1CJfZoQbkOz6b2DJ3TZ+7GLoG7sLOdDn78Qiwl+jxV7vj4RwV
         xKbs4Tcom8RkuzLAxfV36V67DjP3XfLfjPkuHHGecgEH8eBIaAXhCmewpxWZKkDmNUa4
         xzkr1S6FO9EaR+op8YIXUraPMjtmgsv2yfjotbBUSWrzmAxla2A7iGofl83kSCBpFVb8
         5QQg==
X-Forwarded-Encrypted: i=1; AJvYcCWQA7ul0QShylhFxF3Inqe4Wygfl6v3fP9vyRp7GzI61+wVJ5KCj+G4xJUNbvIN0D4F11m/4QWh15eiun+ZmxBHtuY2xqDK7/0q98xu
X-Gm-Message-State: AOJu0YwZ7uP4FH23jUPi9qiQELuimO193FOVgP0CJMwz6a+Wv/esBpqX
	ECBz1Fhwknm6yoaxFkYdrphT2LPmw71ZxEmsSaAzJrvp/vLz1kR7ksYI7fYkfZe24RuEEMR4ZAm
	OsxuhI6EMlFjmIMERni/XF+y/QWMCPMOa8PwO
X-Google-Smtp-Source: AGHT+IHwQ61fqTYGKDPjIPhRrXO7HDN0W2Mhl5Sz3JZ411uPh3wwlcX72uzM3/bHwcG34/XBmX+WMrAIjLKBdz4lwIQ=
X-Received: by 2002:a17:906:4fc7:b0:a7a:a5ae:11bd with SMTP id
 a640c23a62f3a-a83670723e6mr287623166b.67.1723666959052; Wed, 14 Aug 2024
 13:22:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814171800.23558-1-me@yhndnzj.com> <CAKEwX=NrOBg0rKJnXGaiK9-PWeUDS+c3cFmaFFV0RrE8GkNZZA@mail.gmail.com>
In-Reply-To: <CAKEwX=NrOBg0rKJnXGaiK9-PWeUDS+c3cFmaFFV0RrE8GkNZZA@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 14 Aug 2024 13:22:01 -0700
Message-ID: <CAJD7tkZ_jNuYQsGMyS1NgMf335Gi4_x5Ybkts_=+g5OyjtJQDQ@mail.gmail.com>
Subject: Re: [PATCH] mm/memcontrol: respect zswap.writeback setting from
 parent cg too
To: Nhat Pham <nphamcs@gmail.com>
Cc: Mike Yuan <me@yhndnzj.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Muchun Song <muchun.song@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Michal Hocko <mhocko@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 12:52=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrot=
e:
>
> On Wed, Aug 14, 2024 at 10:20=E2=80=AFAM Mike Yuan <me@yhndnzj.com> wrote=
:
> >
> > Currently, the behavior of zswap.writeback wrt.
> > the cgroup hierarchy seems a bit odd. Unlike zswap.max,
> > it doesn't honor the value from parent cgroups. This
> > surfaced when people tried to globally disable zswap writeback,
> > i.e. reserve physical swap space only for hibernation [1] -
> > disabling zswap.writeback only for the root cgroup results
> > in subcgroups with zswap.writeback=3D1 still performing writeback.
> >
> > The consistency became more noticeable after I introduced
> > the MemoryZSwapWriteback=3D systemd unit setting [2] for
> > controlling the knob. The patch assumed that the kernel would
> > enforce the value of parent cgroups. It could probably be
> > workarounded from systemd's side, by going up the slice unit
> > tree and inherit the value. Yet I think it's more sensible
> > to make it behave consistently with zswap.max and friends.
>
> May I ask you to add/clarify this new expected behavior in
> Documentation/admin-guide/cgroup-v2.rst?
>
> >
> > [1] https://wiki.archlinux.org/title/Power_management/Suspend_and_hiber=
nate#Disable_zswap_writeback_to_use_the_swap_space_only_for_hibernation
>
> This is an interesting use case. Never envisioned this when I
> developed this feature :)
>
> > [2] https://github.com/systemd/systemd/pull/31734
> >
> > Signed-off-by: Mike Yuan <me@yhndnzj.com>
> > ---
>
> Personally, I don't feel too strongly about this one way or another. I
> guess you can make a case that people want to disable zswap writeback
> by default, and only selectively enable it for certain descendant
> workloads - for convenience, they would set memory.zswap.writeback =3D=3D
> 0 at root, then enable it on selected descendants?
>
> It's not super expensive IMHO - we already perform upward traversal on
> every zswap store. This wouldn't be the end of the world.
>
> Yosry, Johannes - how do you two feel about this?

I wasn't CC'd on this, but found it by chance :) I think there is a
way for the zswap maintainers entry to match any patch that mentions
"zswap", not just based on files, right?

Anyway, both use cases make sense to me, disabling writeback
system-wide or in an entire subtree, and disabling writeback on the
root and then selectively enabling it. I am slightly inclined to the
first one (what this patch does).

Considering the hierarchical cgroup knobs work, we usually use the
most restrictive limit among the ancestors. I guess it ultimately
depends on how we define "most restrictive". Disabling writeback is
restrictive in the sense that you don't have access to free some zswap
space to reclaim more memory. OTOH, disabling writeback also means
that your zswapped memory won't go to disk under memory pressure, so
in that sense it would be restrictive to force writeback :)

Usually, the "default" is the non-restrictive thing, and then you can
set restrictions that apply to all children (e.g. no limits are set by
default). Since writeback is enabled by default, it seems like the
restriction would be disabling writeback. Hence, it would make sense
to inherit zswap disabling (i.e. only writeback if all ancestors allow
it, like this patch does).

What we do today dismisses inheritance completely, so it seems to me
like it should be changed anyway.

I am thinking out loud here, let me know if my reasoning makes sense to you=
.

>
> Code looks solid to me - I think the upward tree traversal should be
> safe, as long as memcg is valid (since memcg holds reference to its
> parent IIRC).
>

