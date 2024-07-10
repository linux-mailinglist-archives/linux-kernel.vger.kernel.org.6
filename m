Return-Path: <linux-kernel+bounces-248317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33BB792DBA8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jul 2024 00:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C7B2B20DD0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 22:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1BF145FE9;
	Wed, 10 Jul 2024 22:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GScWEtYm"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99143AC0C;
	Wed, 10 Jul 2024 22:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720649414; cv=none; b=PK7HJQNjIj7+XdlGKdBqtWJAx0BC3YrsK/DDFNcxwEoYnEyY4VQIP1x8F6EESiyeZQIrWbdA/VJEp3mHQTAZFyakm6YnFJWgka9xLMUYCP0xR+zIvMoDvWaPYU+QDkCj5tdOMGKZTWUFjfO3gZw+OdgbeHIuZFKtpz5h8LrSERI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720649414; c=relaxed/simple;
	bh=b+KDBfyJTvpOZK52j2sic8bzlpb8x3Gm1lYmzzPuA/c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LLhYFuSA/CDnhHZjbvrBYq/nfmUffJ78PAtbp6YRxlZvgVj8tii+iwhzjQaL0CZu9a2dPGuwqCy9s/eJesstzzkKUa3XPLKxWtSGnjMKsGdre+OASGpKo8usguKRO0gmUf1O6aKp0hPmyqXni7T6NTQh23Lbd670N+uKGrh822Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GScWEtYm; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6b73dc6e7aaso2019546d6.0;
        Wed, 10 Jul 2024 15:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720649411; x=1721254211; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZVjrUx+weY5vD7cc11tkTR78ZpLmg3aZMvb61tjOLWY=;
        b=GScWEtYm0IbPYb/Tw9ZUG7lBKVlKtNFow2vS86VFn9lWccMuWlfksev4Oyx6WVFWSi
         0WmEdbeA2eAfXQhGiOS1yESkrciVQrfL62LI/RSj4L9DpQoT8ldbx8vt0iRsqTa3lB0P
         GIhcz0zXp0VDfzP+XRmWQo/gqBgNA0X1Golx7+iuNGVNNDVfrvW7P8KuOYeOZBJQ5LWr
         Iy/do2rismvls9koBiAYVF5DzgD1VQ/Sz7Jvojp0cAOAqYUEkVIGfRQPuzn4fQc1FyU5
         jgFGxOXrJkK5S5aEhOTTq53mxuZGGC/WiNhEDTeMhccZbEuLSPeB7EZY/i5W5fKj5NCc
         up7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720649411; x=1721254211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZVjrUx+weY5vD7cc11tkTR78ZpLmg3aZMvb61tjOLWY=;
        b=qGeI3RNw8pLIs7DN/pzyD2zA0oiQxpRxUiH/3EcozBGyoDLznWrxqCXvqxo+w4dYUF
         MFTkqzaDZm29PZ8sgUeyrc/xTh7/pA5fY+LTQ0I6E5fBY6JOxLB3im4JyYm0zr/v7Q67
         ZDlcmOPC3YJ50KzfWg25mNOzN4T8D6pUTwHZXR4714Nn24YIcUiXEjFkEF/Vc44UlYmg
         xMUyAihKMhWUNZ4YApW4OjMi2gjzKFDL+9y/JVxVqhiUf02/nRqMrYUy0vvnCEGu2vw2
         wPP0E2NVhNocuDxu1LM/oX6RBRfI0qqgg3Ubb1t8FcgOFZ5Il5DAB4dz5PStuVX9IY/Z
         +oBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVBRRMnbeql8i9bktddrYw4ZRBe6XGbTKcj9YTAXMJ5h0gLiIaSB4A9XpKWjP6Ix1SQAl9SUqFrGAWNNEvOa1xoAOGadtvK0eAg5zPgvnzKJoTplStFbL3bR64stoq+JzEX2Kve6pj
X-Gm-Message-State: AOJu0YxEKs/oA637aaj7ys8a9+2tMK4hoN2e19544Cdtqy4f7u0mFKqc
	XJo0SMvWNny0Fb335ZLEEgKWlslOZ8xbbMe1N+5jWt5TzrLgvQe/q5yBxgDRCc3JVGiToZygSKX
	vZIkOMef6THsG5gLAj/gwIeZLgEc=
X-Google-Smtp-Source: AGHT+IGZPx0x7zW5guu7Qw+p3cdui2ZtjmYISMR5K/xNjwu28e4BdvnWdG95ho4IIMQE0Fb1eXVE0yO/B6kn0DRHGqA=
X-Received: by 2002:a05:6214:d01:b0:6b5:49c9:ed53 with SMTP id
 6a1803df08f44-6b61bf4c959mr83436136d6.37.1720649411397; Wed, 10 Jul 2024
 15:10:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240706022523.1104080-1-flintglass@gmail.com>
 <20240706022523.1104080-7-flintglass@gmail.com> <CAKEwX=NJjDL3aW3hXioxh=yASSsHbDBWubV9cE2RiH+tSXpscw@mail.gmail.com>
 <CAPpoddfpU1rN5ST49vBBJ_=MHKehQQrwsz_hwBd6xyzi4-uQkQ@mail.gmail.com>
In-Reply-To: <CAPpoddfpU1rN5ST49vBBJ_=MHKehQQrwsz_hwBd6xyzi4-uQkQ@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 10 Jul 2024 15:10:00 -0700
Message-ID: <CAKEwX=OJyrBdCJDLV2v7wLh+hz4Mh1Kjr2Te1eds8JvUY+Jm5w@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] mm: zswap: interrupt shrinker writeback while
 pagein/out IO
To: Takero Funaki <flintglass@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Domenico Cerasuolo <cerasuolodomenico@gmail.com>, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 2:21=E2=80=AFPM Takero Funaki <flintglass@gmail.com=
> wrote:
>
> 2024=E5=B9=B47=E6=9C=889=E6=97=A5(=E7=81=AB) 4:17 Nhat Pham <nphamcs@gmai=
l.com>:
>
> >
> > Do you see this problem actually manifesting in real life? Does not
> > sound infeasible to me, but I wonder how likely this is the case.
> >
> > Do you have any userspace-visible metrics, or any tracing logs etc.
> > that proves that it actually happens?
> >
> > This might also affect the dynamic shrinker as well FWIW.
> >
>
> Although it is rare, on a small VM with 0.5GB RAM, performing `apt
> upgrade` for ubuntu kernel update degrades system responsiveness.
> Since kernel upgrade is memory consuming for zstd compressed
> initramfs, there is heavy memory pressure like the benchmark.
>
> Unfortunately I could not get evidence that clearly indicates the
> contention. Perhaps IO latency can be a metric?

IO latency, IO pressure, etc. I'm not sure either, as I do not have
the benchmark setup at hand - just throwing out ideas :)

> While allocating large memory, perf showed that __swap_writepage() was
> consuming time and was called mostly from kswapd and some fraction
> from user faults of python script and from shrink_worker. CPU was
> mostly idling even in a single CPU system, so lock contention and
> compression should not be the reason. I believe these behaviors
> suggest contention on writeback IO.

Sounds fair to me.

> As shown in the benchmark,  reducing shrinker writeback by patches 3
> to 6 reduced elapsed time, which also indicates IO contention.
>
> > > +/*
> > > + * To avoid IO contention between pagein/out and global shrinker wri=
teback,
> > > + * track the last jiffies of pagein/out and delay the writeback.
> > > + * Default to 500msec in alignment with mq-deadline read timeout.
> >
> > If there is a future version, could you include the reason why you
> > select 500msec in the patch's changelog as well?
> >
>
> The 500ms can be any value longer than the average interval of each
> pageout/in and is not significant for behavior. If subsequent pageout
> rejection occurs while the shrinker is sleeping, writeback will be
> delayed again by 500ms from the last timestamp update. If pageout
> occurs at a 1ms interval on average, the minimal delay should be 1+ms.
>
> I chose 500ms from the mq-deadline scheduler that tries to perform
> read IO in a 500ms timeframe by default (bfq for HDD uses a shorter
> timeout).
> When the shrinker performs writeback IO with a 500ms delay from the
> last pagein, the write IO will be of lower priority than the read IO
> waiting in the queue, as the pagein read becomes the highest priority
> by the deadline. This logic emulates low-priority write IO by
> voluntarily delaying IO.
>
>
> >
> > Hmmm is there a reason why we do not just do:
> >
> > zswap_shrinker_delay_start =3D jiffies;
> >
> > or, more unnecessarily:
> >
> > unsigned long now =3D jiffies;
> >
> > zswap_shrinker_delay_start =3D now;
> >
> > IOW, why the branching here? Does not seem necessary to me, but
> > perhaps there is a correctness/compiler reason I'm not seeing?
> >
> > In fact, if it's the first version, then we could manually inline it.
> >
>
> That was to avoid invalidating the CPU cache of the shared variable
> unnecessarily. Removing the branch and manually inlining it for v3.

Ah I see. Seems a tad overengineering IMHO, but I'll leave this up to you.

If you keep the current version, please add a comment.

>
>
> > Additionally/alternatively, I wonder if it is more convenient to do it
> > at the mm/page_io.c zswap callsites, i.e whenever zswap_store() and
> > zswap_load() returns false, then delay the shrinker before proceeding
> > with the IO steps.
> >
>
> Should we expose the timestamp variable? It is only used in zswap
> internally, and the timestamp is not required when zswap is disabled.

Not necessarily the timestamp. If you keep the helper, you can just
expose that helper (and have a no-op when !CONFIG_ZSWAP in the zswap.h
header file).


>
> > >         do {
> > > +               /*
> > > +                * delay shrinking to allow the last rejected page co=
mpletes
> > > +                * its writeback
> > > +                */
> > > +               sleepuntil =3D delay + READ_ONCE(zswap_shrinker_delay=
_start);
> >
> > I assume we do not care about racy access here right? Same goes for
> > updates - I don't see any locks protecting these operations (but I
> > could be missing something).
> >
>
> Right. Do we need atomic or spinlock for safety?
>  I think the bare store/load of unsigned long is sufficient here. The
> possible deviation by concurrent updates is mostly +/-1 jiffy. Sleep
> does not need ms accuracy.
>
> Ah, I found a mistake here. v2 missed continue statement in the loop.
> The delay should be extended if zswap_store() rejects another page. In
> v2, one writeback was allowed per 500ms, which was not my intended
> behavior.
> The corrected logic for v3 should be:
>
>                if (time_before(now, sleepuntil) &&
>                                time_before(sleepuntil, now + delay + 1)) =
{
>                        fsleep(jiffies_to_usecs(sleepuntil - now));
>                        /* check if subsequent pageout/in extended delay *=
/
>                        continue;
>                }
>
>
> 2024=E5=B9=B47=E6=9C=889=E6=97=A5(=E7=81=AB) 9:57 Nhat Pham <nphamcs@gmai=
l.com>:
> >
> > Hmm what about this scenario: when we disable zswap writeback on a
> > cgroup, if zswap_store() fails, we are delaying the global shrinker
> > for no gain essentially. There is no subsequent IO. I don't think we
> > are currently handling this, right?
> >
> > >
> > > The same logic applies to zswap_load(). When zswap cannot find reques=
ted
> > > page from pool and read IO is performed, shrinker should be interrupt=
ed.
> > >
> >
> > Yet another (less concerning IMHO) scenario is when a cgroup disables
> > zswap by setting zswap.max =3D 0 (for instance, if the sysadmin knows
> > that this cgroup's data are really cold, and/or that the workload is
> > latency-tolerant, and do not want it to take up valuable memory
> > resources of other cgroups). Every time this cgroup reclaims memory,
> > it would disable the global shrinker (including the new proactive
> > behavior) for other cgroup, correct? And, when they do need to swap
> > in, it would further delay the global shrinker. Would this break of
> > isolation be a problem?
> >
> > There are other concerns I raised in the cover letter's response as
> > well - please take a look :)
>
> I haven't considered these cases much, but I suppose the global
> shrinker should be delayed in both cases as well. In general, any
> pagein/out should be prefered over shrinker writeback throughput.
>
> When zswap writeback was disabled for a memcg
> (memcg.zswap.writeback=3D0), I suppose disabling/delaying writeback is
> harmless.
> If the rejection incurs no IO, there is no more memory pressure and
> shrinking is not urgent. We can postpone the shrinker writeback. If
> the rejection incurs IO (i.e. mm choose another page from a memcg with
> writeback enabled), again we should delay the shrinker.

You are delaying writeback globally right? IOW, other cgroup is also affect=
ed?

Say we are under memory pressure, with two cgroups under reclaim - one
with zswap writeback disabled. The one with writeback disabled will
constantly fail at zswap_store(), and delay the global shrinking
action, which could have targeted the other cgroup (which should
proceed fully because there is no contention here since the first
cgroup is not swapping either).

>
> For pageout from latency-tolerant memcg (zswap.max=3D0), I think pageout
> latency may affect other memcgs.
> For example, when a latency-sensitive workload tries to allocate
> memory, mm might choose to swap out pages from zswap-disabled memcg.
> The slow direct pageout may indirectly delay allocation of the
> latency-sensitive workload. IOW, we cannot determine which workload
> would be blocked by a slow pageout based on which memcg owns the page.
> In this case, it would be better to delay shrinker writeback even if
> the owner is latency tolerant memcg.
> Also for pagein, we cannot determine how urgent the pagein is.
>
> Delaying shrinker on any pagein/out diminishes proactive shrinking
> progress, but that is still better than the existing shrinker that
> cannot shrink.

This is fair though :)

