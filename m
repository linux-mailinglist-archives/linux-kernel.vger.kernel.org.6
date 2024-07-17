Return-Path: <linux-kernel+bounces-255444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63EAD9340C6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 18:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB1C81F21FBD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 16:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC901822DC;
	Wed, 17 Jul 2024 16:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wnGQ3ZL9"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD8B181B9A
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 16:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721235039; cv=none; b=Aafl6fDPwHQzFSlt09Z0aTEMKuFvqq5RsH/h9H5XKEzBk3J0GsuumRY8FKwwS5vpg6oEemOofZdEfFNAdnV3DSSgw0s86y4RoLsphSpNM9RdrejhEVsIZZ12x20USYx112bwOWH6MAnOh+JHOZnTqoNEKpYWl8QE6tctwtCiFGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721235039; c=relaxed/simple;
	bh=brMoMeNLF25cQ84wJRpgrYCmQeirKUbdzKcB39u7okY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LfpYi5bSUhPQmGWTfnGiMLVvU7MtNWLkrW3nM0F/k3dPTslLAhv//hexFeEoFeF7EN0J1Qn+zE8XdZiQ0Haa9tQPaa1bjWrZSKsnHNGX24tQxUwtxSm3pyCAtg1TwxuXqVTVnjfwQKtPZeN7UWXDP/KL/3SCDr8C5EvISrhGVJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wnGQ3ZL9; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a77e6dd7f72so806348666b.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 09:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721235033; x=1721839833; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xTNGHnvQ6RG3vz/xqvoqZtrVCx1QoR7aN9z9QUd/56U=;
        b=wnGQ3ZL9zMkQNxejkYrlTO0dQ9R3qjI0W9ghbVcB17X+OFkZuZnSGsWEHXIotc431z
         0HjHzFF/DNzCuqGgJmRC39+i1VR3s0xPaDvBwMlMQWAyJFaJXI6XdLqKfnlOn8Xeu0xK
         Bq0S4q3ecq/lytqbKcQz8/Jv5NBuDaEjzzuzaPn7FoyQEDnS2e8GV7gtR/eYGYR4isE5
         NXvqTsKNw/UBmIS3Na8sgXPcK1+GjYE2CUz59XvwWZl8ZSKVWRN98bmaJULNAmnjPt6m
         ERWDBOMhWhTQWUMjRGPCIskFBGSN/QAidWByC5/rzf+uqy/7Yhw4SB/IxMfh9a11vlzB
         rPdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721235033; x=1721839833;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xTNGHnvQ6RG3vz/xqvoqZtrVCx1QoR7aN9z9QUd/56U=;
        b=b8W0wSyNho2l8EfKuQwQMKMW9NygP2dH2MBWRQJ2cBZgSKVa6y/fm7lAU0rSwFvOJy
         +XZdVn3dnRtn6VTO70QtBO3vojmAiqg3UUBg0PwMlojck+AAjTcYOSn7kC4bPO9GJ2/Z
         5JXKPnaLxd3gNA7yBl1K2Vpj7saYZX56xz54Hqqiv/08ScHjDQtXfOoNNGnLJ2kDZwxh
         iqfoyqRAyy0YRJObY/FCrYt/yYt23Rg2JBxGujQP8eVU2Im3DwFIv/iJNnrnCKbOqvTE
         7VTof33vPjJSitEbw7LqWXYCRkl87jLguPIr0M/3P5a2XFbRdyQILdSh3NKSydctisUa
         jPUA==
X-Forwarded-Encrypted: i=1; AJvYcCXBp+GMK2K4E3IcoZgQjQ979SDayP31Eac3/NghFz5h3ER9LgQwP7nLUKs+6qzvPDmNcF27yYXl1cXa4S13anWMAfkh5IYa4MQJpumS
X-Gm-Message-State: AOJu0YzQQjrTfA297od8PwPVCSQjVvcAGF3jQEdKcntnbA4hAtqJh7DK
	rgqG1UfCWPuokTrPhujBVFSE4+tbmrO9v6bFn22rGk1QxpzFRyZAH729vYKXwA439uwCU1gDrck
	MdXbh+Nar4NzqWHjMpoWqu+DMOGNdiB+pwaL6
X-Google-Smtp-Source: AGHT+IGqZ84dAhFoS4O9crcKXggKs4NB/xqx5YRXOru5heEmpY3ot7CFAr2+9x16/lLYK/bZsph4bqXikfqjRlzPzDs=
X-Received: by 2002:a17:906:1c12:b0:a77:cca9:b216 with SMTP id
 a640c23a62f3a-a7a011bc7d4mr147771066b.33.1721235033083; Wed, 17 Jul 2024
 09:50:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <172070450139.2992819.13210624094367257881.stgit@firesoul>
 <a4e67f81-6946-47c0-907e-5431e7e01eb1@kernel.org> <CAJD7tkYV3iwk-ZJcr_==V4e24yH-1NaCYFUL7wDaQEi8ZXqfqQ@mail.gmail.com>
 <100caebf-c11c-45c9-b864-d8562e2a5ac5@kernel.org>
In-Reply-To: <100caebf-c11c-45c9-b864-d8562e2a5ac5@kernel.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 17 Jul 2024 09:49:54 -0700
Message-ID: <CAJD7tkaBKTiMzSkXfaKO5EO58aN708L4XBS3cX85JvxVpcNkQQ@mail.gmail.com>
Subject: Re: [PATCH V7 1/2] cgroup/rstat: Avoid thundering herd problem by
 kswapd across NUMA nodes
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: tj@kernel.org, cgroups@vger.kernel.org, shakeel.butt@linux.dev, 
	hannes@cmpxchg.org, lizefan.x@bytedance.com, longman@redhat.com, 
	kernel-team@cloudflare.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2024 at 9:36=E2=80=AFAM Jesper Dangaard Brouer <hawk@kernel=
.org> wrote:
>
>
>
>
> On 17/07/2024 02.35, Yosry Ahmed wrote:
> > [..]
> >>
> >>
> >> This is a clean (meaning no cadvisor interference) example of kswapd
> >> starting simultaniously on many NUMA nodes, that in 27 out of 98 cases
> >> hit the race (which is handled in V6 and V7).
> >>
> >> The BPF "cnt" maps are getting cleared every second, so this
> >> approximates per sec numbers.  This patch reduce pressure on the lock,
> >> but we are still seeing (kfunc:vmlinux:cgroup_rstat_flush_locked) full
> >> flushes approx 37 per sec (every 27 ms). On the positive side
> >> ongoing_flusher mitigation stopped 98 per sec of these.
> >>
> >> In this clean kswapd case the patch removes the lock contention issue
> >> for kswapd. The lock_contended cases 27 seems to be all related to
> >> handled_race cases 27.
> >>
> >> The remaning high flush rate should also be addressed, and we should
> >> also work on aproaches to limit this like my ealier proposal[1].
> >
> > I honestly don't think a high number of flushes is a problem on its
> > own as long as we are not spending too much time flushing, especially
> > when we have magnitude-based thresholding so we know there is
> > something to flush (although it may not be relevant to what we are
> > doing).
> >
>
> We are "spending too much time flushing" see below.
>
> > If we keep observing a lot of lock contention, one thing that I
> > thought about is to have a variant of spin_lock with a timeout. This
> > limits the flushing latency, instead of limiting the number of flushes
> > (which I believe is the wrong metric to optimize).
> >
> > It also seems to me that we are doing a flush each 27ms, and your
> > proposed threshold was once per 50ms. It doesn't seem like a
> > fundamental difference.
> >
>
>
> Looking at the production numbers for the time the lock is held for level=
 0:
>
> @locked_time_level[0]:
> [4M, 8M)     623 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@               |
> [8M, 16M)    860 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
> [16M, 32M)   295 |@@@@@@@@@@@@@@@@@                                   |
> [32M, 64M)   275 |@@@@@@@@@@@@@@@@                                    |
>
> The time is in nanosec, so M corresponds to ms (milliseconds).
>
> With 36 flushes per second (as shown earlier) this is a flush every
> 27.7ms.  It is not unreasonable (from above data) that the flush time
> also spend 27ms, which means that we spend a full CPU second flushing.
> That is spending too much time flushing.
>
> This around 1 sec CPU usage for kswapd is also quite clear in the
> attached grafana graph for when server was rebooted into this V7 kernel.
>
> I choose 50ms because at the time I saw flush taking around 30ms, and I
> view the flush time as queue service-time.  When arrival-rate is faster
> than service-time, then a queue will form.  So, choosing 50ms as
> arrival-rate gave me some headroom.  As I mentioned earlier, optimally
> this threshold should be dynamically measured.

Thanks for the data. Yeah this doesn't look good.

Does it make sense to just throttle flushers at some point to increase
the chances of coalescing multiple flushers?

Otherwise I think it makes sense in this case to ratelimit flushing in
general. Although instead of just checking how much time elapsed since
the last flush, can we use something like __ratelimit()?

This will make sure that we skip flushes when we actually have a high
rate of flushing over a period of time, not because two flushes
happened to be requested in close succession and the flushing rate is
generally low.

>
> --Jesper

