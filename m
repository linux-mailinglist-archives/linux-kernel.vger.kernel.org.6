Return-Path: <linux-kernel+bounces-259355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B65C9394AB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 22:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EDF81F2180E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 20:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7086A208CA;
	Mon, 22 Jul 2024 20:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="USgNB1AN"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09731BDD5
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 20:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721679195; cv=none; b=rE/Bf1vKJXYmiSls/kGO2MDPeDBOAd1HGBssRs++XxpLxPoGx3ADGaavnWQdgK55NDpOcjl8AIXTii0DTs8gAX1495U4HZ+GHiC98MQOpk2sfVveecuU9NHXXuJgvyFhw4/0DCf9DX88DvEwSwUVFDdGfp1lkzBBxOBk7V8LCls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721679195; c=relaxed/simple;
	bh=2DLshzPVIVPJzHaNLihZvokorjuIGDPme5uHAlgV1PU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c6e6OzbosVi3X3M6/RWAjXZ5KPREL4wCjWcWpBVEI8d5aPubcPIIsxWsBROYD2C835ibW3A9azvTwiKucR/jElb8GyyAmN3G49H0v3lTENkqaINKh+XWVDqfKY92hRWnc6NU6mnJXqj6ouxvIYT2nCQDs2zRA9EdGYbfHiNfa3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=USgNB1AN; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a6fd513f18bso441925366b.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 13:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721679192; x=1722283992; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uJd3T01oYiu8j24gOC/Fh6PQsujZog8KkMGblRRhmrY=;
        b=USgNB1ANsd/80P2vvqoaDhTbCX7W8WtAbGDLAf3FrrbWA87jjuoa8bPMjLyu7Pdabv
         xtXZwPvEzf+rdM2pZ/baNOACDYUBdeg9GA5l9i8o1PADAZnDOWqI18UtX46r554RyIqs
         S17t2Zwqnn4ZDK5ktzbaj+tT/FiLPl41dC6r0O0N/Ac5fZ/xBqdmb3HVnikoEQJWqOax
         uPIBAoST557QxAColNB3H9+H5vZNG0b53Q7bnnUu40hvIpRZ9k2VkAOMnTv+NadVRa02
         jT60Qlm3pPeUYe+yBiuh9KZ4fA9cAihkgXHHkXUtiLXAvC9GfDDBUWQtrA3XaNpRpVvq
         7UYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721679192; x=1722283992;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uJd3T01oYiu8j24gOC/Fh6PQsujZog8KkMGblRRhmrY=;
        b=wLpXaetBYmS4PuRaaEFbq9bnxpjYTa+5sjsdqXDGzHhMsghlA2fvob9QF4meN4hO2a
         feyPrKu3wN01UfOPhbr0tYMZRp5KuMqO2r5FedOWWdp4nKWKdtX5RjFElKMIhFht4DIO
         so1hN24sgWh0UvGsmZl0DM/3N+0DzGG/v3eXv0JJpyN+QV1Tz9kGFL6DOUtdEWX3eQrr
         Ukg80369DLHp85lLe8HV/ViBW2DELeg04SjSxlRCZZnuBAssJPP1fTQzck2VvFvkpdiy
         LEaqtt6XDLEHCYMeCoLgVIq62yHQkaGdcr/T3LY0fjYMbNfpmKKFk5bBy6fXpxVRzSGA
         BSRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXa8pmSuL4wMDio9H2W1mmwEvwTRjLIXyQrZWK8uqRryZgiq0PUjX2TD8SkgvugNzkt5ijRE8IO+1Ks5fb/xjtRjNKXtX7yi9W3HzcZ
X-Gm-Message-State: AOJu0YwW3DB8D+oBikZyNIlwVkRZYd2uiYo2NtoC8CQ2KrkjgMe60XXH
	fRUjzBImJMZ3iNr8jLaC3FB4auv8Z7aJDKwYLIdQpIADwzgARIOyzrby4cR+QVgoGC2RDwp9PKI
	JMlCGXBrKllLK1/OPRXrgwx4XkHYofWeQKgyC
X-Google-Smtp-Source: AGHT+IHCjnNfOg3AA/xVJEkipAdE4qARcHS7Iri9W3Xj51is2F8E2h6wLQ5Ncs2KJuGZQiG6jIsE2XCmE+iY3tHppiY=
X-Received: by 2002:a17:907:97cd:b0:a6e:d339:c095 with SMTP id
 a640c23a62f3a-a7a8847a8f6mr69961866b.47.1721679191779; Mon, 22 Jul 2024
 13:13:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <172070450139.2992819.13210624094367257881.stgit@firesoul>
 <a4e67f81-6946-47c0-907e-5431e7e01eb1@kernel.org> <CAJD7tkYV3iwk-ZJcr_==V4e24yH-1NaCYFUL7wDaQEi8ZXqfqQ@mail.gmail.com>
 <100caebf-c11c-45c9-b864-d8562e2a5ac5@kernel.org> <k3aiufe36mb2re3fyfzam4hqdeshvbqcashxiyb5grn7w2iz2s@2oeaei6klok3>
 <5ccc693a-2142-489d-b3f1-426758883c1e@kernel.org> <iso3venoxgfdd6mtc6xatahxqqpev3ddl3sry72aoprpbavt5h@izhokjdp6ga6>
 <CAJD7tkYWnT8bB8UjPPWa1eFvRY3G7RbiM_8cKrj+jhHz_6N_YA@mail.gmail.com> <t5vnayr43kpi2nn7adjgbct4ijfganbowoubfcxynpewiixvei@7kprlv6ek7vd>
In-Reply-To: <t5vnayr43kpi2nn7adjgbct4ijfganbowoubfcxynpewiixvei@7kprlv6ek7vd>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 22 Jul 2024 13:12:35 -0700
Message-ID: <CAJD7tkZV3PF7TR2HWxXxkhhS8oajOwX1VG7czdTQb8tRY9Jwpw@mail.gmail.com>
Subject: Re: [PATCH V7 1/2] cgroup/rstat: Avoid thundering herd problem by
 kswapd across NUMA nodes
To: Shakeel Butt <shakeel.butt@linux.dev>, Jesper Dangaard Brouer <hawk@kernel.org>
Cc: tj@kernel.org, cgroups@vger.kernel.org, hannes@cmpxchg.org, 
	lizefan.x@bytedance.com, longman@redhat.com, kernel-team@cloudflare.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2024 at 1:02=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> On Fri, Jul 19, 2024 at 09:52:17PM GMT, Yosry Ahmed wrote:
> > On Fri, Jul 19, 2024 at 3:48=E2=80=AFPM Shakeel Butt <shakeel.butt@linu=
x.dev> wrote:
> > >
> > > On Fri, Jul 19, 2024 at 09:54:41AM GMT, Jesper Dangaard Brouer wrote:
> > > >
> > > >
> > > > On 19/07/2024 02.40, Shakeel Butt wrote:
> > > > > Hi Jesper,
> > > > >
> > > > > On Wed, Jul 17, 2024 at 06:36:28PM GMT, Jesper Dangaard Brouer wr=
ote:
> > > > > >
> > > > > [...]
> > > > > >
> > > > > >
> > > > > > Looking at the production numbers for the time the lock is held=
 for level 0:
> > > > > >
> > > > > > @locked_time_level[0]:
> > > > > > [4M, 8M)     623 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@        =
       |
> > > > > > [8M, 16M)    860 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@=
@@@@@@@|
> > > > > > [16M, 32M)   295 |@@@@@@@@@@@@@@@@@                            =
       |
> > > > > > [32M, 64M)   275 |@@@@@@@@@@@@@@@@                             =
       |
> > > > > >
> > > > >
> > > > > Is it possible to get the above histogram for other levels as wel=
l?
> > > >
> > > > Data from other levels available in [1]:
> > > >  [1]
> > > > https://lore.kernel.org/all/8c123882-a5c5-409a-938b-cb5aec9b9ab5@ke=
rnel.org/
> > > >
> > > > IMHO the data shows we will get most out of skipping level-0 root-c=
group
> > > > flushes.
> > > >
> > >
> > > Thanks a lot of the data. Are all or most of these locked_time_level[=
0]
> > > from kswapds? This just motivates me to strongly push the ratelimited
> > > flush patch of mine (which would be orthogonal to your patch series).
> >
> > Jesper and I were discussing a better ratelimiting approach, whether
> > it's measuring the time since the last flush, or only skipping if we
> > have a lot of flushes in a specific time frame (using __ratelimit()).
> > I believe this would be better than the current memcg ratelimiting
> > approach, and we can remove the latter.
> >
> > WDYT?
>
> The last statement gives me the impression that you are trying to fix
> something that is not broken. The current ratelimiting users are ok, the
> issue is with the sync flushers. Or maybe you are suggesting that the new
> ratelimiting will be used for all sync flushers and current ratelimiting
> users and the new ratelimiting will make a good tradeoff between the
> accuracy and potential flush stall?

The latter. Basically the idea is to have more informed and generic
ratelimiting logic in the core rstat flushing code (e.g. using
__ratelimit()), which would apply to ~all flushers*. Then, we ideally
wouldn't need mem_cgroup_flush_stats_ratelimited() at all.

*The obvious exception is the force flushing case we discussed for
cgroup_rstat_exit().

In fact, I think we need that even with the ongoing flusher
optimization, because I think there is a slight chance that a flush is
missed. It wouldn't be problematic for other flushers, but it
certainly can be for cgroup_rstat_exit() as the stats will be
completely dropped.

The scenario I have in mind is:
- CPU 1 starts a flush of cgroup A. Flushing complete, but waiters are
not woke up yet.
- CPU 2 updates the stats of cgroup A after it is flushed by CPU 1.
- CPU 3 calls cgroup_rstat_exit(), sees the ongoing flusher and waits.
- CPU 1 wakes up the waiters.
- CPU 3 proceeds to destroy cgroup A, and the updates made by CPU 2 are los=
t.

